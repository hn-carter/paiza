/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「隣接リストの出力・有向グラフ」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__adjacency_list_step2

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
    // 頂点とつながっている辺を求める
    var answer: [[Int]] = [[Int]](repeating: Array<Int>(), count: n)
    for g in graphList {
        answer[g.a-1].append(g.b)
    }
    // 頂点毎に出力
    for a in answer {
        if a.count == 0 {
            print("-1")
        } else {
            for i in 0..<a.count {
                if i > 0 {
                    print(" ", terminator: "")    
                }
                print(a[i], terminator: "")
            }
            print("")
        }
    }
}

// エントリーポイント
main()