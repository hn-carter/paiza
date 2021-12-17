/*
これはpaizaラーニングの「二分探索メニュー」から「太巻きを分けよう (おなかペコペコ)」
にGo言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/binary_search/binary_search__application_step2

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

// エントリーポイント
func main() {

	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1行目に、太巻きの長さ L と、分け合う人数 n と、切れ目の数 k が与えられます。
	sc.Scan()
	var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
	var L, _ = strconv.Atoi(items[0])
	var n, _ = strconv.Atoi(items[1])
	var k, _ = strconv.Atoi(items[2])
	// 2行目に、切れ目 A_i が半角スペース区切りで与えられます。
	var a []int = make([]int, k+2)
	sc.Scan()
	var itemsA []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
	a[0] = 0
	for i := 0; i < k; i++ {
		a[i+1], _ = strconv.Atoi(itemsA[i])
	}
	a[k+1] = L // 切れ目配列の最後に全体の長さをセット
	// 答えを求める
	var left int = 0
	var right int = L + 1
	var mid int = 0
	for (right - left) > 1 {
		mid = (left + right) / 2
		//fmt.Printf("left= %d right= %d mid= %d\n", left, right, mid)
		// 切れ目配列の処理位置
		var pos int = 0
		// 分割出来た数
		var num int = 0
		for j := 0; j < k+2; j++ {
			if a[j]-a[pos] >= mid {
				pos = j
				num++
			}
		}
		if num < n {
			// 長くて分けきれなかったので減らす
			right = mid
		} else {
			left = mid
		}
	}
	// 結果出力
	fmt.Println(left)

	return
}
