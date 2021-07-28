/*
これはpaizaラーニングの「クエリメニュー」から「連想配列(query)」
https://paiza.jp/works/mondai/query_primer/query_primer__map_normal
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

// エントリーポイント
func main() {

	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、初めに覚える生徒の人数 N と与えられるイベントの回数 K が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 続く N 行のうち i 行目 (1 ≦ i ≦ N) では、i 番目の生徒の出席番号と識別 ID の組 num_i , ID_i が半角スペース区切りで与えられます。
	var students map[int]string = map[int]string{}
	for i := 0; i < n; i++ {
		sc.Scan()
		var s []string = strings.Split(sc.Text(), " ")
		var num, _ = strconv.Atoi(s[0]) // 出席番号
		students[num] = s[1]            // 出席番号で識別IDが取得できる
	}
	// 続く K 行では、起きるイベントを表す文字列 S_i (1 ≦ i ≦ K) が与えられます。
	var s = make([]string, k)
	for i := 0; i < k; i++ {
		sc.Scan()
		s[i] = sc.Text()
	}
	// イベントに従って処理を行う
	for _, event := range s {
		var eventItems = strings.Split(event, " ")
		switch eventItems[0] {
		case "join":
			// "join num id" 生徒番号 num , 識別ID id の生徒を新たに覚える
			var num, _ = strconv.Atoi(eventItems[1])
			students[num] = eventItems[2]
		case "leave":
			// "leave num" 生徒番号 num の生徒を忘れる
			var num, _ = strconv.Atoi(eventItems[1])
			delete(students, num)
		case "call":
			// "call num" 生徒番号 num の生徒の識別 ID を出力する
			var num, _ = strconv.Atoi(eventItems[1])
			var val, e = students[num]
			if e {
				fmt.Println(val)
			} else {
				fmt.Fprintf(os.Stderr, "%dの生徒は存在しない\n", num)
			}
		}
	}

	return
}
