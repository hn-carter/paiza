/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「いびつなリバーシ対戦」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_pincerattack_boss

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

// プレイヤーの手
struct Move {
    // プレイヤー番号
    var P: Int
    // 石を置く座標
    var Pos: Position
}

// マップ
struct World {
    // マップの大きさ
    var H: Int
    var W: Int
    // マップ
    var S: [[Character]]
    // 石を置く
    mutating func Put(pos: Position, player: Character) {
        if self.isInRange(pos: pos) {
            self.S[pos.Y][pos.X] = player
            self.take(pos: pos, player: player)
        }
    }
    // 座標が範囲内か判定
    func isInRange(pos: Position) -> Bool {
        return (0 <= pos.Y && pos.Y < self.H && 0 <= pos.X && pos.X < self.W)
    }
    // マスの値を返す
    func GetCell(pos: Position) -> Character {
        if isInRange(pos: pos) {
            return self.S[pos.Y][pos.X]
        }
        return " "
    }
    // マスの値を変更する
    mutating func SetCell(pos: Position, val: Character) {
        if isInRange(pos: pos) {
            self.S[pos.Y][pos.X] = val
        }
    }
    // 裏返す
    mutating func take(pos: Position, player: Character) {
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
                let cell = self.GetCell(pos: t)
                if cell == "#" {
                    // ここは行けない
                    break
                } else if cell == player {
                    // ここから置いた位置まで置く
                    var o = t - a
                    while o != pos {
                        self.SetCell(pos: o, val: player)
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
    // 1 行目では、盤面の行数 H ,列数 W , プレイヤーの人数 N , 全プレイヤーの合計ターン数 n が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let h = Int(items[0])!
    let w = Int(items[1])!
    //let n = Int(items[2])!
    let turn = Int(items[3])!
    // 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた文字列 S_i が与えられ、
    // S_i の j 文字目は、盤面の i 行目の j 列目に書かれている文字を表します。
    var s: [[Character]] = []
    for _ in 0..<h {
        s.append(Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    // 続く n 行のうち i 行目 (1 ≦ i ≦ n) には、i 回目の操作で石を置く人のプレイヤー番号 p_i と、
    // その人が石を置く座標 Y_i X_i が与えられます。
    var moves: [Move] = []
    for _ in 0..<turn {
        let itemsP = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let p = Int(itemsP[0])!
        let y = Int(itemsP[1])!
        let x = Int(itemsP[2])!
        moves.append(Move(P: p, Pos: Position(Y: y, X: x)))
    }
    // 盤面初期化
    var current = World(H: h, W: w, S: s)
    // 石を置く
    for p in moves {
        current.Put(pos: p.Pos, player: String(p.P).first!)
    }
    // 結果出力
    current.Print()
}

// エントリーポイント
main()