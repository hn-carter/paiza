/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「隣接リストの出力・有向グラフ」に
go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__adjacency_list_boss

作成環境
Ubuntu 20.04.2 LTS
go version go1.16.4 linux/amd64
*/

package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

// 頂点を結ぶ辺
type Graph struct {
	// 頂点A
	a int
	// 頂点B
	b int
	// 重み
	w int
}

// main はエントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目に、頂点の個数を表す整数 n と、頂点の組の個数を表す整数 m が半角スペース区切りで与えられます。
	sc.Scan()
	var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
	var n, _ = strconv.Atoi(items[0])
	var m, _ = strconv.Atoi(items[1])
	// 続く m 行では、頂点の組と重みの整数 a_i, b_i, w_i が半角スペース区切りで与えられます。(1 ≦ i ≦ m)
	var graphList []Graph
	for i := 0; i < m; i++ {
		sc.Scan()
		var itemsG []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
		var newGraph = new(Graph)
		newGraph.a, _ = strconv.Atoi(itemsG[0])
		newGraph.b, _ = strconv.Atoi(itemsG[1])
		newGraph.w, _ = strconv.Atoi(itemsG[2])
		graphList = append(graphList, *newGraph)
	}
	// 頂点とつながっている辺を求める
	var vertex = make([][]Graph, n)
	for _, g := range graphList {
		vertex[g.a-1] = append(vertex[g.a-1], g)
	}
	// 頂点毎に重みを出力
	for _, v := range vertex {
		if len(v) == 0 {
			fmt.Println("-1")
		} else {
			for i, g := range v {
				if i > 0 {
					fmt.Print(" ")
				}
				fmt.Print(g.w)
			}
			fmt.Println("")
		}
	}
	return
}
