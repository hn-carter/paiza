/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「最短の区間」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_twopointers_step3

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目には、数列 A の要素数 N と、条件に使う整数 M が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let m = Int(items[1])!
    // 2 行目には、数列 A の各要素 A_1, A_2 ... A_N が与えられます。
    var a: [Int] = [Int](repeating: 0, count: n)
    let itemsA = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    for i in 0..<n {
        a[i] = Int(itemsA[i])!
    }
    // 最短の区間の長さを計算
    var minLen = n + 1
    var lpos = 0
    var rpos = 0
    var sum = a[0]
    while true {
        if sum >= m {
            // 合計値 sum が条件 M 以上なら和を求めた区間長を判定する
            let curLne = rpos - lpos + 1
            if minLen > curLne {
                // 最短を更新
                minLen = curLne
            }
            // 合計値 sum が条件 M 以上となったので一番左端の値を減算する
            sum -= a[lpos]
            lpos += 1
        } else {
            // まだ合計値 sum が条件 M 未満なので右に区間を伸ばす
            rpos += 1
            // 右端にたどり着いたら終了
            if rpos >= n {
                break
            } else {
                // 合計値 sum を更新
                sum += a[rpos]
            }
        }
    }        
    // 結果出力
    if minLen == (n+1) {
        print("-1")
    } else {
        print(minLen)
    }
}

// エントリーポイント
main()