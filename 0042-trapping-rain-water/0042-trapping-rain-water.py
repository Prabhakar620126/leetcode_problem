class Solution:
    def trap(self, height: list[int]) -> int:
        n=len(height)
        left_prefix=[0]*n
        left_prefix[0]=height[0]
        water=0
        for i in range(1,n):
            left_prefix[i]=max(left_prefix[i-1],height[i])
        right_prefix=[0]*n
        right_prefix[n-1]=height[-1]
        for i in range(n-2,-1,-1):
            right_prefix[i]=max(right_prefix[i+1],height[i])
        
        for i in range(n):
            hig=min(left_prefix[i],right_prefix[i])
            water +=(hig-height[i])

        return water



        