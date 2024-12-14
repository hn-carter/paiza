/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「ナンバープレートのハッシュ値」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__number_plate

作成環境
Ubuntu 22.04.5 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

/// ナンバープレート
struct NumberPlate {
    /// 地域名
    var s_1: String
    /// 分類番号
    var i_1: Int
    /// ひらがな
    var s_2: String
    /// 一連指定番号
    var i_2: Int
}

/// ナンバープレート情報を読み込みます
///
/// - Returns: 読み込んだナンバープレート
func readNumberPlate() -> NumberPlate {
    
    // 1 行目に地域名を表す文字列 s_1 が与えられます。
    let s_1 = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
    // 2 行目に分類番号を表す整数 i_1 が与えられます。
    let i_1: Int = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
    // 3 行目にひらがなを表す文字列 s_2 が与えられます。
    let s_2 = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
    // 4 行目に一連指定番号を表す整数 i_2 が与えられます。
    let i_2: Int = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0

    return NumberPlate(s_1: s_1, i_1: i_1, s_2: s_2, i_2: i_2)
}

/// 文字コード(ASCII)の和を返します
///
/// - Parameters:
///   - s: 文字列
///
/// - Returns: ASCIIコードの和
func sumString(_ s: String) -> Int {
    var result: Int = 0
    for character in s {
        let code = character.asciiValue ?? 0
        result += Int(code)
    }
    return result
}

/// ハッシュ値を返します
///
/// - Parameters:
///   - snumberPlate: ナンバープレート
///
/// - Returns: ハッシュ値
func hashFunction(_ numberPlate: NumberPlate) -> Int {
    // (s_1 の各文字の文字コードの和 * i_1 + s_2 の各文字の文字コードの和 * i_2) % 1000
    let is1 = sumString(numberPlate.s_1)
    let is2 = sumString(numberPlate.s_2)
    let result = (is1 * numberPlate.i_1 + is2 * numberPlate.i_2) % 1000
    return result
}

/// メイン関数
func main() {
    // 入力
    let numberPlate = readNumberPlate()
    // ハッシュ値を求める
    let hashValue = hashFunction(numberPlate)
    // 結果出力
    print(hashValue)
}

// エントリーポイント
main()
