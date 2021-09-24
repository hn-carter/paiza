/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「素数判定」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_calculation_step3

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 素数判定
func isPrime(n: Int) -> Bool {
    // 1 は素数ではない
    if n == 1 {
        return false
    }
    // 2からnの平方根まで割り切れるか判定
    let max: Int = Int(sqrt(Double(n)))
    var i = 2
    while i <= max {
        if n % i == 0 {
            return false
        }
        i += 1
    }
    // 割り切れないので素数
    return true
}

// メイン関数
func main() {
    //  整数 N が 1 行で与えられます。
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 素数判定
    if isPrime(n: n) {
        print("YES")
    } else {
        print("NO")
    }
}

// エントリーポイント
main()