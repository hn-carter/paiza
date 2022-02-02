/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「隣接行列の入力・辺の存在判定」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__adjacency_matrix_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 頂点を結ぶ辺
struct Graph {
    // 頂点A
    var a: Int
    // 頂点B
    var b: Int
}

// メイン関数
func main() {
    // 1 行目に、頂点の個数を表す整数 n, 整数の組の個数を表す整数 q が半角スペース区切りで与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let q = Int(items[1])!
    // 続く n 行では、隣接行列の上から i 行目の n 個の整数が、半角スペース区切りで与えられます。(1 ≦ i ≦ n)
    var adjacencyMatrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for y in 0..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        for x in 0..<n {
            let a = Int(itemsG[x])!
            adjacencyMatrix[y][x] = a
        }
    }
    // 続く q 行では、頂点の組 a_i, b_i が半角スペース区切りで与えられます。(1 ≦ i ≦ q)
    var graphList: [Graph] = []
    for _ in 0..<q {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsG[0])!
        let b = Int(itemsG[1])!
        let newGraph = Graph(a: a, b: b)
        graphList.append(newGraph)
    }
    // 辺の判定
    for g in graphList {
        print(adjacencyMatrix[g.a-1][g.b-1])
    }
}

// エントリーポイント
main()
