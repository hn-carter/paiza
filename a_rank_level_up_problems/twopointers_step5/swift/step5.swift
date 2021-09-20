/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「区間への足し算」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_twopointers_step5

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

struct Query {
    // 要素番号下限
    var L: Int
    // 要素番号上限
    var U: Int
    // 加算数
    var A: Int

    init(l: Int, u: Int, a: Int) {
        self.L = l
        self.U = u
        self.A = a
    }
}

// ゴリ押し
func noBrain(a: [Int], q: [Query]) -> [Int] {
    // Swiftは値渡しのため配列の中身がコピーされる
    var result = a
    for qu in q {
        for i in (qu.L-1)..<qu.U {
            result[i] += qu.A
        }
    }
    return result
}

// 良い感じ
func smart(a: [Int], q: [Query]) -> [Int] {
    let len = a.count
    var result = [Int](repeating: 0, count: len)
    var add = [Int](repeating: 0, count: len+1)
    for qu in q {
        add[qu.L-1] += qu.A
        add[qu.U] -= qu.A
    }
    for i in 0..<len {
        result[i] = a[i] + add[i]
        add[i+1] += add[i]
    }
    return result
}

// メイン関数
func main() {
    // 1 行目には、数列 A の要素数 N と、クエリの数 M が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let m = Int(items[1])!
    // 2 行目には、数列 A の各要素 A_1, A_2 ... A_N が与えられます。 
    var a: [Int] = [Int](repeating: 0, count: n)
    let itemsA = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    for i in 0..<n {
        a[i] = Int(itemsA[i])!
    }
    // 続く M 行には、各クエリの処理に用いる整数 l_i, u_i, a_i (1 ≦ i ≦ M) が与えられます。
    var q = [Query]()
    for _ in 0..<m {
        let itemsQ = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let l = Int(itemsQ[0])!
        let u = Int(itemsQ[1])!
        let add = Int(itemsQ[2])!
        q.append(Query(l: l, u: u, a: add))
    }

    // 2種類の方法で問題を解いています。適当にコメントを外して試してください。
    //let start1 = Date()
    // 遅い方法で計算
    //let answer1 = noBrain(a: a, q: q)
    //let elapsed1 = Date().timeIntervalSince(start1)

    //let start2 = Date()
    // 早い方法で計算
    let answer2 = smart(a: a, q: q)
    //let elapsed2 = Date().timeIntervalSince(start2)

    // 結果出力
    for val in answer2 {
        print(val)
    }
    // print("遅い\(elapsed1) 早い\(elapsed2)")
}

// エントリーポイント
main()