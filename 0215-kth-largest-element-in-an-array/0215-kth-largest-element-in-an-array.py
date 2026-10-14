import heapq
class Solution:
    def findKthLargest(self, nums: list[int], k: int) -> int:
        # for _ in range(k-1):
        #     nums.remove(max(nums))
        # return max(nums)

        # nums.sort(reverse=True)
        # return nums[k - 1]

        # return heapq.nlargest(k, nums)[-1]

        heap=[]
        for num in nums:
            heapq.heappush(heap,num)
            if len(heap)>k:
                heapq.heappop(heap)
        return heap[0]


        