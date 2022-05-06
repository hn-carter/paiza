/*
これはpaizaラーニングの「木のメニュー」-「木の中心」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__center_of_tree

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目には、頂点の数 N が与えられます。
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 続く N-1 行では、各辺の両端の頂点 a_i , b_i が与えられます。(1 ≦ i ≦ N-1)
    var graphList: [[Int]] = [[Int]](repeating: Array(), count: n)
    for _ in 1..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        var a = Int(itemsG[0])!
        var b = Int(itemsG[1])!
        a -= 1
        b -= 1
        // 頂点につながる頂点を保存する
        graphList[a].append(b)
        graphList[b].append(a)
    }
    // 頂点数が2以上（葉ではない）の頂点の数
    var numberOfVertex = n
    // 頂点毎の葉かどうかを表すフラグ
    var isLeaf: [Bool] = [Bool](repeating: false, count: n)
    // 頂点が2以下になるまで葉を取り除いていく
    while 2 < numberOfVertex {
        // 次数が1なら葉なので除去する
        for i in 0..<n {
            if graphList[i].count == 1 {
                numberOfVertex -= 1
                isLeaf[i] = true
                graphList[i].removeAll()
            }
        }
        // 頂点のリストから葉を取り除く
        for i in 0..<n {
            for j in (0..<graphList[i].count).reversed() {
                if isLeaf[graphList[i][j]] {
                    graphList[i].remove(at: j)    
                }
            }
        }
    }
    // 木の中心を出力
    for i in 0..<n {
        if !isLeaf[i] {
            print(i+1)
        }
    }
}

// エントリーポイント
main()