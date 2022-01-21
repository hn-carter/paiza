/*
これはpaizaラーニングの「DPメニュー」の「【部分和】部分和問題 4」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_partial_sums_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1行目に、おもりの個数 n と目標とする重さの和 x が半角スペース区切りで与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let x = Int(items[1])!
    // 続く n 行のうち i 行目では、おもり i の重さ a_i が与えられます。
    var a: [Int] = [Int](repeating: 0, count: n)
    for i in 0..<n {
        a[i] = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    }

    // 重さを添字とした配列dpを初期化する
    var dp: [Bool] = [Bool](repeating: false, count: x+1)
    // おもりの合計を 0 にするには 0 個の重りを使う
    dp[0] = true
    // おもり i までのおもりを使って
    found: for i in 0..<n {
        // 重さの和を j とすることができるか？
        // 使える重りの数に制限がないため使う重りの重さから求めたい重さまでチェックする
        if a[i] <= x {
            for j in a[i]...x {
                // 配列が求めたい重さ j から 追加する重さ a_i を引いたときに
                // 作れる重さならカウント
                if dp[j - a[i]] {
                    dp[j] = true
                    // 求めたい重さが作れたら全てのループを抜ける
                    if j == x {
                        break found
                    }
                }
            }
        }
    }
    // 結果出力
    if dp[x] {
        print("yes")
    } else {
        print("no")
    }
}

// エントリーポイント
main()