class Solution:
    def longestCommonPrefix(self, strs: list[str]) -> str:
        if not strs:
            return ""
        st=strs[0]
        for s in strs[1:]:
            i=0
            while i < len(st) and i < len(s) and st[i] == s[i]:
                i+=1
            st=st[:i]
        if not st:
            return ""
        return st 


        