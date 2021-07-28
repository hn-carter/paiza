/*
これはpaizaラーニングの「クエリメニュー」から「ソートと検索」
https://paiza.jp/works/mondai/query_primer/query_primer__sort_find_single
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
	"sort"
	"strconv"
	"strings"
)

// 二分探索でデータの位置(1-)を返す
func binarySearch(val int, arr []int) int {
	var left = 0
	var right = len(arr)
	var mid = 0
	for left < right {
		mid = (left + right) / 2
		if val == arr[mid] {
			// 見つかった
			return mid + 1
		} else if val > arr[mid] {
			left = mid + 1
		} else {
			right = mid
		}
	}
	// 見つからなかった
	return -1
}

// エントリーポイント
func main() {

	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、クラスの paiza 君以外の生徒数 N と転校生の身長 X と paiza君の身長 P が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var x, _ = strconv.Atoi(items[1])
	var p, _ = strconv.Atoi(items[2])
	// 続く N 行では、N 人の生徒の身長が与えられます。
	var height = make([]int, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		height[i], _ = strconv.Atoi(sc.Text())
	}
	// paiza 君と転校生の身長を追加する
	height = append(height, x, p)
	// ソートする
	sort.Sort(sort.IntSlice(height))
	// paiza 君の身長の位置を検索する
	var answer = binarySearch(p, height)
	// 結果を出力
	fmt.Println(answer)

	return
}
