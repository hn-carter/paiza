<?php
/*
これはシェルソートを行うPHPプログラムです。
標準入力から入力されたデータをシェルソートし、結果を1行で出力します。
・ 入力はすべて整数
・ 1行目に、数列の要素数 n が与えられます。
・ 2行目に、数列の要素 A_1, A_2, ... , A_n が半角スペース区切りで与えられます。

入力例1
10
7 6 10 2 5 4 8 3 9 1

出力例1
移動回数=5 間隔=4 途中=5 1 8 2 7 4 10 3 9 6
移動回数=17 間隔=1 途中=1 2 3 4 5 6 7 8 9 10
1 2 3 4 5 6 7 8 9 10

●このプログラムの元はこれはpaizaラーニングの問題集にある「シェルソート」
https://paiza.jp/works/mondai/sort_efficient/sort_efficient__shell
です。
問題では「間隔列」が与えられるようになっていましたが、
これを自身で計算するように改造しました。
*/

// ●エントリーポイントはこのファイルの最後です

// insertion_sort は部分挿入ソート
// 問題文にある処理をそのまま使っています
// i/o $a : ソート対象配列
// i   $h : 間隔
function insertion_sort(&$a, $h) {
    // アルゴリズムが正しく実装されていることを確認するために導入する
    // カウンタ変数、ソート処理には関係がないことに注意
    $num_of_move = 0;

    $n = count($a);
    for ($i = $h; $i < $n; $i++) {
        // A[i] を、整列済みの A[i-ah], ..., A[i-2h], A[i-h] の適切な位置に挿入する

        // 実装の都合上、A[i] の値が上書きされてしまうことがあるので、予め A[i] の値をコピーしておく 
        $x = $a[$i];

        // A[i] の適切な挿入位置を表す変数 j を用意
        $j = $i - $h;

        // A[i] の適切な挿入位置が見つかるまで、A[i] より大きい要素を後ろにずらしていく
        while ($j >= 0 && $a[$j] > $x) {
            $a[$j + $h] = $a[$j];
            $j -= $h;
            $num_of_move++;
        }
        // A[i] を挿入
        $a[$j + $h] = $x;
    }

    // 処理の確認のため途中経過の出力する
    // 不要ならコメントアウト
    echo "移動回数=".$num_of_move." 間隔=".$h." 途中=";
    outputData($a);
}

// shell_sort はシェルソートを行う
// i $a : ソート対象の配列
// o    : ソート結果
function shell_sort($a) {
    // 間隔列を求める
    // 間隔列は h_i = 3h_{i+1} + 1 で求める
    $h = 1;
    $len = count($a);
    // 間隔列をキューに入れる
    $h_queue = new SplQueue();
    do {
        $h_queue->push($h);
        $h = 3 * $h + 1;
    } while ($h < $len);

    // 間隔列毎に挿入ソート
    // PHPでは0はfalse
    while($h_queue->count()) {
        insertion_sort($a, $h_queue->pop());
    }
    return $a;
}

// inputData はデータを読み込む
// i/o $n : ソート対象の要素数
//     $a : ソート対象
function inputData(&$n, &$a) {
    // 1行目に配列の要素数が与えられる
    // phpは勝手に型変換するので明示的に文字、数値変換しない
    $n = trim(fgets(STDIN));
    // 2行目に、数列の要素が半角スペース区切りで与えられる
    // 改行までの1行まるごと読み込み
    // 文字列をスペースで区切り配列で返す
    $a = convertArray(trim(fgets(STDIN)));
}

// convertArray は半角スペース区切りの文字列を配列に変換する
// i $str : 処理対象文字列
// o      : 結果配列
function convertArray($str) {
    $line = str_replace(array("\r\n", "\r", "\n"), '', $str);
    // 文字列をスペースで区切り配列で返す
    $result = explode(" ", $line);
    return $result;
}

// computeData は問題を解く
// i $numbers : ソート対象
// o 戻り値   : ソート結果の数値配列
function computeData($numbers) {
    // 選択ソートを行う
    $result = shell_sort($numbers);
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

// メイン
function main()
{
    // データを読み込む
    $numbers = array(); // ソート対象
    inputData($n, $numbers);

    // 処理を行う
    $sorted = computeData($numbers);

    // 処理完了 ソート結果を表示する
    outputData($sorted);
}

// エントリーポイント
main();