/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「ナンバープレートのハッシュ値」に
C#でチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__number_plate

作成環境
Ubuntu 22.04.5 LTS
.NET SDK 9.0.101
C# Compiler version: '4.13.0-2.24557.6 (0007900e)'. Language version: 13.0.CS8304
*/
using System;

/// <summary>
/// ナンバープレート
/// </summary>
/// <param name="s_1">地域名</param>
/// <param name="i_1">分類番号</param>
/// <param name="s_2">ひらがな</param>
/// <param name="i_2">一連指定番号</param>
class NumberPlate(string s_1, int i_1, string s_2, int i_2)
{
    /// <summary>
    /// 地域名
    /// </summary>
    public string Region { get; set; } = s_1;
    /// <summary>
    /// 分類番号
    /// </summary>
    public int Classification { get; set; } = i_1;
    /// <summary>
    /// ひらがな
    /// </summary>
    public string Hiragana { get; set; } = s_2;
    /// <summary>
    /// 一連指定番号
    /// </summary>
    public int Number { get; set; } = i_2;

    /// <summary>
    /// 文字コード(ASCII)の和を返します
    /// </summary>
    /// <param name="str">文字列</param>
    /// <returns>ASCIIコードの和</returns>
    private static int SumString(string str)
    {
        int result = 0;
        foreach( char c in str )
        {
            int code = Convert.ToInt32(c);
            result += code;
        }
        return result;
    }

    /// <summary>
    /// ハッシュ値を返します
    /// </summary>
    /// <returns>ハッシュ値</returns>
    public int HashValue()
    {
        // (地域名の各文字の文字コードの和 * 分類番号 + ひらがなの各文字の文字コードの和 * 一連指定番号) % 1000
        int is1 = SumString(Region);
        int is2 = SumString(Hiragana);
        int result = (is1 * Classification + is2 * Number) % 1000;
        return result;
    }
}

class Program
{
    static void Main(string[] args)
    {
        // 入力
        NumberPlate numberPlate = ReadNumberPlate();
        // ハッシュ値を求める
        int hashValue = numberPlate.HashValue();
        // 結果出力
        Console.WriteLine(hashValue);
    }

    /// <summary>
    /// ナンバープレート情報を読み込みます
    /// </summary>
    /// <returns>読み込んだナンバープレート</returns>    
    static NumberPlate ReadNumberPlate()
    {        
        // 1 行目に地域名を表す文字列 s_1 が与えられます。
        string s_1 = Console.ReadLine()!.Trim();
        // 2 行目に分類番号を表す整数 i_1 が与えられます。
        string si_1 = Console.ReadLine()!.Trim();
        int i_1 = int.Parse(si_1);
        // 3 行目にひらがなを表す文字列 s_2 が与えられます。
        string s_2 = Console.ReadLine()!.Trim();
        // 4 行目に一連指定番号を表す整数 i_2 が与えられます。
        string si_2 = Console.ReadLine()!.Trim();
        int i_2 = int.Parse(si_2);

        return new NumberPlate(s_1, i_1, s_2, i_2);
    }
}

