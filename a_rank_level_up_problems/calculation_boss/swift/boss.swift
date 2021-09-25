/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「最大公約数」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_calculation_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 最大公約数を返す
func gcd(a: Int, b: Int) -> Int {
    // ユークリッドの互除法で求める
    if b == 0 {
        return a
    } else {
        return gcd(a: b, b: a % b)
    }
}

// メイン関数
func main() {
    //  最大公約数を求める 2 つの整数 A , B が 1 行で与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let a = Int(items[0])!
    let b = Int(items[1])!
    // 最大公約数
    let answer = gcd(a: a, b: b)
    // 結果出力
    print(answer)
}

// エントリーポイント
main()