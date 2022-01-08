/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最長部分増加列」
https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_step0
にSwiftでチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE)
*/

import Foundation

// 1行目に、横一列に並んでいる木の本数 n が与えられます。
let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
// 続く n 行のうち i 行目では、木 i の高さ a_i が与えられます。
var a = Array<Int>(repeating: 0, count: n)
for i in 0..<n {
    a[i] = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
}
// 動的計画法で問題を解く
var dp = Array<Int>(repeating: 0, count: n)
dp[0] = 1
for i in 1..<n {
    // 木 i のみからなる部分列の長さ
    dp[i] = 1
    for j in 0..<i {
        if a[j] < a[i] {
            // 最後が木 j であるような増加部分列の末尾に木 i をくっつける
            dp[i] = max(dp[i], dp[j]+1)
        }
    }
}
// 結果出力
print(dp.max()!)
