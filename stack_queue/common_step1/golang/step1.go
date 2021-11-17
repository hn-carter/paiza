/*
これはpaizaラーニングの「スタック・キューメニュー」から「スタック・キュー実装編( 共通問題 ) step 1」
にGo言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/stack_queue/stack_queue__common_step1

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

// データ
type Stack struct {
	// 格納されているデータの数
	Count int
	// データの入れ物
	Array []int
}

// エントリーポイント
func main() {

	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 入れ物
	var data Stack
	// 1 行目では、要素の数 N が与えられます。
	sc.Scan()
	data.Count, _ = strconv.Atoi(strings.TrimSpace(sc.Text()))
	// 続く N 行に数 A 与えられます。
	data.Array = make([]int, data.Count)
	for i := 0; i < data.Count; i++ {
		sc.Scan()
		data.Array[i], _ = strconv.Atoi(strings.TrimSpace(sc.Text()))
	}
	// 結果出力
	// 要素数 N
	fmt.Println(data.Count)
	// 数列 A の要素
	for _, i := range data.Array {
		fmt.Println(i)
	}

	return
}
