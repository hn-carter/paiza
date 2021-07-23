<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「2項間漸化式 1」
https://paiza.jp/works/mondai/dp_primer/dp_primer_recursive_formula_step0
にphpでチャレンジした試行錯誤コードです。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// 整数 x, d, k が与えられます。
list($x, $d, $k) = explode(" ", trim(fgets(STDIN)));
// 動的計画法で問題を解く
$dp = array();
$dp[] = $x;
for ($i = 1; $i < $k; $i++) {
    $dp[] = $dp[$i-1] + $d;
}
// 結果出力
echo $dp[$k-1]."\n";