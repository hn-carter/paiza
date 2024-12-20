<?php
/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「ナンバープレートのハッシュ値」に
PHPでチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__number_plate

作成環境
Ubuntu 22.04.5 LTS
PHP 8.1.2-1ubuntu2.20 (cli) (built: Dec  3 2024 20:14:35) (NTS)
*/
// ナンバープレート
class NumberPlate {
    // 地域名
    public string $s_1;
    // 分類番号
    public int $i_1;
    // ひらがな
    public string $s_2;
    // 一連指定番号
    public int $i_2;

    public function __construct(string $s_1, int $i_1, string $s_2, int $i_2) {
        $this->s_1 = $s_1;
        $this->i_1 = $i_1;
        $this->s_2 = $s_2;
        $this->i_2 = $i_2;
    }
    // ハッシュ値を返します
    // Return: ハッシュ値
    public function hashValue(): int {
        // (地域名の各文字の文字コードの和 * 分類番号 + ひらがなの各文字の文字コードの和 * 一連指定番号) % 1000
        $is1 = self::sumString($this->s_1);
        $is2 = self::sumString($this->s_2);
        $result = ($is1 * $this->i_1 + $is2 * $this->i_2) % 1000;
        return $result;
    }
    // 文字コード(ASCII)の和を返します
    // Parameters:
    //   str: 文字列
    // Return: ASCIIコードの和
    private static function sumString(string $str): Int {
        $result = 0;
        foreach(str_split($str) as $c) {
            $result += ord($c);
        }
        return $result;
    }
}
// ナンバープレート情報を読み込みます
// Return: 読み込んだナンバープレート
function readNumberPlate(): NumberPlate {
    // 1 行目に地域名を表す文字列 s_1 が与えられます。
    $s_1 = trim(fgets(STDIN));
    // 2 行目に分類番号を表す整数 i_1 が与えられます。
    $i_1 = trim(fgets(STDIN));
    // 3 行目にひらがなを表す文字列 s_2 が与えられます。
    $s_2 = trim(fgets(STDIN));
    // 4 行目に一連指定番号を表す整数 i_2 が与えられます。
    $i_2 = trim(fgets(STDIN));

    $result = new NumberPlate($s_1, $i_1, $s_2, $i_2);
    return $result;
}

// 入力
$numberPlate = readNumberPlate();
// ハッシュ値を求める
$hashValue = $numberPlate->hashValue();
// 結果出力
echo $hashValue,PHP_EOL;
