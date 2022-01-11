/*
これはpaizaラーニングの問題集にある「日付セット」-「西暦の和暦変換」
https://paiza.jp/works/mondai/dateset/ad_to_era
にSwiftでチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE)
*/

import Foundation

// メイン関数
func main() {

    // 1行で、西暦年y、月m、日付dが与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let y = Int(items[0])!
    let m = Int(items[1])!
    let d = Int(items[2])!
    // 和暦判定
    let ymd = y * 10000 + m * 100 + d
    var era: String = ""
    if ymd <= 19120729 {
        era = "明治"
    } else if ymd <= 19261224 {
        era = "大正"
    } else if ymd <= 19890107 {
        era = "昭和"
    } else if ymd <= 20190430 {
        era = "平成"
    } else {
        era = "令和"
    }
    // 結果文字列
    let result = "\(era)年\(m)月\(d)日"
    // 結果出力
    print(result)
}

// エントリーポイント
main()
