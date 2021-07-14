<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「階段の上り方 1」
https://paiza.jp/works/mondai/dp_primer/dp_primer_stairs_step0
にphpでチャレンジした試行錯誤コードです。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// ●エントリーポイントはこのファイルの最後です

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

// データ入力
// o 配列[0] int : 入力整数
//   配列[1]     : エラー内容文字列、正常ならnull
function inputData() {
    // 数値が一つ入力される
    $str = trim(fgets(STDIN));
    list($n, $e) = toNumber($str);
    // 数字チェック
    if (!is_null($e)) {
        return [0, $e];
    }
    // 範囲チェツク
    if ($n < 1 || 40 < $n) {
        $err = "入力が範囲外です:[".$str."]";
        return [0, $err];
    }
    return [$n, null];
}

// 問題を解く
// i $n          : 階段の段数
// o 配列[0] int : 処理結果
//   配列[1]     : エラー内容文字列、正常ならnull
function computeData($n) {
    // 階段の段数毎に方法の数を保存する配列
    $dp = array();
    // 0 は 1
    $dp[] = 1;
    // 1から$nまでの答えを求める
    for ($i = 1; $i <= $n; $i++) {
        // 配列の要素数追加
        $dp[] = 0;
        if ($i >= 1) {
            // 1段下から1段上がる
            $dp[$i] = $dp[$i-1];
        }
        if ($i >= 2) {
            // 2段下から2段上がる
            $dp[$i] = $dp[$i] + $dp[$i-2];
        }
    }
    return [$dp[$n], null];
}

// 結果を出力
function outputData($answer) {
    echo $answer."\n";
    return;
}

// メイン処理
function main() {
    try {
        list($n, $err1) = inputData();
        if (!is_null($err1)) {
            echo $err1;
            exit(1);
        }
        list($answer, $err2) = computeData($n);
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