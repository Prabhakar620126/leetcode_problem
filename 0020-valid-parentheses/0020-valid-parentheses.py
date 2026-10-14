class Solution:
    def isValid(self, s: str) -> bool:
        # stack=[]
        # for ch in s:
        #     if ch in ('(','{','['):
        #         stack.append(ch)
        #     else:
        #         if not stack:
        #             return False
        #         elif ch==')' and stack[-1]=='(':
        #             stack.pop()
        #         elif ch=='}' and stack[-1]=='{':
        #             stack.pop()
        #         elif ch==']' and stack[-1]=='[':
        #             stack.pop()
        #         else:
        #             return False
            
        # return len(stack)==0

        
        stack = []
        pairs = {')': '(', '}': '{', ']': '['}

        for ch in s:
            if ch in "({[":
                stack.append(ch)
            else:
                if not stack or stack.pop() != pairs[ch]:
                    return False

        return not stack
