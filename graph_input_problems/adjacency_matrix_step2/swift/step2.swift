/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「隣接行列の出力・有向グラフ」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__adjacency_matrix_step2

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 頂点Aから頂点Bを結ぶ辺
struct Graph {
    // 頂点A
    var a: Int
    // 頂点B
    var b: Int
}

// メイン関数
func main() {
    // 1 行目に、頂点の個数を表す整数 n と、頂点の組の個数を表す整数 m が半角スペース区切りで与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let m = Int(items[1])!
    // 続く m 行では、頂点の組 a_i, b_i が半角スペース区切りで与えられます。(1 ≦ i ≦ m)
    var graphList: [Graph] = []
    for _ in 0..<m {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsG[0])!
        let b = Int(itemsG[1])!
        let newGraph = Graph(a: a, b: b)
        graphList.append(newGraph)
    }
    // 結果の隣接行列
    var adjacencyMatrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    // 隣接行列を作成する
    for i in 0..<m {
        adjacencyMatrix[graphList[i].b-1][graphList[i].a-1] = 1
    }
    // 隣接行列を出力する
    for y in 0..<n {
        for x in 0..<n {
            if x > 0 {
                print(" ", terminator: "")    
            }
            print("\(adjacencyMatrix[x][y])", terminator: "")
        }
        print("")
    }
}

// エントリーポイント
main()