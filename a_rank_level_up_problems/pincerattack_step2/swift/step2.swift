/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「リバーシの操作（縦横）」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_pincerattack_step2

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// マップ
struct World {
    // マップの大きさ
    var H: Int
    var W: Int
    // マップ
    var S: [[Character]]

    // 石を置く
    mutating func Put(y: Int, x: Int) {
        if 0 <= y && y < self.H && 0 <= x && x < self.W {
            self.S[y][x] = "*"
            self.take(py: y, px: x)
        }
    }
    // 裏返す
    mutating func take(py: Int, px: Int) {
        // 縦方向に裏返す
        var y = py-2
        while y >= 0 {
            if self.S[y][px] == "*" {
                // ここからおいた場所に向かってひっくり返す
                y += 1
                for ey in y..<py {
                    self.S[ey][px] = "*"
                }
                break
            }
            y -= 1
        }
        y = py+2
        while y < self.H {
            if self.S[y][px] == "*" {
                // ここからおいた場所に向かってひっくり返す
                for ey in py+1..<y {
                    self.S[ey][px] = "*"
                }
                break
            }
            y += 1
        }
        // 横方向に裏返す
        var x = px-2
        while x >= 0 {
            if self.S[py][x] == "*" {
                // ここからおいた場所に向かってひっくり返す
                x += 1
                for ex in x..<px {
                    self.S[py][ex] = "*"
                }
                break
            }
            x -= 1
        }
        x = px+2
        while x < self.W {
            if self.S[py][x] == "*" {
                // ここからおいた場所に向かってひっくり返す
                for ex in px+1..<x {
                    self.S[py][ex] = "*"
                }
                break
            }
            x += 1
        }
    }
    // 出力
    func Print() {
        for y in 0..<self.H {
            for x in 0..<self.W {
                print(self.S[y][x], terminator: "")
            }
            print("")
        }
    }
 }

// メイン関数
func main() {
    // １行目では、盤面の行数 H , 列数 W , 石を置くマスの y , x 座標 である Y , X が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let h = Int(items[0])!
    let w = Int(items[1])!
    let y = Int(items[2])!
    let x = Int(items[3])!
    // 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた文字列 S_i が与えられ、
    // S_i の j 文字目は、盤面の i 行目の j 列目に書かれている文字を表します。
    var s: [[Character]] = []
    for _ in 0..<h {
        s.append(Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    // 盤面初期化
    var current = World(H: h, W: w, S: s)
    // 石を置く
    current.Put(y: y, x: x)
    // 結果出力
    current.Print()
}

// エントリーポイント
main()