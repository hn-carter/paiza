/*
これはpaizaラーニングの「クエリメニュー」から「ソートと検索 (query)」
https://paiza.jp/works/mondai/query_primer/query_primer__sort_find_multi
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
	// 1 行目では、paiza 君を除いたクラスの人数 N と起こるイベントの回数 K と paiza君の身長 P が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	var p, _ = strconv.Atoi(items[2])
	// 続く N 行では、初めにクラスにいる N 人の生徒の身長が与えられます。
	var height = make([]int, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		height[i], _ = strconv.Atoi(sc.Text())
	}
	// paiza 君の身長を追加
	height = append(height, p)
	// paiza 君の位置を求める
	sort.Sort(sort.IntSlice(height))
	var pos int = binarySearch(p, height)
	// 続く K 行では、起こるイベントを表す文字列が与えられます。
	var event = make([]string, k)
	for i := 0; i < k; i++ {
		sc.Scan()
		event[i] = sc.Text()
	}
	// イベントを実行します
	for _, e := range event {
		var eItems []string = strings.Split(e, " ")
		switch eItems[0] {
		case "join":
			// "join num" 身長 num(cm) の生徒がクラスに加入したことを表す。
			var num, _ = strconv.Atoi(eItems[1])
			//height = append(height, num)
			// paiza君より小さければ1つ後ろへ移動
			if num < p {
				pos++
			}
		case "sorting":
			// "sorting" 生徒が背の順に並ぶことを表す
			// paiza 君が背の順で前から何番目に並ぶことになるかを出力する
			// ※paiza君の位置がわかればいいので都度ソート処理は行わない
			// 　低い生徒が加わるたびに+1すれば良い
			//sort.Sort(sort.IntSlice(height))
			//var answer int = binarySearch(p, height)
			//fmt.Println(answer)
			fmt.Println(pos)
		}
	}

	return
}
