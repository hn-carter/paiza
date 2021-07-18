<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「【最安値】最安値を達成するには 4」
https://paiza.jp/works/mondai/dp_primer/dp_primer_apples_boss
にphpでチャレンジした試行錯誤コードです。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// ●エントリーポイントはこのファイルの最後です

// 問題データ
class data {
    public int $n;  // りんごの個数
    public array $num;  // りんご?個
    public array $price;  // ?個の値段
    // コンストラクタ
    public function __construct(int $n, array $x, array $a) {
        $this->n = $n;
        $this->num = $x;
        $this->price = $a;
    }
}

// toNumber は文字列を数値に変換する
// i $str    : 処理文字列
// o 配列[0] : 変換後数値
//   配列[1] : エラー内容文字列、正常ならnull
function toNumber($str) {
    $num = 0;
    $err = null;
    // 文字列が9桁までの整数で構成されているか正規表現でチェック
    if (preg_match("/^[0-9]{1,9}$/", $str)) {
        // 数値に変換
        $num = intval($str);
    } else {
        $err = "数字ではありません:[".$str."]\n";
    }
    return [$num, $err];
}

// toIntArray スペース区切りの文字列を数値配列に変換する
// i $str          : 処理文字列
// o 配列[0] int[] : 数値配列
//   配列[1]       : エラー内容文字列、正常ならnull
function toIntArray($str) {
    // スペースで分割
    $items = explode(" ", $str);
    $result = array();
    $err = null;
    foreach ($items as $s) {
        // 数値変換 2つ返ってくる
        list($num, $e) = toNumber($s);
        if (is_null($e)) {
            $result[] = $num;
        } else {
            // 数値変換に失敗
            $err = $e;
            break;
        }
    }
    return [$result, $err];
}

// データ入力
// o 配列[0] data : 入力整数
//   配列[1]      : エラー内容文字列、正常ならnull
function inputData() {
    // 1 行で階段の段数n、1歩で登る段数a,bが与えられる
    $line1 = trim(fgets(STDIN));
    // 文字列を数値配列に変換 配列の最後にはエラー内容が返ってくる
    list($numbers1, $e) = toIntArray($line1);
    if (!is_null($e)) {
        // 数値変換に失敗
        $err = "1行目が不正です : ".$e;
        return [null, $err];
    }
    // 項目数チェック
    if (count($numbers1) != 7) {
        $err = "1行目が不正です[".$line1."]\n";
        return [null, $err];
    }
    // 小さい順に並んでいるかチェック
    $max = (count($numbers1) - 1) / 2;  // りんごの個数と値段の組み合わせ数
    for ($i = 0; $i < $max-1; $i++) {
        if ($numbers1[1 + $i * 2] >= $numbers1[3 + $i * 2]) {
            $err = "りんごの販売個数が不正です。[".$numbers1[1 + $i * 2].", ".$numbers1[3 + $i * 2]."]\n";
            return [null, $err];
        }
        if ($numbers1[2 + $i * 2] >= $numbers1[4 + $i * 2]) {
            $err = "りんごの値段が不正です。[".$numbers1[2 + $i * 2].", ".$numbers1[4 + $i * 2]."]\n";
            return [null, $err];
        }
    }
    // 範囲チェック
    if ($numbers1[0] < 1 || 1000 < $numbers1[0]) {
        $err = "りんごの個数が範囲外です。[".$numbers1[0]."]\n";
        return [null, $err];
    }
    $num = array();   // 構造体に設定するためのりんごの個数配列
    $price = array(); // 構造体に設定するためのりんごの価格配列
    for ($i = 0; $i < $max; $i++) {
        if ($numbers1[1 + $i * 2] < 1 || 1000 < $numbers1[1 + $i * 2]) {
            $err = "りんごの販売個数xが範囲外です。[".$numbers1[1 + $i * 2]."]\n";
            return [null, $err];
        }
        $num[] = $numbers1[1 + $i * 2];
        if ($numbers1[2 + $i * 2] < 1 || 10000 < $numbers1[2 + $i * 2]) {
            $err = "x個のりんごの値段が範囲外です。[".$numbers1[2 + $i * 2]."]\n";
            return [null, $err];
        }
        $price[] = $numbers1[2 + $i * 2];
    }
    // データインスタンス作成
    $result = new data($numbers1[0], $num, $price);

    return [$result, null];
}

// 問題を解く
// i $dt         : 入力データ
// o 配列[0] int : 処理結果
//   配列[1]     : エラー内容文字列、正常ならnull
function computeData($dt) {
    // りんごの個数毎に値段の数を保存する配列
    $dp = array();
    // 0個 は 0円
    $dp[0] = 0;
    // りんごの個数+z-1までの最安値を求めるループ
    for ($i = 1, $max = $dt->n + $dt->num[array_key_last($dt->num)]; $i < $max; $i++) {
        $minPrice = PHP_INT_MAX;
        // りんごの販売単位数ループ
        for ($j = count($dt->num) - 1; $j >= 0; $j--) {
            // i個のりんごを買うのに最小の金額を求める
            if ($i >= $dt->num[$j]) {
                for ($k = $j; $k >= 0; $k--) {
                    $minPrice = min($minPrice, $dp[$i-$dt->num[$k]] + $dt->price[$k]);
                }
                break;
            }
        }
        // 最小販売個数以下の場合
        if ($minPrice == PHP_INT_MAX) {
            $minPrice = $dt->price[0];
        }
        $dp[$i] = $minPrice;
    }
    // n + x個までの最小金額を求める
    $result = PHP_INT_MAX;
    for ($i = $dt->n, $max = $dt->n + $dt->num[array_key_last($dt->num)]; $i < $max; $i++) {
        $result = min($result, $dp[$i]);
    }

    return [$result, null];
}

// 結果を出力
function outputData($answer) {
    echo $answer."\n";
    return;
}

// メイン処理
function main() {
    try {
        list($dt, $err1) = inputData();
        if (!is_null($err1)) {
            echo $err1;
            exit(1);
        }
        list($answer, $err2) = computeData($dt);
        if (!is_null($err2)) {
            echo $err2;
            exit(1);
        }
        outputData($answer);
    } catch(Exception $e) {
        echo $e->getMessage()."\n";
    }
}

// エントリーポイント
main();