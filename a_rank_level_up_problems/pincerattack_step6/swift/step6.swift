/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「いびつなひとりリバーシ（１ターン）」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_pincerattack_step6

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 座標
struct Position {
    var Y: Int
    var X: Int
    // +
    mutating func Plus(_ pos: Position) {
        self.Y += pos.Y
        self.X += pos.X
    }
    // -
    mutating func Minus(_ pos: Position) {
        self.Y -= pos.Y
        self.X -= pos.X
    }
}
// 演算子オーバーロード
func + (lsh: Position, rsh: Position) -> Position {
    return Position(Y: lsh.Y + rsh.Y, X: lsh.X + rsh.X)
}
func - (lsh: Position, rsh: Position) -> Position {
    return Position(Y: lsh.Y - rsh.Y, X: lsh.X - rsh.X)
}
func != (lsh: Position, rsh: Position) -> Bool {
    return (lsh.Y != rsh.Y) || (lsh.X != rsh.X)
}

// マップ
struct World {
    // マップの大きさ
    var H: Int
    var W: Int
    // マップ
    var S: [[Character]]
    // ! の位置を探す
    func Find() -> Position? {
        for y in 0..<self.H {
            for x in 0..<self.W {
                if self.S[y][x] == "!" {
                    return Position(Y: y, X: x)
                }
            }
        }
        return nil
    }
    // 石を置く
    mutating func Put(pos: Position) {
        if self.isInRange(pos: pos) {
            self.S[pos.Y][pos.X] = "*"
            self.take(pos: pos)
        }
    }
    // 座標が範囲内か判定
    func isInRange(pos: Position) -> Bool {
        return (0 <= pos.Y && pos.Y < self.H && 0 <= pos.X && pos.X < self.W)
    }
    // マスの値を返す
    func GetCell(pos: Position) -> Character? {
        if isInRange(pos: pos) {
            return self.S[pos.Y][pos.X]
        }
        return nil
    }
    // マスの値を変更する
    mutating func SetCell(pos: Position, val: Character) {
        if isInRange(pos: pos) {
            self.S[pos.Y][pos.X] = val
        }
    }
    // 裏返す
    mutating func take(pos: Position) {
        // ひっくり返す方向
        let able: [Position] = [Position(Y: -1, X: 0), Position(Y: 1, X: 0),
                                Position(Y: 0, X: -1), Position(Y: 0, X: 1),
                                Position(Y: -1, X: -1), Position(Y: 1, X: 1),
                                Position(Y: -1, X: 1), Position(Y: 1, X: -1)]
        for a in able {
            var t = pos + a
            // マップの範囲内チェック
            while self.isInRange(pos: t) {
                // 陣取りチェック
                let cell = self.GetCell(pos: t)!
                if cell == "#" {
                    // ここは行けない
                    break
                } else if cell == "*" {
                    // ここから置いた位置まで置く
                    var o = t - a
                    while o != pos {
                        self.SetCell(pos: o, val: "*")
                        o.Minus(a)
                    }
                    break
                }
                t.Plus(a)
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
    // 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた文字列 S_i が与えられ、
    // S_i の j 文字目は、盤面の i 行目の j 列目に書かれている文字を表します。
    var s: [[Character]] = []
    for _ in 0..<h {
        s.append(Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    // 盤面初期化
    var current = World(H: h, W: w, S: s)
    // 石の置き場所を求める
    let start = current.Find()!
    // 石を置く
    current.Put(pos: start)
    // 結果出力
    current.Print()
}

// エントリーポイント
main()