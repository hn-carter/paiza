/*
これはpaizaラーニングの「クエリメニュー」から「指定要素の検索 (query)」
https://paiza.jp/works/mondai/query_primer/query_primer__multi_search
にGo言語でチャレンジした試行錯誤コードです。
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

// 二分探索
func binarySearch(val int, arr []int) bool {
	var left = 0
	var right = len(arr)
	var mid = 0
	for left < right {
		mid = (left + right) / 2
		if val == arr[mid] {
			// 見つかった
			return true
		} else if val > arr[mid] {
			left = mid + 1
		} else {
			right = mid
		}
	}
	// 見つからなかった
	return false
}

// エントリーポイント
func main() {

	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、配列 A の要素数 N と検索する値の個数 Q が半角スペース区切りで与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var q, _ = strconv.Atoi(items[1])
	// 続く N 行では、配列 A の要素が先頭から順に与えられます。
	var a = make([]int, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		a[i], _ = strconv.Atoi(sc.Text())
	}
	// 検索速度改善のためソートする
	sort.Sort(sort.IntSlice(a))
	// 続く Q 行では、検索する値 K_1 .. K_Q が順に与えられます。
	var k = make([]int, q)
	for i := 0; i < q; i++ {
		sc.Scan()
		k[i], _ = strconv.Atoi(sc.Text())
	}
	// A に K が含まれているか調べる
	var answer = make([]string, q)
	for i, vk := range k {
		if binarySearch(vk, a) {
			answer[i] = "YES"
		} else {
			answer[i] = "NO"
		}
	}
	// 結果出力
	for _, ans := range answer {
		fmt.Println(ans)
	}

	return
}
