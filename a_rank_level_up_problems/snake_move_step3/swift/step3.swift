/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「座標系での移動・向き」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_move_step3

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 座標
struct Position {
    var Y: Int
    var X: Int
    // 向き N,S,E,W
    var D: String
    // 渡された方向に移動する
    mutating func Move(vec: String) {
        if vec == "L" {
            switch self.D {
            case "N":
                self.X -= 1
            case "S":
                self.X += 1
            case "E":
                self.Y -= 1
            case "W":
                self.Y += 1
            default:
                break
            }
        } else if vec == "R" {
            switch self.D {
            case "N":
                self.X += 1
            case "S":
                self.X -= 1
            case "E":
                self.Y += 1
            case "W":
                self.Y -= 1
            default:
                break
            }
        }
    }
}

// メイン関数
func main() {
    // 1 行目には、開始時点の y , x 座標を表す Y , X,　現在の向いている方角を表す文字 D が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let y = Int(items[0])!
    let x = Int(items[1])!
    let d = String(items[2])
    var current = Position(Y: y, X: x, D: d)
    // 2 行目には、移動の向きを表す文字 d が与えられます。
    // d は、L, R のいずれかでそれぞれ 左・右 に １ マス進むことを表す。
    let direction = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
    // 移動
    current.Move(vec: direction)
    // 結果出力
    print("\(current.Y) \(current.X)")
}

// エントリーポイント
main()