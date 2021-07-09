<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「3項間漸化式 2」
https://paiza.jp/works/mondai/dp_primer/dp_primer_recursive_formula_boss
にphpでチャレンジした試行錯誤コードです。
*/

// ●エントリーポイントはこのファイルの最後です

// 処理対象データ
class data {
    public $q = 0;          // 入力の行数
    public $k_n = array();  // 入力
}

// 文字列を数値に変換する
// 変換できない場合、例外を返す
function toNumber($str) {
    // 文字列が整数で構成されているか正規表現でチェック
    if (preg_match("/^[0-9]+$/", $str)) {
        // 数値に変換
        return intval($str);
    } else {
        throw new Exception("数字ではありません:[".$str."]");
    }
}

// 指定のフィボナッチ数を返す
// i   $k  : 取得する数値
// i\o &$f : フィボナッチ数列
function getFibonacci($k, &$f) {
    // ほしい位置までフィボナッチ数を計算する
    if (count($f) == 0) {
        // 問題文では1(a_1 = 1)から始まっているが0は0として始めると
        // (n = 2) から
        // a_{n-2} + a_{n-1} = a_{2-2} + a_{2-1} = a_0 + a_1 = 0 + 1
        // となって(a_2 = 1)となる
        $f[] = 0;
        $f[] = 1;
    }
    for ($i = count($f); $i <= $k; $i++) {
        $f[] = $f[$i - 2] + $f[$i - 1];
    }
    return $f[$k];
}

// データを読み込む
function inputData() {
    $result = new Data();
    // 1行目では、2行目以降で与えられる入力の行数 Q が与えられます。
    $line1 = trim(fgets(STDIN));
    $q = toNumber($line1);
    // 範囲チェック
    if ($q < 1 || 100 < $q) {
        throw new Exception("入力が範囲外です:[".$q."]");
    }
    $result->q = $q;
    // 続く Q 行のうち i 行目では、k_i が与えられます。
    for ($i = 0; $i < $q; $i++) {
        $line2 = trim(fgets(STDIN));
        try {
            $k = toNumber($line2);
        } catch(Exception $e) {
            throw new Exception(($i+2)."行目が".$e->getMessage());
        }
        // 範囲チェック
        if ($k < 1 || 40 < $k) {
            throw new Exception(($i+2)."行目の入力が範囲外です:[".$k."]");
        }
        $result->k_n[] = $k;
    }
    return $result;
}

// 問題を解く
function computeData($d) {
    $fibonacci = array();
    for ($i = 0; $i < $d->q; $i++) {
        $num = getFibonacci($d->k_n[$i], $fibonacci);
        echo $num."\n";
    }
}

// メイン処理
function main() {
    try {
        $data = inputData();
        computeData($data);
    } catch(Exception $e) {
        echo $e->getMessage()."\n";
    }
}

// エントリーポイント
main();