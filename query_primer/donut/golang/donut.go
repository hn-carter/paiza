/*
これはpaizaラーニングの「クエリメニュー」から「ドーナツ」
https://paiza.jp/works/mondai/query_primer/query_primer__dount
にGo言語でチャレンジしたコードです。

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

// ドーナツデータ
type Donut struct {
	// ドーナツの中心の生地の上からの距離
	Y int
	X int
	// ドーナツの外側の一辺の長さ
	B int
	// ドーナツの内側の一辺の長さ
	S int
	// ドーナツに含まれるチョコの数
	Answer int
}

// ドーナツ作る
func (d *Donut) Make(dough Dough) {
	// 全体のチョコの数
	var x1 int = d.X - d.B/2
	var y1 int = d.Y - d.B/2
	var x2 int = x1 + d.B - 1
	var y2 int = y1 + d.B - 1
	var all = dough.GetChocoNum(x1, y1, x2, y2)
	// 穴のチョコの数
	var delta int = (d.B - d.S) / 2
	x1 += delta
	y1 += delta
	x2 -= delta
	y2 -= delta
	var hole = dough.GetChocoNum(x1, y1, x2, y2)
	// 全体から穴を引いてドーナツに含まれるチョコの数を求める
	d.Answer = all - hole
}

type Dough struct {
	// 生地のサイズ
	Y int
	X int
	// 左上からのチョコの累計
	Choco [][]int
}

// 指定範囲に含まれるチョコの数を返す
func (d *Dough) GetChocoNum(x1 int, y1 int, x2 int, y2 int) int {
	var sum int = d.Choco[y2][x2] - d.Choco[y2][x1-1] - d.Choco[y1-1][x2] + d.Choco[y1-1][x1-1]
	return sum
}

// 数値文字列をintスライスに変換する
func ConvIntArray(s string) []int {
	var list []string = strings.Split(s, " ")
	var ret = make([]int, len(list))
	for i, val := range list {
		ret[i], _ = strconv.Atoi(val)
	}
	return ret
}

// エントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、ドーナツの生地の縦の長さ H(cm) と横の長さ W(cm) と
	// 作るドーナツの数 N が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var h, _ = strconv.Atoi(items[0])
	var w, _ = strconv.Atoi(items[1])
	var n, _ = strconv.Atoi(items[2])
	// 続く H 行では、生地の 1 cm^2 に含まれるチョコの数が左上から順に
	// 見た目の通りに半角スペース区切りで与えられます。
	var c = make([][]int, h)
	for i := 0; i < h; i++ {
		sc.Scan()
		c[i] = ConvIntArray(sc.Text())
	}
	// 続く N 行のうち、i 行目では、i 番目に作るドーナツの中心の生地の上からの
	// 距離 y_i (cm) と左からの距離 x_i (cm) とドーナツの外側の一辺の長さ B_i (cm) と
	// 内側の一辺の長さ S_i (cm) が与えられます。
	var donutList = make([]Donut, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		var itemsI []string = strings.Split(sc.Text(), " ")
		donutList[i].Y, _ = strconv.Atoi(itemsI[0])
		donutList[i].X, _ = strconv.Atoi(itemsI[1])
		donutList[i].B, _ = strconv.Atoi(itemsI[2])
		donutList[i].S, _ = strconv.Atoi(itemsI[3])
	}
	// 生地データ作成
	var choco = make([][]int, h+1)
	var line0 = make([]int, w+1)
	for i := 0; i <= w; i++ {
		line0[i] = 0
	}
	choco[0] = line0
	for i := 1; i <= h; i++ {
		var line = make([]int, w+1)
		line[0] = 0
		choco[i] = line
	}
	// 横に合計
	for y := 1; y <= h; y++ {
		for x := 1; x <= w; x++ {
			choco[y][x] = choco[y][x-1] + c[y-1][x-1]
		}
	}
	// 縦に合計
	for x := 1; x <= w; x++ {
		for y := 1; y <= h; y++ {
			choco[y][x] += choco[y-1][x]
		}
	}
	var dough Dough = Dough{Y: h, X: w, Choco: choco}
	// ドーナツ作る
	for _, d := range donutList {
		d.Make(dough)
		// ドーナツのチョコの数
		fmt.Println(d.Answer)
	}

	return
}
