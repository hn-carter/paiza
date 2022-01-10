/*
これはpaizaラーニングの問題集にある「日付セット」-「閏年の判定」
https://paiza.jp/works/mondai/dateset/leap_year
にSwiftでチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE)
*/

import Foundation

// 1行目に、西暦yが与えられます。
let y = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
// うるう年判定
var isLeap: Bool = false
if (y % 4 == 0 && y % 100 != 0) || y % 400 == 0 {
    isLeap = true
}
// 結果出力
if isLeap {
    print("Yes")
} else {
    print("No")
}
