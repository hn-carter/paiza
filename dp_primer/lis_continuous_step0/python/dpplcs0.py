# これはpaizaラーニングの問題集にある「DPメニュー」-「最長増加連続部分列」
# https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_step0
# にPython3でチャレンジしたコードです。
#
# 作成環境
# Ubuntu 20.04.2 LTS
# Python 3.8.10

# 人数 n
n = int(input())
# 身長 a_n
a = [int(input()) for i in range(n)]
# 動的計画法で問題を解く
dp = list(range(n))
dp[0] = 1
for i in range(1, n):
    if a[i-1] <= a[i]:
        dp[i] = dp[i-1] + 1
    else:
        dp[i] = 1
# 結果出力
print(max(dp))