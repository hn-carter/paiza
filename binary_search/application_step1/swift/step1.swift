/*
これはpaizaラーニングの「二分探索メニュー」から「効率よく盗もう」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/binary_search/binary_search__application_step1

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

struct Treasure {
    // 重さ
    var weight: Double = 0.0
    // 価値
    var value: Double = 0.0
}

// メイン関数
func main() {
    // 1行目に、財宝の個数 n と、盗み出す財宝の個数 k が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let k = Int(items[1])!
    // 2行目に、財宝の重さ W_i が半角スペース区切りで与えられます。
    var treasure: [Treasure] = [Treasure](repeating: Treasure(), count: n)
    let itemsW = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    for i in 0..<n {
        treasure[i].weight = Double(itemsW[i])!
    }
    // 3行目に、財宝の価値 V_i が半角スペース区切りで与えられます。
    let itemsV = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    for i in 0..<n {
        treasure[i].value = Double(itemsV[i])!
    }
    // 答えを求める
    var left: Double = 0.0
    var right: Double = 5001.0
    var mid: Double = 0.0
    for _ in 0..<50 {
        mid = (left + right) / 2.0
        // print(String(format: "left= %f right= %f mid= %f", left, right, mid))
        var tmp: [Double] = [Double](repeating: 0.0, count: n)
        for j in 0..<n {
            tmp[j] = treasure[j].value - (treasure[j].weight * mid)
        }
        // 重さあたりの価値を降順にソートして高価な k 個の財宝の価値を求める
        tmp.sort { $0 > $1 }
        var sum: Double = 0.0
        for j in 0..<k {
            sum += tmp[j]
        }
        if sum >= 0 {
            // 財宝の価値は mid よりも大きいので更に増やす
            left = mid
        } else {
            right = mid
        }
    }
    // 結果出力
    print(left)
}

// エントリーポイント
main()
