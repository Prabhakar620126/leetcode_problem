class Solution:
    def maxProduct(self, nums: list[int]) -> int:
        n=len(nums)
        currmax_pro=nums[0]
        currmin_pro=nums[0]
        max_pro=nums[0]
        for i in range(1,n):
            pre_max=currmax_pro
            pre_min=currmin_pro
            currmax_pro=max(pre_min*nums[i],pre_max*nums[i],nums[i])
            currmin_pro=min(pre_max*nums[i],pre_min*nums[i],nums[i])
            max_pro=max(max_pro,currmax_pro)
        return max_pro

        