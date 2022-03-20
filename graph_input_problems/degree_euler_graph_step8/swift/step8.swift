/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「準オイラーグラフ・有向グラフ」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__degree_euler_graph_step8

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
    // 弱連結な有向グラフにおいて、すべての辺を一筆書きすることができるための
    // 必要十分条件は以下のいずれかを満たすことです。
    // ・すべての頂点において、入次数と出次数が一致する。
    // ・以下の条件をすべて満たす。
    // ・(入次数) = (出次数 + 1) となる頂点がちょうど 1 つ存在する。
    // ・(入次数 + 1) = (出次数) となる頂点がちょうど 1 つ存在する。
    // ・残りのすべての頂点について、入次数と出次数が一致する。
    var isSame: Bool = true
    var oneManyIn: Int = 0
    var oneManyOut: Int = 0
    for i in 0..<n {
        if indegree[i] != outdegree[i] {
            isSame = false
            if (indegree[i] - outdegree[i]) == 1 {
                oneManyIn += 1
            } else if (outdegree[i] - indegree[i]) == 1 {
                oneManyOut += 1
            }
        }
    }
    // すべての辺を一筆書きすることができる場合は 1, そうでない場合は 0 
    var answer: Int
    if isSame || (oneManyIn == 1 && oneManyOut == 1) {
        answer = 1
    } else {
        answer = 0
    }
    // 結果出力
    print(answer)
}

// エントリーポイント
main()