/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「ナンバープレートのハッシュ値」に
Kotlinでチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__number_plate

作成環境
Ubuntu 22.04.5 LTS
kotlinc-native 1.5.0-743 (JRE 21.0.5+11-Ubuntu-1ubuntu122.04)
*/
// ナンバープレート情報
data class NumberPlate(
    // 地域名
    val s_1: String,
    // 分類番号
    val i_1: Int,
    // ひらがな
    val s_2: String,
    // 一連指定番号
    val i_2: Int
) {
    // ハッシュ値を返します
    // Return: ハッシュ値
    fun hashValue(): Int {
        // (地域名の各文字の文字コードの和 * 分類番号 + ひらがなの各文字の文字コードの和 * 一連指定番号) % 1000
        val is1: Int = sumString(s_1)
        val is2: Int = sumString(s_2)
        val result: Int = (is1 * i_1 + is2 * i_2) % 1000
        return result
    }

    // 文字コード(ASCII)の和を返します
    // Parameters:
    //   str: 文字列
    // Return: ASCIIコードの和
    fun sumString(str: String): Int {
        var result: Int = 0
        val listChar: CharArray = str.toCharArray()
        for (c: Char in listChar) {
            result += c.code
        }
        return result
    }
}

// ナンバープレート情報を読み込みます
// Return: 読み込んだナンバープレート
fun readNumberPlate(): NumberPlate {
    // 1 行目に地域名を表す文字列 s_1 が与えられます。
    val s_1: String = readLine()!!
    // 2 行目に分類番号を表す整数 i_1 が与えられます。
    val i_1: Int = readLine()!!.toInt()
    // 3 行目にひらがなを表す文字列 s_2 が与えられます。
    val s_2: String = readLine()!!
    // 4 行目に一連指定番号を表す整数 i_2 が与えられます。
    val i_2: Int = readLine()!!.toInt()

    return NumberPlate(s_1, i_1, s_2, i_2)
}

fun main(args:Array<String>) {
    // 入力
    val numberPlate: NumberPlate = readNumberPlate()
    // ハッシュ値を求める
    val hashValue: Int = numberPlate.hashValue()
    // 結果出力
    println(hashValue)
}
