class Solution:
    def maxSubArray(self, nums: list[int]) -> int:
        maxi=nums[0]
        curr=nums[0]
        for i in nums[1:]:
            curr=max(curr+i, i)
            maxi=max(maxi, curr)
        return maxi