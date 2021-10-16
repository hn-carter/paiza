/*
これはpaizaラーニングの「二分探索メニュー」の「値の探索」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/binary_search/binary_search__basic_step0
作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// ソート済みの数列 A に 値 k が含まれているなら true を、含まれていないなら false を返す
// A : 数列, n : 数列のサイズ, k : 探索する値
func binary_search(A: [Int], n: Int, k: Int) -> Bool {
    // 探索範囲 [left, right]
    var left = 0
    var right = n - 1
    // 探索範囲を狭めていく
    while left <= right {
        // 探索範囲の中央
        let mid = (left + right) / 2
        if A[mid] == k {
            return true
        } else if A[mid] < k {
            left = mid+1
        } else {
            right = mid-1
        }
    }
    return false
}

// メイン関数
func main() {
    // 1行目に、数列の要素数 n が与えられます。
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 2行目に、数列の要素 A_i が半角スペース区切りで与えられます。
    var a: [Int] = [Int](repeating: 0, count: n)
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    for i in 0..<n {
        a[i] = Int(items[i])!
    }
    // 3行目に、与えられる整数の数 q が与えられます。
    let q = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 続く q 行のうち i (1 ≦ i ≦ q) 行目に、整数 k_i が与えられます。
    var k: [Int] = [Int](repeating: 0, count: q)
    for i in 0..<q {
        k[i] = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    }
    // 探索
    var ans: [String] = [String]()
    for i in 0..<q {
        if binary_search(A: a, n: n, k: k[i]) {
            ans.append("Yes")
        } else {
            ans.append("No")
        }
    }
    // 結果出力
    for s in ans {
        print(s)
    }
}

// エントリーポイント
main()