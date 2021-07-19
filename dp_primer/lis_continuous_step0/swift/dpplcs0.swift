/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最長増加連続部分列」
https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_step0
にSwiftでチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE)
*/

import Foundation

// 人数 n
let n = Int(readLine()!)!
// 身長 a_n
var a = Array<Int>(repeating: 0, count: n)
for i in 0..<n {
    a[i] = Int(readLine()!)!
}
// 動的計画法で問題を解く
var dp = Array<Int>(repeating: 0, count: n)
dp[0] = 1
for i in 1..<n {
    if a[i-1] <= a[i] {
        dp[i] = dp[i-1] + 1
    } else {
        dp[i] = 1
    }
}
// 結果出力
print(dp.max()!)