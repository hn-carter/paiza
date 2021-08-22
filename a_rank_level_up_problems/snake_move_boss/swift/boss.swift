/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「座標系での向きの変わる移動」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_move_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 座標
struct Position {
    var Y: Int
    var X: Int
    // 向き N S E W
    var D: String
    // 渡された方向に移動する
    mutating func Move(dir: String) {
        let nextD: [String] = ["N","E","S","W"]
        var step: Int = 0
        if (dir == "R") {
            step = 1
        } else {
            step = -1
        }
        var index: Int = 0
        switch self.D {
        case "N":
            self.X += step
        case "E":
            self.Y += step
            index = 1
        case "S":
            self.X -= step
            index = 2
        case "W":
            self.Y -= step
            index = 3
        default:
            break
        }
        self.D = nextD[(index + 4 + step) % 4]
    }
}

// メイン関数
func main() {
    // 1 行目には、開始時点の x , y 座標を表す X , Y, 移動の回数 N が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let x = Int(items[0])!
    let y = Int(items[1])!
    let n = Int(items[2])!
    var current = Position(Y: y, X: x, D: "N")
    // 続く N 行 (1 ≦ i ≦ N) には、盤面の i 回目の移動の向きを表す文字 d_i が与えられます。
    // d は、L, R のいずれかでそれぞれ 左・右 に １ マス進むことを表す。
    var d: [String] = []
    for _ in 0..<n {
        d.append(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    // 移動
    for d1 in d {
        current.Move(dir: d1)
        // 結果出力
        print("\(current.X) \(current.Y)")
    }
}

// エントリーポイント
main()