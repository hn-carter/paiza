/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「裏返せる可能性（斜め）」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_pincerattack_step3

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 座標
struct Position {
    var Y: Int
    var X: Int
}

// マップ
struct World {
    // マップの大きさ
    var H: Int
    var W: Int
    // マップ
    var s: [[Character]]

    init(h: Int, w: Int) {
        self.H = h
        self.W = w
        self.s = []
        let str = String(repeating: ".", count: w)
        for _ in 0..<h {
            self.s.append(Array(str))
        }
    }
    // 石を置く
    mutating func Put(y: Int, x: Int) {
        if 0 <= y && y < self.H && 0 <= x && x < self.W {
            self.s[y][x] = "!"
            self.take(py: y, px: x)
        }
    }
    // 裏返す
    mutating func take(py: Int, px: Int) {
        // 斜めに拡張
        let able: [Position] = [Position(Y: -1, X: -1), Position(Y: 1, X: 1),
                                Position(Y: -1, X: 1), Position(Y: 1, X: -1)]
        for a in able {
            var ty = py + a.Y
            var tx = px + a.X
            // マップの範囲内チェック
            while 0 <= ty && ty < self.H && 0 <= tx && tx < self.W {
                // 陣取りチェック
                self.s[ty][tx] = "*"
                ty += a.Y
                tx += a.X
            }
        }
    }
    // 出力
    func Print() {
        for y in 0..<self.H {
            for x in 0..<self.W {
                print(self.s[y][x], terminator: "")
            }
            print("")
        }
    }
 }

// メイン関数
func main() {
    // 出力する盤面の行数 H , 列数 W と石を置くマスの y , x 座標である Y , X が 1 行で与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let h = Int(items[0])!
    let w = Int(items[1])!
    let y = Int(items[2])!
    let x = Int(items[3])!
    // 盤面初期化
    var current = World(h: h, w: w)
    // 石を置く
    current.Put(y: y, x: x)
    // 結果出力
    current.Print()
}

// エントリーポイント
main()