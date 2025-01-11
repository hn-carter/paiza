/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「ログイン認証をしてみよう」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__certification

作成環境
Ubuntu 22.04.5 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// ハッシュ関数
// H(p) = (p の 1 文字目の文字コード * B^1 + p の 2 文字目の文字コード * B^2 + ... +
//  p の m 文字目の文字コード * B^m) % mod
// B = 10^8+7, mod = 10^9+7, 文字コード ASCII
func hashFunction(_ text: String) -> Int {
    // ハッシュ関数で使用する定数
    let B: Int = Int(pow(10.0, 8.0)) + 7
    let mod: Int = Int(pow(10.0, 9.0)) + 7

    var total: Int = 0
    var power: Int = 1
    for char in text {
        power *= B
        power %= mod
        total += Int(char.asciiValue ?? 0) * power % mod
    }
    let h = total % mod
    return h
}

// ログイン認証をしてみる
func main() {
    // 1 行目に組の数を表す整数 N と M が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
                .split(separator: " ")
    let N = Int(items[0]) ?? 0
    let M = Int(items[1]) ?? 0
    // アカウント名をキーとしてハッシュ値を保存する辞書
    var data: [String: Int] = [:]
    // i + 1 行目にデータベースで保管しているアカウント名を表す文字列 A_i と
    // それに対応するパスワードのハッシュ値を表す整数 h_i が与えられます。
    // (1 ≦ i ≦ N)
    for _ in 0 ..< N {
        let items2 = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
                    .split(separator: " ")
        data[String(items2[0])] = Int(items2[1]) ?? 0
    }
    // j + N + 1 行目にログイン認証を行うアカウント名を表す文字列 B_j と
    // パスワードを表す文字列 p_j が与えられます。(1 ≦ j ≦ M)
    for _ in 0 ..< M {
        let items3 = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
                    .split(separator: " ")
        let h = hashFunction(String(items3[1]))
        if data.keys.contains(String(items3[0])) && data[String(items3[0])] == h {
            print("Yes")
        } else {
            print("No")
        }
    }
}

// エントリーポイント
main()
