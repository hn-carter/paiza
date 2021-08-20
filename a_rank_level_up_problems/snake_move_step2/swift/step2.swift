/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「座標系での移動・方角」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_move_step2

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 座標
struct Position {
    var Y: Int
    var X: Int
    // 渡された方向に維持雨する
    mutating func Move(vec: Position) {
        self.Y += vec.Y
        self.X += vec.X
    }
}

// メイン関数
func main() {
    // 1 行目には、開始時点の y , x 座標を表す Y , X, 移動の回数 N が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let y = Int(items[0])!
    let x = Int(items[1])!
    let n = Int(items[2])!
    let start = Position(Y: y, X: x)
    // 続く N 行 (1 ≦ i ≦ N) には、盤面の i 回目の移動の方角を表す文字 d_i が与えられます。
    var d: [String] = []
    for _ in 1...n {
        d.append(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    // 移動 N, S, E, W
    var current = start
    // 移動芳香文字がvecStrから見つかった位置が、移動量配列vectorの添字
    let vecStr = "NSEW"
    let vector: [Position] = [
        Position(Y: -1, X: 0),
        Position(Y: 1, X: 0),
        Position(Y: 0, X: 1),
        Position(Y: 0, X: -1)
    ]
    for direction in d {
        // 方向文字列から行きたい方向の位置(String.Index)を取得する
        if let pos = vecStr.firstIndex(of: direction.first!) {
            // String.Index を Intに変換するためdistanceを呼び出す
            let idx: Int = vecStr.distance(from: vecStr.startIndex, to: pos)
            current.Move(vec: vector[idx])
            // 結果出力
            print("\(current.Y) \(current.X)")
        }
    }
}

// エントリーポイント
main()