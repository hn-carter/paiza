/*
これはpaizaラーニングの「木のメニュー」-「葉の判定」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__find_leaf

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目には、頂点の数 N が与えられます。
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 続く N-1 行では、各辺の両端の頂点 a_i , b_i が与えられます。(1 ≦ i ≦ N-1)
    var degree: [Int] = [Int](repeating: 0, count: n)
    for _ in 1..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsG[0])!
        let b = Int(itemsG[1])!
        degree[a-1] += 1
        degree[b-1] += 1
    }
    // 葉を出力
    for i in 0..<n {
        if degree[i] == 1 {
            print(i+1)
        }
    }
}

// エントリーポイント
main()