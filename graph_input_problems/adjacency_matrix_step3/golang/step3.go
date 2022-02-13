/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「隣接行列の入力・辺の個数」に
go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__adjacency_matrix_step3

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

// main はエントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目に、頂点の個数を表す整数 n が与えられます。
	sc.Scan()
	var n, _ = strconv.Atoi(strings.TrimSpace(sc.Text()))
	// 続く n 行では、隣接行列の上から i 行目の n 個の整数が左から順に半角スペース区切りで与えられます。(1 ≦ i ≦ n)
	var adjacencyMatrix = make([][]int, n)
	for i := 0; i < n; i++ {
		adjacencyMatrix[i] = make([]int, n)
	}
	for i := 0; i < n; i++ {
		sc.Scan()
		var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
		for j, v := range items {
			adjacencyMatrix[i][j], _ = strconv.Atoi(v)
		}
	}
	// 辺の数を求める
	// 無向グラフの隣接行列なら頂点をつなげている数を数えて半分にする
	var count int = 0
	for y := 0; y < n; y++ {
		for x := 0; x < n; x++ {
			if adjacencyMatrix[y][x] == 1 {
				count++
			}
		}
	}
	var answer int = count / 2
	// 答えを出力する
	fmt.Println(answer)
	return
}
