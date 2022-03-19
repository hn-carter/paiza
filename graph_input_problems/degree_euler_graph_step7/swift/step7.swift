/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「オイラーグラフ・有向グラフ」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__degree_euler_graph_step7

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目に、頂点の個数を表す整数 n と、頂点の組の個数を表す整数 m が半角スペース区切りで与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let m = Int(items[1])!
    // 続く m 行では、頂点の組 a_i, b_i が半角スペース区切りで与えられます。(1 ≦ i ≦ m)
    var adjacencyMatrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for _ in 0..<m {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsG[0])!
        let b = Int(itemsG[1])!
        adjacencyMatrix[a-1][b-1] += 1
    }
    // 頂点vから出ている辺の数
    var outdegree: [Int] = [Int](repeating: 0, count: n)
    for i in 0..<n {
        for j in 0..<n {
            outdegree[i] += adjacencyMatrix[i][j]
        }
    }
    // 頂点vに向かっている辺の数
    var indegree: [Int] = [Int](repeating: 0, count: n)
    for i in 0..<n {
        for j in 0..<n {
            indegree[i] += adjacencyMatrix[j][i]
        }
    }
    // 弱連結な有向グラフにおいて、ある頂点から始めてすべての辺を一筆書きして
    // 最初の頂点に戻ってくることができるための必要十分条件は以下のようになります。
    // ・すべての頂点において、入次数と出次数が一致する。
    var answer: Int = 1
    for i in 0..<n {
        if indegree[i] != outdegree[i] {
            answer = 0
            break
        }
    }
    // 結果出力
    print(answer)
}

// エントリーポイント
main()