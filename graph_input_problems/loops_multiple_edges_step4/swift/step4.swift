/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「多重辺・有向グラフ」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__loops_multiple_edges_step4

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

struct Graph {
    // 頂点a
    var a: Int
    // 頂点b
    var b: Int
}

// メイン関数
func main() {
    // 1 行目に、頂点の個数を表す整数 n が与えられます。
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 続く n 行では、隣接行列の上から i 行目の n 個の整数が左から順に半角スペース区切りで与えられます。(1 ≦ i ≦ n)
    var adjacencyMatrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for y in 0..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        for x in 0..<n {
            let a = Int(itemsG[x])!
            adjacencyMatrix[y][x] = a
        }
    }
    // 多重辺の判定
    var multipleEdges: [Graph] = [Graph]()
    for y in 0..<n {
        for x in y..<n {
            if adjacencyMatrix[y][x] > 1 || adjacencyMatrix[x][y] > 1 ||
               (adjacencyMatrix[y][x] == 1 && adjacencyMatrix[x][y] == 1) {
                multipleEdges.append(Graph(a: y+1, b: x+1))
            }
        }
    }
    // 結果出力
    print(multipleEdges.count)
    for g in multipleEdges {
        print("\(g.a) \(g.b)")
    }
}

// エントリーポイント
main()