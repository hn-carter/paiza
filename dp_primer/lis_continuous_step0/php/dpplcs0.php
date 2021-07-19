<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最長増加連続部分列」
https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_step0
にphpでチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// 人数 n
$n = trim(fgets(STDIN));
// 身長 a_n
$a = array();
for ($i = 0; $i < $n; $i++) {
    $a[] = trim(fgets(STDIN));
}
// 動的計画法で問題を解く
$dp = array();
$dp[0] = 1;
for ($i = 1; $i < $n; $i++) {
    if ($a[$i-1] <= $a[$i]) {
        $dp[$i] = $dp[$i-1] + 1;
    } else {
        $dp[$i] = 1;
    }
}
// 結果出力
echo max($dp)."\n";