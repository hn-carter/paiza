/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「座標系での規則的な移動」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_move_step4

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 座標
struct Position {
    var Y: Int
    var X: Int
    // 渡された方向に移動する
    mutating func Move(num: Int) {
        var step: Int = 1
        var limit: Int = 1
        var c: Int = 1
        // 移動方向 0:東 1:南 2:西 3:北
        var d = 0
        for i in 1...num {
            // 移動マス数
            if i > limit {
                limit += step
                c += 1
                if c % 2 == 0 {
                    step += 1
                }
                // 移動方向変更
                d += 1
                d = d % 4
            }
            switch d {
            case 0:
                self.X += 1
            case 1:
                self.Y += 1
            case 2:
                self.X -= 1
            case 3:
                self.Y -= 1
            default:
                break
            }
        }
    }
}

// メイン関数
func main() {
    // 1 行で、開始時点の x , y 座標を表す X , Y, 移動の歩数 N が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let x = Int(items[0])!
    let y = Int(items[1])!
    let n = Int(items[2])!
    var current = Position(Y: y, X: x)
    // 移動
    current.Move(num: n)
    // 結果出力
    print("\(current.X) \(current.Y)")
}

// エントリーポイント
main()