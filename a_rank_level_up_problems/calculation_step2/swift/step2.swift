/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「べき乗の計算」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_calculation_step2

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// X の Y 乗を Z で割った余りを計算する
func compute(X: Int64, Y: Int64, Z: Int64) -> Int64 {
    var x = X
    var y = Y
    // 繰り返し二乗法で答えを求める
    var ans: Int64 = 1
    while y > 0 {
        if y % 2 == 1 {
            // Yの最下位ビットが1なら(x^(2^ループ回数))をかける
            ans = ans * x % Z
        }
        // X^(2^ループ回数)
        x = x * x % Z
        // Yをビットシフトする
        y /= 2
    }
    return ans
}

// メイン関数
func main() {
    // 整数 N が 1 行で与えられます。
    let n = Int64(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!

    // 計算
    // 1000003 は指数表記で 1e6 + 3 で表せられます
    let z = Int64(1e6 + 3)
    let answer = compute(X: 2, Y: n, Z: z)

    // 結果出力
    print(answer)
}

// エントリーポイント
main()