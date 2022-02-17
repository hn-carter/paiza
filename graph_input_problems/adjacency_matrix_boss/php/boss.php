<?php
/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「隣接行列の入力・辺の存在判定」に
phpでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__adjacency_matrix_boss

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
    // 1 行目に、頂点の個数を表す整数 n, 整数の組の個数を表す整数 q が半角スペース区切りで与えられます。
    $items = explode(" ", trim(fgets(STDIN)));
    $n = $items[0];
    $q = $items[1];
    // 続く n 行では、隣接行列の上から i 行目の n 個の整数が、半角スペース区切りで与えられます。(1 ≦ i ≦ n)
    $adjacencyMatrix = array();
    for ($i = 0; $i < $n; $i++) {
        $itemsG = explode(" ", trim(fgets(STDIN)));
        for ($j = 0; $j < $n; $j++) {
            $adjacencyMatrix[$i][$j] = $itemsG[$j];
        }
    }
    // 続く q 行では、頂点の組 a_i, b_i が半角スペース区切りで与えられます。(1 ≦ i ≦ q)
    $graphList = array();
    for ($i = 0; $i < $q; $i++) {
        $itemsG = explode(" ", trim(fgets(STDIN)));
        $newGraph = new Graph((int)$itemsG[0], (int)$itemsG[1]);
        $graphList[] = $newGraph;
    }
    // 辺の判定
    foreach ($graphList as &$val) {
        echo $adjacencyMatrix[$val->a - 1][$val->b - 1]."\n";
    }
}

// エントリーポイント
main();