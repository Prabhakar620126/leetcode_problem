class Solution:
    def productExceptSelf(self, nums: list[int]) -> list[int]:
        n=len(nums)
        forward=[0]*n
        forward[0]=nums[0]
        backward=[0]*n
        backward[n-1]= nums[n-1]
        for i in range(1,n):
            forward[i]=forward[i-1]*nums[i]
        for i in range(n-2,-1,-1):
            backward[i]=backward[i+1]*nums[i]
        res=[0]*n
        for i in range(n):
            if i==0:
                res[i]=backward[i+1]
            elif i==n-1:
                res[i]=forward[i-1]
            else:
                res[i]=forward[i-1]*backward[i+1]
        return res
            

        