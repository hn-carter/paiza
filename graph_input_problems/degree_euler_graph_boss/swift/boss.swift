/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「しりとり」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__degree_euler_graph_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 次数を表す
struct Degree {
    var indegree: Int
    var outdegree: Int
}

// メイン関数
func main() {
    // 1 行目に、文字列の個数を表す整数 n が与えられます。
    let item = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
    let n = Int(item)!
    // 続く n 行では、文字列 s_i が与えられます。(1 ≦ i ≦ n)
    // 文字を頂点とした次数を数えるための変数定義
    var degree: [Character: Degree] = [:]
    for _ in 0..<n {
        let itemS = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
        let start = itemS[itemS.startIndex]
        let end = itemS[itemS.index(before: itemS.endIndex)]
        // 開始文字と終了文字の次数を数えます。
        if degree.keys.contains(start) {
            degree[start]!.indegree += 1
        } else {
            degree[start] = Degree(indegree: 1, outdegree: 0)
        }
        if degree.keys.contains(end) {
            degree[end]!.outdegree += 1
        } else {
            degree[end] = Degree(indegree: 0, outdegree: 1)
        }
    }
    // 準オイラーグラフかどうかの判定をします。
    var isSame: Bool = true
    var oneManyIn: Int = 0
    var oneManyOut: Int = 0
    for (_, d) in degree {
        if d.indegree != d.outdegree {
            isSame = false
            if (d.indegree - d.outdegree) == 1 {
                oneManyIn += 1
            } else if (d.outdegree - d.indegree) == 1 {
                oneManyOut += 1
            }
        }
    }
    // しりとりをすることができる場合は 1, そうでない場合は 0
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