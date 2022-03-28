/*
これはpaizaラーニングの「木のメニュー」-「木の入力の受け取り（隣接リスト）」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__adjacency_list_input

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目には、頂点の数 N が与えられます。
    let item = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
    let n = Int(item)!
    // 続く N-1 行では、各辺の両端の頂点 a_i , b_i が与えられます。(1 ≦ i ≦ N-1)
    var adjacencyMatrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for _ in 1..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsG[0])!
        let b = Int(itemsG[1])!
        adjacencyMatrix[a-1][b-1] += 1
        adjacencyMatrix[b-1][a-1] += 1
    }
    // 結果出力
    for y in 0..<n {
        var notFirst: Bool = false
        for x in 0..<n {
            if adjacencyMatrix[y][x] > 0 {
                if notFirst {
                    print(" ", terminator: "")
                }
                print(x + 1, terminator: "")
                notFirst = true
            }
        }
        print("")
    }
}

// エントリーポイント
main()