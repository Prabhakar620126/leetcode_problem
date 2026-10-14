class Solution:
    def isPalindrome(self, s: str) -> bool:
        st=''
        for ch in s:
            if ch.isalnum():
                st=st+ch.lower()
        if st==st[::-1]:
            return True 
        else: 
            return False
        