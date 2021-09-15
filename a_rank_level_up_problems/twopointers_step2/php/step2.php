<?php
/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「区間和の計算」に
Go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_twopointers_step2

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// メイン
function main()
{
    // 1 行目には、数列 A の要素数 N が与えられます。
    $n = trim(fgets(STDIN));
    // 2 行目には、数列 A の各要素 A_1, A_2 ... A_N が与えられます。
    $line = trim(fgets(STDIN));
    $a = explode(" ", $line);
    // 0からの区間和を計算
    $sums = array();
    $sums[] = $a[0];
    for ($i = 1; $i < $n; $i++) {
        $sums[] = $sums[$i-1] + $a[$i];
    }
    // 3 行目には、クエリの数 num が与えられます。
    $num = trim(fgets(STDIN));
    // 続く n 行には、各クエリに用いる整数 l_i u_i (1 ≦ i ≦ n) が与えられます。
    $answer = array();
    for ($i = 0; $i < $num; $i++) {
        $line2 = trim(fgets(STDIN));
        list($l, $u) = explode(" ", $line2);
        if ($l == 0) {
            $answer[] = $sums[$u];
        } else {
            $answer[] = $sums[$u] - $sums[$l-1];
        }
    }
    // 結果出力
    for ($i = 0, $len = count($answer); $i < $len; $i++) {
        echo $answer[$i]."\n";
    }
}

// エントリーポイント
main();