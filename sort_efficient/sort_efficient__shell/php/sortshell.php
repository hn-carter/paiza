<?php
/*
これはpaizaラーニングの問題集にある「シェルソート」
https://paiza.jp/works/mondai/sort_efficient/sort_efficient__shell
にphpでチャレンジした試行錯誤コードです。
php初心者が学習用に作ったコードなので本来は不要な処理があります。
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

    // 途中経過の出力
    echo $num_of_move."\n";
}

// shell_sort はシェルソートを行う
// i $a : ソート対象の配列
//   $h : 間隔の配列
// o    : ソート結果
function shell_sort($a, $h) {
    foreach ($h as &$val) {
        insertion_sort($a, $val);
    }
    return $a;
}

// inputData はデータを読み込む
// i/o $n : ソート対象の要素数
//     $a : ソート対象
//     $k : 間隔列の要素数
//     $h : 間隔列の要素
function inputData(&$n, &$a, &$k, &$h) {
    // 1行目に配列の要素数が与えられる
    // phpは勝手に型変換するので明示的に文字、数値変換しない
    $n = trim(fgets(STDIN));
    // 2行目に、数列の要素が半角スペース区切りで与えられる
    // 改行までの1行まるごと読み込み
    // 文字列をスペースで区切り配列で返す
    $a = convertArray(trim(fgets(STDIN)));
    // 3行目に、間隔列の要素数が与えらる
    $k = trim(fgets(STDIN));
    // 4行目に、間隔列の要素が半角スペース区切りで与えられる
    $h = convertArray(trim(fgets(STDIN)));
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
//   $gaps    : 間隔列
// o 戻り値   : ソート結果の数値配列
function computeData($numbers, $gaps) {
    // 選択ソートを行う
    $result = shell_sort($numbers, $gaps);
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
    $gaps = array();    // 間隔列
    inputData($n, $numbers, $k, $gaps);

    // 処理を行う
    $sorted = computeData($numbers, $gaps);

    // 処理完了
    // 問題文で結果の出力は求められていないためコメントアウト
    // outputData($sorted);
}

// エントリーポイント
main();