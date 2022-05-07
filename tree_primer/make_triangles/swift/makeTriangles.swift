/*
これはpaizaラーニングの「木のメニュー」-「三角形を作る」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__make_triangles

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
    var adjacencyMatrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for _ in 1..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        var a = Int(itemsG[0])!
        var b = Int(itemsG[1])!
        a -= 1
        b -= 1
        adjacencyMatrix[a][b] = 1
        adjacencyMatrix[b][a] = 1
    }
    // 3つの頂点のうち1辺が結ばれていない箇所を探す
    var count = 0   // 作れる三角形の数
    for i in 0..<n {
        for j in 0..<n {
            if i != j && adjacencyMatrix[i][j] == 1 {
                for k in (j+1)..<n {
                    if adjacencyMatrix[i][k] == 1 {
                        // 3頂点の1辺が結ばれていないなら線を引ける
                        // 注）問題文では「木が書かれた紙」となっているのでこの判定は不要、
                        // 　　j、kのループをせずに頂点に接続する辺の組み合わせを数えるだけ
                        //     で解くことが出来るため無駄に処理が複雑になっています。
                        if adjacencyMatrix[j][k] == 0 {
                            count += 1
                        }
                    }
                }
            }
        }
    }
    // 作れる三角形の個数で勝敗を判定
    if count % 2 == 0 {
        print("erik")
    } else {
        print("paiza")
    }
}

// エントリーポイント
main()