<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「特殊な2項間漸化式 1」
https://paiza.jp/works/mondai/dp_primer/dp_primer_recursive_formula_step2
にphpでチャレンジした試行錯誤コードです。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// 整数 x, d_1, d_2, k が与えられます。
list($x, $d_1, $d_2, $k) = explode(" ", trim(fgets(STDIN)));
// 動的計画法で問題を解く
$dp = array();
$dp[1] = $x;
for ($i = 2; $i <= $k; $i++) {
    if (($i % 2) == 1) {
        $dp[$i] = $dp[$i-1] + $d_1;
    } else {
        $dp[$i] = $dp[$i-1] + $d_2;
    }
}
// 結果出力
echo $dp[$k]."\n";