<?php
/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「隣接リストの出力・有向グラフ」に
phpでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__adjacency_list_step2

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// ●エントリーポイントはこのファイルの最後です

// メイン処理
function main() {
    // 1 行目に、頂点の個数を表す整数 n と、頂点の組の個数を表す整数 m が半角スペース区切りで与えられます。
    $items = explode(" ", trim(fgets(STDIN)));
    $n = $items[0];
    $m = $items[1];
    // 続く m 行では、頂点の組 a_i, b_i が半角スペース区切りで与えられます。(1 ≦ i ≦ m)
    $vertex = array();
    for ($i = 0; $i < $n; $i++) {
        $vertex[$i] = array();
    }
    for ($i = 0; $i < $m; $i++) {
        $itemsG = explode(" ", trim(fgets(STDIN)));
        $vertex[$itemsG[0] - 1][] = $itemsG[1];
    }
    // 隣接リストの出力
    for ($i = 0; $i < $n; $i++) {
        if (count($vertex[$i]) == 0) {
            echo "-1\n";
        } else {
            $max = count($vertex[$i]);
            for ($j = 0; $j < $max; $j++) {
                if ($j > 0) {
                    echo " ";
                }
                echo $vertex[$i][$j];
            }
            echo "\n";
        }
    }
}

// エントリーポイント
main();