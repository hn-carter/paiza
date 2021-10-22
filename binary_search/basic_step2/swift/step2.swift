/*
これはpaizaラーニングの「二分探索メニュー」の「upper_bound」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/binary_search/binary_search__basic_step2
作成環境
macOS Big Sur バージョン 11.6
Apple Swift version 5.5 (swiftlang-1300.0.31.1 clang-1300.0.29.1)
Target: x86_64-apple-darwin20.6.0
*/
import Foundation

// ソート済みの数列 A で 値 k を超える添字を返す
// 超える値が存在しない場合には n を返す
// A : 数列, n : 数列のサイズ, k : 探索する値
func binary_search(A: [Int], n: Int, k: Int) -> Int {
    // 探索範囲 [left, right]
    var left = 0
    var right = n
    // 探索範囲を狭めていく
    while left < right {
        // 探索範囲の中央
        let mid = (left + right) / 2
        if A[mid] <= k {
            // a[0]からa[mid]は不合格確定
            left = mid+1
        } else {
            right = mid
        }
    }
    return right
}

// メイン関数
func main() {
    // 1行目に、生徒の人数 n が与えられます。
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 2行目に、採点結果 A_i が半角スペース区切りで与えられます。
    var a: [Int] = [Int](repeating: 0, count: n)
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    for i in 0..<n {
        a[i] = Int(items[i])!
    }
    // 3行目に、合格点の候補数 q が与えられます。
    let q = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 続く q 行のうち i (1 ≦ i ≦ q) 行目に、合格点の候補 k_i が与えられます。
    var k: [Int] = [Int](repeating: 0, count: q)
    for i in 0..<q {
        k[i] = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    }

    // 点数をソート
    a.sort()
    // 探索
    // 合格者数
    var pass: [Int] = [Int]()
    for i in k {
        pass.append(n - binary_search(A: a, n: n, k: i))
    }
    // 結果出力
    for v in pass {
        print(v)
    }
}

// エントリーポイント
main()

