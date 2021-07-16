<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最安値を達成するには 2」
https://paiza.jp/works/mondai/dp_primer/dp_primer_apples_step1
にphpでチャレンジした試行錯誤コードです。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// ●エントリーポイントはこのファイルの最後です

// 問題データ
class data {
    public int $n;  // りんごの個数
    public int $a;  // 2個の値段
    public int $b;  // 5個の値段
    // コンストラクタ
    public function __construct(int $n, int $a, int $b) {
        $this->n = $n;
        $this->a = $a;
        $this->b = $b;
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
    if (count($numbers1) != 3) {
        $err = "1行目が不正です[".$line1."]\n";
        return [null, $err];
    }
    // 同一チェック
    if ($numbers1[1] >= $numbers1[2]) {
        $err = "りんごの値段が不正です。[a=".$numbers1[1].", b=".$numbers1[2]."]\n";
        return [null, $err];
    }
    // 範囲チェック
    if ($numbers1[0] < 1 || 1000 < $numbers1[0]) {
        $err = "りんごの個数が範囲外です。[".$numbers1[0]."]\n";
        return [null, $err];
    }
    if ($numbers1[1] < 1 || 10000 < $numbers1[1]) {
        $err = "2個のりんごの値段が範囲外です。[".$numbers1[1]."]\n";
        return [null, $err];
    }
    if ($numbers1[2] < 1 || 10000 < $numbers1[2]) {
        $err = "5個のりんごの値段が範囲外です。[".$numbers1[2]."]\n";
        return [null, $err];
    }
    // データインスタンス作成
    $result = new data($numbers1[0], $numbers1[1], $numbers1[2]);

    return [$result, null];
}

// 問題を解く
// i $dt         : 入力データ
// o 配列[0] int : 処理結果
//   配列[1]     : エラー内容文字列、正常ならnull
function computeData($dt) {
    // 階段の段数毎に方法の数を保存する配列
    $dp = array();
    // 0 は 0
    $dp[] = 0;
    for ($i = 1, $max = $dt->n + 4; $i < $max + 4; $i++) {
        if ($i <= 2) {
            $dp[] = $dt->a;
        } else if ($i <= 5) {
            $dp[] = min($dp[$i-2] + $dt->a, $dt->b);
        } else {
            $dp[] = min($dp[$i-2] + $dt->a, $dp[$i-5] + $dt->b);
        }
    }
    return [$dp[$dt->n], null];
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