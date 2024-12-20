/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「ナンバープレートのハッシュ値」に
C++でチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__number_plate

作成環境
Ubuntu 22.04.5 LTS
g++ (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
*/
#include <iostream>

using namespace std;

// ナンバープレート
struct NumberPlate {
    // 地域名
    string s_1;
    // 分類番号
    int i_1;
    // ひらがな
    string s_2;
    // 一連指定番号
    int i_2;
};

// ナンバープレート情報を読み込みます
// Return: 読み込んだナンバープレート
NumberPlate readNumberPlate() {
    string s_1, s_2;
    int i_1, i_2;
    // 1 行目に地域名を表す文字列 s_1 が与えられます。
    cin >> s_1;
    // 2 行目に分類番号を表す整数 i_1 が与えられます。
    cin >> i_1;
    // 3 行目にひらがなを表す文字列 s_2 が与えられます。
    cin >> s_2;
    // 4 行目に一連指定番号を表す整数 i_2 が与えられます。
    cin >> i_2;

    return { s_1, i_1, s_2, i_2 };
}

// 文字コード(ASCII)の和を返します
// Parameters:
//   str: 文字列
// Return: ASCIIコードの和
int sumString(string str) {
    int result = 0;
    for (char c : str) {
        result += c;
    }
    return result;
}

// ハッシュ値を返します
// Parameters:
//   numberPlate: ナンバープレート
// Return: ハッシュ値
int hashFunction(NumberPlate numberPlate) {
    // (s_1 の各文字の文字コードの和 * i_1 + s_2 の各文字の文字コードの和 * i_2) % 1000
    int is1 = sumString(numberPlate.s_1);
    int is2 = sumString(numberPlate.s_2);
    int result = (is1 * numberPlate.i_1 + is2 * numberPlate.i_2) % 1000;
    return result;
}

int main() {
    // 入力
    NumberPlate numberPlate = readNumberPlate();
    // ハッシュ値を求める
    int hashValue = hashFunction(numberPlate);
    // 結果出力
    cout << hashValue << endl;
    return 0;
}
