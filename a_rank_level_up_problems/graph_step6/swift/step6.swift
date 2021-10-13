/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の
「りんご拾い（情報を持ちながらの移動）」にswiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_graph_step6
作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

struct Graph {
    var a: Int
    var b: Int
    var x: Bool
}

// メイン関数
func main() {
    //  1 行目には、グラフの頂点の数 N が与えられます。
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 続く N-1 行では、各辺の両端の頂点 a_i , b_i が与えられます。(1 ≦ i ≦ N-1)
    var graph: [Graph] = [Graph]()
    for _ in 1..<n {
        let itemsI = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsI[0])!
        let b = Int(itemsI[1])!
        graph.append(Graph(a: a, b: b, x: false))
    }
    // 続く N 行では、各頂点にあるりんごの数 A_j が与えられます。 (1 ≦ j ≦ N)
    var num: [Int] = [Int]()
    for _ in 0..<n {
        let a = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
        num.append(a)
    }
    // 1 からスタート
    var point = 1
    // 通過ごとのりんごの数
    var sum = [Int]()
    let graphLen = graph.count
    var goonFlag = true
    while goonFlag {
        goonFlag = false
        if sum.count > 0 {
            sum.append(sum.last! + num[point-1])
        } else {
            sum.append(num[point-1])
        }

        for i in 0..<graphLen {
            if !graph[i].x {
                if graph[i].a == point {
                    point = graph[i].b
                    graph[i].x = true
                    goonFlag = true
                    break
                } else if graph[i].b == point {
                    point = graph[i].a
                    graph[i].x = true
                    goonFlag = true
                    break
                }
            }
        }
    }
    // 結果出力
    for i in sum {
        print(i)
    }
}

// エントリーポイント
main()