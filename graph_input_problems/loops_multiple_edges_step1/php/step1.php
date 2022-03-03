<?php
/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「自己ループ・無向グラフ」に
phpでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__loops_multiple_edges_step1

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// ●エントリーポイントはこのファイルの最後です

// メイン処理
function main() {
    // 1 行目に、頂点の個数を表す整数 n が与えられます。
    $n = trim(fgets(STDIN));
    // 続く n 行では、隣接行列の上から i 行目の n 個の整数が左から順に半角スペース区切りで与えられます。(1 ≦ i ≦ n)
    $adjacencyMatrix = array();
    for ($i = 0; $i < $n; $i++) {
        $itemsG = explode(" ", trim(fgets(STDIN)));
        for ($j = 0; $j < $n; $j++) {
            $adjacencyMatrix[$i][$j] = $itemsG[$j];
        }
    }
    // 自己ループを求める
    $loops = array();
    for ($i = 0; $i < $n; $i++) {
        if ($adjacencyMatrix[$i][$i] == 1) {
            $loops[] = $i + 1;
        }
    }
    // 出力する
    echo count($loops)."\n";
    foreach ($loops as $v) {
        echo $v."\n";
    }
}

// エントリーポイント
main();