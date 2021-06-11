<?php
/*
これはpaizaラーニングの問題集にある「挿入ソート」
https://paiza.jp/works/mondai/sort_naive/sort_naive__insertion
にphpでチャレンジした試行錯誤コードです。
php初心者が学習用に作ったコードなので本来は不要な処理があります。
*/

// ●エントリーポイントはこのファイルの最後です

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
    return;
}

// computeData は問題を解く
// i $numbers : ソート対象
// o 戻り値   : ソート結果の数値配列
function computeData($numbers) {
    // 要素が1つしかない場合ソートできないのでここで処理する
    if (count($numbers) == 1) {
        outputData($numbers);
    } else {
        for ($i = 1, $len = count($numbers); $i < $len; $i++) {
            // 実装の都合上、数[i]の値が上書きされてしまうことがあるので、予め数[i]の値をコピーしておく
            $x = $numbers[$i];
            // 数[i]の適切な挿入位置を表す変数 j を用意
            $j = $i - 1;
            // 数[i] の適切な挿入位置が見つかるまで、数[i] より大きい要素を1つずつ後ろにずらしていく
            while ($j >= 0 && $numbers[$j] > $x) {
                $numbers[$j + 1] = $numbers[$j];
                $j--;
            }
            // 数[i]を挿入
            $numbers[$j + 1] = $x;

            // 数[0] ~ 数[i]が整列済みになった
            // 途中結果を出力
            outputData($numbers);
        }
    }
    // ソート結果を返す
    return $numbers;
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

// メイン
function main()
{
    // データを読み込む
    $numbers = array(); // 受け取る配列を作成
    inputData($n, $numbers);

    // 処理を行う
    $sorted = computeData($numbers);

    // 処理完了
}

// エントリーポイント
main();