/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「ナンバープレートのハッシュ値」に
javaでチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__number_plate

作成環境
Ubuntu 22.04.5 LTS
openjdk version "21.0.5" 2024-10-15
*/
import java.util.*;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) throws Exception {
        // 入力
        NumberPlate numberPlate = readNumberPlate();
        // ハッシュ値を求める
        int hashValue = numberPlate.hashValue();
        // 結果出力
        System.out.println(hashValue);
    }

    /// ナンバープレート情報を読み込みます
    ///
    /// - Returns: 読み込んだナンバープレート
    public static NumberPlate readNumberPlate() {
        Scanner sc =new Scanner(System.in);
        
        // 1 行目に地域名を表す文字列 s_1 が与えられます。
        String s_1 = sc.next();
        // 2 行目に分類番号を表す整数 i_1 が与えられます。
        int i_1 = sc.nextInt();
        // 3 行目にひらがなを表す文字列 s_2 が与えられます。
        String s_2 = sc.next();
        // 4 行目に一連指定番号を表す整数 i_2 が与えられます。
        int i_2 = sc.nextInt();
        sc.close();
        return new NumberPlate(s_1, i_1, s_2, i_2);
    }

    private static class NumberPlate {
        // 地域名
        String s_1;
        // 分類番号
        int i_1;
        // ひらがな
        String s_2;
        // 一連指定番号
        int i_2;
    
        NumberPlate(String s1, int i1, String s2, int i2) {
            s_1 = s1;
            i_1 = i1;
            s_2 = s2;
            i_2 = i2;
        }
    
        /// 文字コード(ASCII)の和を返します
        ///
        /// - Parameters:
        ///   - str: 文字列
        ///
        /// - Returns: ASCIIコードの和
        int sumString(String str) {
            int result = 0;
            List<Integer> listString = str.chars().boxed().collect(Collectors.toList());
            for (int i : listString) {
                result += i;
            }
            return result;
        }
    
        /// ハッシュ値を返します
        ///
        /// - Returns: ハッシュ値
        int hashValue() {
            // (地域名の各文字の文字コードの和 * 分類番号 + ひらがなの各文字の文字コードの和 * 一連指定番号) % 1000
            int is1 = sumString(s_1);
            int is2 = sumString(s_2);
            int result = (is1 * i_1 + is2 * i_2) % 1000;
            return result;
        }
    }
}
