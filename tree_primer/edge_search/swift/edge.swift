/*
これはpaizaラーニングの「木のメニュー」-「辺の有無の判定」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__edge_search

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目には、頂点の数 N と有無を判定したい辺の個数 K が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let k = Int(items[1])!
    // 続く N-1 行では、木を構成する各辺の両端の頂点 a_i , b_i が与えられます。(1 ≦ i ≦ N-1)
    var adjacencyMatrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for _ in 1..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsG[0])!
        let b = Int(itemsG[1])!
        adjacencyMatrix[a-1][b-1] = 1
        adjacencyMatrix[b-1][a-1] = 1
    }
    // 続く K 行では、有無を判定したい辺の頂点の組 qa_i , qb_i が与えられます。(1 ≦ i ≦ K)
    var isEdge: [Bool] = [Bool](repeating: false, count: k)
    for i in 0..<k {
        let itemsE = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsE[0])!
        let b = Int(itemsE[1])!
        if adjacencyMatrix[a-1][b-1] > 0 {
            isEdge[i] = true
        }
    }
    // 結果出力
    for e in isEdge {
        if e {
            print("YES")
        } else {
            print("NO")
        }
    }
}

// エントリーポイント
main()