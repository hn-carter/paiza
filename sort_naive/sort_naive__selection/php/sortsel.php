<?php
/*
これはpaizaラーニングの問題集にある「選択ソート」
https://paiza.jp/works/mondai/sort_naive/sort_naive__selection
にphpでチャレンジした試行錯誤コードです。
php初心者が学習用に作ったコードなので本来は不要な処理があります。
*/

// ●エントリーポイントはこのファイルの最後です

// swap は2つの変数の内容を入れ替える
// i/o &$a : 内容を入れ替える変数
//     &$b : 内容を入れ替える変数
function swap(&$a, &$b) {
    $tmp = $b;
    $b = $a;
    $a = $tmp;
}

// selection_sort は選択ソートを行う
// i $numbers : ソート対象
function selection_sort($numbers) {
    // 並べ替える数値の個数
    $n = count($numbers);
    for ($i = 0; $i < $n-1; $i++) {
        // A[i] ~ A[n-1] の最小値を見つけ、A[i]と交換する
        // つまり、整列済みとなっている A[0] ~ A[i-1] の末尾に、A[i] ~ A[n-1] の最小値を付け加える
        
        // A[i] ~ A[n-1] の最小値の位置を保存する変数 min_index を用意
        // 暫定的に A[i] を最小値とする
        $min_index = $i;

        // 最小値を探す
        for ($j = $i+1; $j < $n; $j++) {
            if ($numbers[$j] < $numbers[$min_index]) {
                $min_index = $j;
            }
        }
        // A[i] と A[min_index]を交換
        swap($numbers[$i], $numbers[$min_index]);

        // A[0] ~ A[i] が整列済みになった
        outputData($numbers);
    }
    // ソート結果を返す
    return $numbers;
}

// inputData はデータを読み込む
// i/o $n       : 配列の要素数
//     $numbers : ソート対象
function inputData(&$n, &$numbers) {
    // 1行目に配列の要素数が与えられる
    // phpは勝手に型変換するので明示的に文字、数値変換しない
    $n = trim(fgets(STDIN));
    // 2行目に配列の要素 A_1, A_2, ... , A_n が半角スペース区切りで与えられる
    // 改行までの1行まるごと読み込む
    $line = trim(fgets(STDIN));
    // 改行文字を削除する
    $line = str_replace(array("\r\n", "\r", "\n"), '', $line);
    // 文字列をスペースで区切り配列で返す
    $numbers = explode(" ", $line);
}

// computeData は問題を解く
// i $numbers : ソート対象
// o 戻り値   : ソート結果の数値配列
function computeData($numbers) {
    // 選択ソートを行う
    $result = selection_sort($numbers);
    // ソート結果を返す
    return $result;
}

// outputData は数値配列を出力する
// i $numbers : 出力対象
function outputData($numbers) {
    if (count($numbers) > 0) {
        echo $numbers[0];
    }
    for ($i = 1, $len = count($numbers); $i < $len; $i++) {
        echo " ".$numbers[$i];
    }
    echo "\n";
}

function main() {
    // データを読み込む
    $numbers = array(); // 受け取る配列を作成
    inputData($n, $numbers);

    // 処理を行う
    $sorted = computeData($numbers);

    // 処理完了
}

// エントリーポイント
main();