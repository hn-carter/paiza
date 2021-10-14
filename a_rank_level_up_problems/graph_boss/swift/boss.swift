/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の
「連結の判定」にswiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_graph_boss
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
    //  1 行目には頂点の数を表す整数 N , 辺の数を表す整数 M が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let m = Int(items[1])!
    // 続く M 行では、辺の両端の頂点 a_i , b_i が与えられます。 (1 ≦ i ≦ M)
    // 隣接リスト
    var adjacency_list: [[Graph]] = [[Graph]](repeating: [Graph](), count: n)
    for _ in 0..<m {
        let itemsI = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsI[0])! - 1
        let b = Int(itemsI[1])! - 1
        adjacency_list[a].append(Graph(a: a, b: b, x: false))
    }
    // 1 からスタート
    var point = 1
    // 通過した？
    var pass = [Bool](repeating: false, count: n)
    let graphLen = graph.count
    var goFlag = true
    while goFlag {
        goFlag = false
        pass[point-1] = true
        for i in 0..<graphLen {
            if !graph[i].x {
                if graph[i].a == point {
                    point = graph[i].b
                    graph[i].x = true
                    goFlag = true
                    break
                } else if graph[i].b == point {
                    point = graph[i].a
                    graph[i].x = true
                    goFlag = true
                    break
                }
            }
        }
    }
    // 結果出力
    if pass.firstIndex(of: false) == nil {
        print("Yes")
    } else {
        print("No")
    }
}

// エントリーポイント
main()