/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「規則的な数列の和」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_calculation_exchange_700

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    //  2 つの整数 N , K が半角スペース区切りで 1 行で入力されます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int64(items[0])!
    let k = Int64(items[1])!
    // 規則的な無限数列 A = [1 , 0 , -1 , 1 , 0 , -1 , ... ] の N 要素目から K 要素目までの和を計算
    let a: [Int] = [1, 0, -1]
    var start = Int((n-1) % 3)
    let end = Int((k-1) % 3)
    var sum = 0
    while true {
        sum += a[start]
        if start == end {
            break
        } else {
            start = (start + 1) % 3
        }
    }
    // 結果出力
    print(sum)
}

// エントリーポイント
main()