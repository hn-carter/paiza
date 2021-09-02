/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「陣取りゲーム」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_camp_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 座標
struct Position {
    var Y: Int
    var X: Int
    // ターン数
    var N: Int
    func Print() {
        print("Y=\(self.Y) X=\(self.X)")
    }
}

// キュー　ジェネリクス
struct Queue<T> {
    private var list: [T] = []
    // キューの中身が空
    var isEmpty: Bool {
        return list.isEmpty
    }
    // キューに追加する
    mutating func push(_ item: T) {
        list.append(item)
    }
    // キューから取り出す
    mutating func pop() -> T? {
        guard !list.isEmpty, let item = list.first else {
            return nil
        }
        list.removeFirst()
        return item
    }
    // 削除せずにキューの先頭を取得する
    func first() -> T? {
        guard !list.isEmpty, let item = list.first else {
            return nil
        }
        return item
    }
}

// マップ
struct World {
    // マップの大きさ
    var H: Int
    var W: Int
    // マップ
    var S: [[Character]]
    // 各プレイヤーのマス数
    var camp_num: [Int] = [1, 1]
    // プレイヤーの初期位置取得
    func getPosition(name: Character) -> Position? {
        var sx: Int = 0
        var sy: Int = 0
        var ret: Position
        for y in 0..<self.H {
            for x in 0..<self.W {
                if self.S[y][x] == name {
                    sy = y
                    sx = x
                    ret = Position(Y: sy, X: sx, N: 0)
                    return ret
                }
            }
        }
        return nil
    }
    // 陣取り
    mutating func Take(name: String) {
        
        let PLAYER_NAME = ["A", "B"]
        // Position構造体のキューを定義
        var queue: [Queue<Position>] = []
        // キューにスタート位置を追加
        queue.append(Queue<Position>())
        queue[0].push(getPosition(name: "A")!)
        queue.append(Queue<Position>())
        queue[1].push(getPosition(name: "B")!)

        // 4方向に陣地拡張
        let able: [Position] = [Position(Y: -1, X: 0, N: 0), Position(Y: 0, X: 1, N: 0),
                                Position(Y: 1, X: 0, N: 0), Position(Y: 0, X: -1, N: 0)]
        // いま操作しているプレイヤー
        var turn = 0
        if name == "B" {
            turn = 1
        }
        while !queue[0].isEmpty || !queue[1].isEmpty {
            if (queue[turn].isEmpty) {
                // 取れる陣地がない場合、次のプレイヤーへ
                turn = (turn + 1) % 2
                continue
            }
            let current = queue[turn].first()!.N
            // 同じターン内のマスを処理する
            while !queue[turn].isEmpty && current == queue[turn].first()!.N {
                let pos =  queue[turn].pop()!
                for a in able {
                    let ty = pos.Y + a.Y
                    let tx = pos.X + a.X
                    // マップの範囲内チェック
                    if 0 <= ty && ty < self.H && 0 <= tx && tx < self.W {
                        // 陣取りチェック
                        if self.S[ty][tx] == "." {
                            self.S[ty][tx] = PLAYER_NAME[turn].first!
                            self.camp_num[turn] += 1
                            queue[turn].push(Position(Y: ty, X: tx, N: pos.N+1))
                        }
                    }
                }
            }
            // 次のプレイヤーへ
            turn = (turn + 1) % 2
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
    // 勝敗出力
    func PrintResult() {
        print("\(self.camp_num[0]) \(self.camp_num[1])")
        if self.camp_num[0] > self.camp_num[1] {
            print("A")
        } else {
            print("B")
        }
    }
}

// メイン関数
func main() {
    // 1 行目では、マップの行数 H , 列数 W が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let h = Int(items[0])!
    let w = Int(items[1])!
    // 2 行目では、先攻のプレイヤーの名前 N が与えられます。
    let n = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
    // 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた
    // 文字列 S_i が与えられ、S_i の j 文字目は、盤面の i 行目の j 列目に書かれ
    // ている文字を表します。(0 ≦ j < W)
    var s: [[Character]] = []
    for _ in 0..<h {
        s.append(Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    var current = World(H: h, W: w, S: s)
    // 陣取り
    current.Take(name: n)
    // 結果出力
    current.PrintResult()
}

// エントリーポイント
main()