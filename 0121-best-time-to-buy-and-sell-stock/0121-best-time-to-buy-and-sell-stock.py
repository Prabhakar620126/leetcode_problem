class Solution:
    def maxProfit(self, prices: list[int]) -> int:
        profit=0
        mini=prices[0]
        for i in prices[1:]:
            if i>mini:
                diff=i-mini
                
                profit=max(profit,diff)
            mini=min(mini,i)

        return profit 
