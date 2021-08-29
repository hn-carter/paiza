/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「1 マスの陣取り」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_camp_step1

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
    var S: [[Character]]
    // 陣取り
    mutating func Take() {
        
        // 現在地取得
        var sx: Int = 0
        var sy: Int = 0
        for y in 0..<self.H {
            for x in 0..<self.W {
                if self.S[y][x] == "*" {
                    sy = y
                    sx = x
                }
            }
        }
        // 4方向に陣地拡張
        let able: [Position] = [Position(Y: -1, X: 0), Position(Y: 0, X: 1),
                                Position(Y: 1, X: 0), Position(Y: 0, X: -1)]
        for a in able {
            let ty = sy + a.Y
            let tx = sx + a.X
            if 0 <= ty && ty < self.H && 0 <= tx && tx < self.W {
                self.S[ty][tx] = "*"
            }
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
    // 1 行目では、盤面の行数 H , 列数 W が与えられます。 
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let h = Int(items[0])!
    let w = Int(items[1])!
    // 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた
    // 文字列 S_i が与えられ、S_i の j 文字目は、盤面の i 行目の j 列目に書かれ
    // ている文字を表します。(0 ≦ j < W)
    var s: [[Character]] = []
    for _ in 0..<h {
        s.append(Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    var current = World(H: h, W: w, S: s)
    // 陣取り
    current.Take()
    // 結果出力
    current.Print()
}

// エントリーポイント
main()