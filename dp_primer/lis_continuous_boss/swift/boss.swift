/*
これはpaizaラーニングの問題集にある「DPメニュー」-「【連続列】最長減少連続部分列」
https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_boss
にSwiftでチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE)
*/

import Foundation

// 1行目に、横一列に並んでいる人の人数 n が与えられます。
let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
// 続く n 行のうち i 行目では、人 i の身長 a_i が与えられます。
var a = Array<Int>(repeating: 0, count: n)
for i in 0..<n {
    a[i] = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
}
// 動的計画法で問題を解く
var dp = Array<Int>(repeating: 0, count: n)
dp[0] = 1
for i in 1..<n {
    if a[i-1] >= a[i] {
        dp[i] = dp[i-1] + 1
    } else {
        dp[i] = 1
    }
}
// 結果出力
print(dp.max()!)
