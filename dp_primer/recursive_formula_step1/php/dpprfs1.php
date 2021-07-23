<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「2項間漸化式 2」
https://paiza.jp/works/mondai/dp_primer/dp_primer_recursive_formula_step1
にphpでチャレンジした試行錯誤コードです。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// 1行目では、数列の初項 x と公差 d が半角スペース区切りで与えられます。
list($x, $d) = explode(" ", trim(fgets(STDIN)));
// 2行目では、3行目以降で与えられる入力の行数 Q が与えられます。
$q = trim(fgets(STDIN));
// 続く Q 行のうち i 行目では、k_i が与えられます。
$k = array();
for ($i = 0; $i < $q; $i++) {
    $k[] = trim(fgets(STDIN));
}
// 動的計画法で問題を解く
$dp = array();
$dp[0] = $x;
for ($i = 0; $i < $q; $i++) {
    for ($j = count($dp); $j < $k[$i]; $j++) {
        $dp[$j] = $dp[$j-1] + $d;
    }
    // 結果出力
    echo $dp[$k[$i]-1]."\n";
}