<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最安値を達成するには 1」
https://paiza.jp/works/mondai/dp_primer/dp_primer_apples_step0
にphpでチャレンジした試行錯誤コードです。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// りんごの個数 1個の値段 2個の値段
$data = explode(" ", trim(fgets(STDIN)));
// 動的計画法で問題を解く
$dp[] = 0;
$dp[] = $data[1];
for ($i = 2; $i <= $data[0]; $i++) {
    $dp[] = min($dp[$i-1] + $data[1], $dp[$i-2] + $data[2]);
}
// 結果を出力
echo $dp[intval($data[0])]."\n";