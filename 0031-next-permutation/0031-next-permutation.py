class Solution:
    def nextPermutation(self, nums: list[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        n= len(nums)
        index=-1
        for i in range(n-1,-1,-1):
            if nums[i-1]<nums[i]:
                index=i-1
                break
        if index != -1:
            for i in range(n-1,index,-1):
                if nums[index]<nums[i]:
                    nums[index],nums[i]=nums[i],nums[index]
                    break
        
        nums[index + 1:] = nums[index + 1:][::-1]
        