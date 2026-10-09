
WITH cte AS (
    SELECT
        content_id,
        content_text,
        DATALENGTH(content_text) AS txt_len
    FROM user_content
),
cte2 AS (
    SELECT
        content_id,
        content_text,
        txt_len,
        1 AS pos,
        SUBSTRING(content_text, 1, 1) AS ch
    FROM cte
    WHERE txt_len > 0

    UNION ALL

    SELECT
        content_id,
        content_text,
        txt_len,
        pos + 1,
        SUBSTRING(content_text, pos + 1, 1)
    FROM cte2
    WHERE pos < txt_len
),
tagged AS (
    SELECT *,
        COALESCE(
            SUM(CASE WHEN ch = ' ' THEN 1 ELSE 0 END)
            OVER (
                PARTITION BY content_id
                ORDER BY pos
                ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
            ), 0
        ) AS word_id
    FROM cte2
),
ctx AS (
    SELECT *,
        LAG(ch) OVER (
            PARTITION BY content_id, word_id
            ORDER BY pos
        ) AS prev_ch
    FROM tagged
),
bounds AS (
    SELECT
        content_id,
        word_id,
        MIN(pos) AS first_pos,
        MAX(pos) AS last_pos
    FROM ctx
    WHERE ch <> ' '
    GROUP BY content_id, word_id
),
validation AS (
    SELECT
        c.content_id,
        c.word_id,
        b.first_pos,
        b.last_pos,
        MAX(CASE WHEN c.pos = b.first_pos THEN c.ch END) AS first_ch,
        SUM(CASE WHEN c.ch = '-' THEN 1 ELSE 0 END) AS hyphens,
        SUM(CASE
            WHEN c.ch COLLATE Latin1_General_BIN
                 NOT LIKE '[A-Za-z-]' THEN 1
            ELSE 0
        END) AS invalid_chars,
        SUM(CASE
            WHEN c.ch = '-' AND c.prev_ch = '-' THEN 1
            ELSE 0
        END) AS double_hyphens,
        MAX(CASE
            WHEN c.pos = b.first_pos
             AND c.ch COLLATE Latin1_General_BIN LIKE '[A-Za-z]'
            THEN 1 ELSE 0
        END) AS starts_letter,
        MAX(CASE
            WHEN c.pos = b.last_pos
             AND c.ch COLLATE Latin1_General_BIN LIKE '[A-Za-z]'
            THEN 1 ELSE 0
        END) AS ends_letter
    FROM ctx c
    JOIN bounds b
      ON c.content_id = b.content_id
     AND c.word_id = b.word_id
    WHERE c.ch <> ' '
    GROUP BY
        c.content_id, c.word_id,
        b.first_pos, b.last_pos
),
converted AS (
    SELECT
        c.content_id,
        c.content_text,
        c.pos,
        CASE
            WHEN c.ch = ' ' THEN c.ch

            -- Words starting with non-English letters stay unchanged
            WHEN v.starts_letter = 0 THEN c.ch

            -- Valid hyphenated words: capitalize each part
            WHEN v.hyphens > 0
             AND v.invalid_chars = 0
             AND v.double_hyphens = 0
             AND v.starts_letter = 1
             AND v.ends_letter = 1
            THEN
                CASE
                    WHEN c.pos = v.first_pos OR c.prev_ch = '-'
                        THEN UPPER(c.ch)
                    ELSE LOWER(c.ch)
                END

            -- Ordinary words: capitalize only the first character
            ELSE
                CASE
                    WHEN c.pos = v.first_pos
                        THEN UPPER(c.ch)
                    WHEN c.ch COLLATE Latin1_General_BIN
                         LIKE '[A-Za-z]'
                        THEN LOWER(c.ch)
                    ELSE c.ch
                END
        END AS new_ch
    FROM ctx c
    LEFT JOIN validation v
      ON c.content_id = v.content_id
     AND c.word_id = v.word_id
)
SELECT
    u.content_id,
    u.content_text AS original_text,
    COALESCE(
        STRING_AGG(c.new_ch, '')
            WITHIN GROUP (ORDER BY c.pos),
        u.content_text
    ) AS converted_text
FROM user_content u
LEFT JOIN converted c
    ON u.content_id = c.content_id
GROUP BY u.content_id, u.content_text
ORDER BY u.content_id
OPTION (MAXRECURSION 0);
