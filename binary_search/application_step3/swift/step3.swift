/*
これはpaizaラーニングの「二分探索メニュー」から「太巻きを分けよう (おなかいっぱい)」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/binary_search/binary_search__application_step3

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1行目に、太巻きの長さ L と、分け合う人数 n と、切れ目の数 k が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let L = Int(items[0])!
    let n = Int(items[1])!
    let k = Int(items[2])!
    // 2行目に、切れ目 A_i が半角スペース区切りで与えられます。
    var a: [Int] = [Int](repeating: 0, count: k + 2)
    let itemsA = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    for i in 0..<k {
        a[i+1] = Int(itemsA[i])!
    }
    a[k+1] = L // 切れ目配列の最後に全体の長さをセット
    // 答えを求める
    var left: Int = 1
    for i in 1...k+1 {
        left = max(left, a[i] - a[i-1])
    }
    left -= 1
    var right: Int = L
    var mid: Int = 0
    while (right - left) > 1 {
        mid = (left + right) / 2
        //print(String(format: "left= %d right= %d mid= %d", left, right, mid))
        // 切れ目配列の処理位置
        var lastClack: Int = 0
        var index: Int = 0
        // 分割出来た数
        var num: Int = 0
        while true {
            while index+1 < a.count && a[index+1] - lastClack <= mid {
                index += 1
            }
            num += 1
            if (index == a.count - 1) {
                break
            }
            lastClack = a[index]
        }
        if num > n {
            left = mid
        } else {
            right = mid
        }
    }
    // 結果出力
    print(right)
}

// エントリーポイント
main()
