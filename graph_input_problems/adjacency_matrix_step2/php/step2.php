<?php
/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「隣接行列の出力・有向グラフ」に
phpでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__adjacency_matrix_step2

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// ●エントリーポイントはこのファイルの最後です

// 頂点を結ぶ辺
class Graph {
    // 頂点A
    public int $a;
    // 頂点B
    public int $b;
    // コンストラクタ
    public function __construct(int $a, int $b) {
        $this->a = $a;
        $this->b = $b;
    }
}

// メイン処理
function main() {
    // 1 行目に、頂点の個数を表す整数 n と、頂点の組の個数を表す整数 m が半角スペース区切りで与えられます。
    $items = explode(" ", trim(fgets(STDIN)));
    $n = $items[0];
    $m = $items[1];
    // 続く m 行では、頂点の組 a_i, b_i が半角スペース区切りで与えられます。(1 ≦ i ≦ m)
    $graphList = array();
    for ($i = 0; $i < $m; $i++) {
        $itemsG = explode(" ", trim(fgets(STDIN)));
        $newGraph = new Graph((int)$itemsG[0], (int)$itemsG[1]);
        $graphList[] = $newGraph;
    }
    // 結果の隣接行列
    $adjacencyMatrix = array();
    for ($i = 0; $i < $n; $i++) {
        for ($j = 0; $j < $n; $j++) {
            $adjacencyMatrix[$i][$j] = 0;
        }
    }
    // 隣接行列を作成する
    foreach ($graphList as &$g) {
        $adjacencyMatrix[$g->a - 1][$g->b - 1] = 1;
    }
    // 隣接行列を出力する
    for ($y = 0; $y < $n; $y++) {
        for ($x = 0; $x < $n; $x++) {
            if ($x > 0) {
                echo " ";
            }
            echo $adjacencyMatrix[$y][$x];
        }
        echo "\n";
    }
}

// エントリーポイント
main();