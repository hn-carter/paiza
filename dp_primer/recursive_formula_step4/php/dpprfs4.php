<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「3項間漸化式 1」
https://paiza.jp/works/mondai/dp_primer/dp_primer_recursive_formula_step4
にphpでチャレンジした試行錯誤コードです。
*/

// ●エントリーポイントはこのファイルの最後です

// データ入力
function inputData() {
    // 数値が一つ入力される
    $k = trim(fgets(STDIN));
    // 数字チェック
    if (!is_numeric($k)) {
        throw new Exception("入力が数字ではありません:[".$k."]");
    }
    // 範囲チェツク
    if ($k < 1 || 40 < $k) {
        throw new Exception("入力が範囲外です:[".$k."]");
    }
    return $k;
}

// 問題を解く
function computeData($k) {
    // フィボナッチ数列を格納する配列
    $fibonacci = array();
    // 0 は 0
    $fibonacci[] = 0;
    // 1 は 1
    $fibonacci[] = 1;
    // 2から$kまでのフィボナッチ数列を計算
    for ($i = 2; $i <= $k; $i++) {
        $fibonacci[] = $fibonacci[$i - 2] + $fibonacci[$i - 1];
    }
    return $fibonacci[$k];
}

// 結果を出力
function outputData($r) {
    echo $r."\n";
    return;
}

// メイン処理
function main() {
    try {
        $k = inputData();
        $result = computeData($k);
        outputData($result);
    } catch(Exception $e) {
        echo $e->getMessage()."\n";
    }
}

// エントリーポイント
main();