/*
これはpaizaラーニングの「クエリメニュー」から「点の幅」
https://paiza.jp/works/mondai/query_primer/query_primer__range_of_score
にGo言語でチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
go version go1.16.4 linux/amd64
*/
package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

// 試合
type Match struct {
	// プレイヤー A が選んだ生徒番号
	Al int
	Ar int
	//プレイヤー B が選んだ生徒番号
	Bl int
	Br int
}

// 試合場
type Battlefield struct {
	// 生徒数
	N int
	// 最大選択可能生徒数
	Valid int
	// 生徒番号毎の点数
	A []int
	// ある範囲毎の最大値
	MaxList []int
	// ある範囲毎の最小値
	MinList []int
	// 最大値を求めた区間の生徒数
	Interval int
}

// 前準備
func NewBf(n int, a []int) *Battlefield {
	var ret = new(Battlefield)
	ret.N = n
	ret.A = a
	// n / 2 以下の生徒の数でない場合は無効
	ret.Valid = int(math.Floor(float64(n) / 2.0))
	// 最大・最小値を求める区間
	ret.Interval = int(math.Sqrt(float64(n)))
	ret.MaxList = make([]int, ret.Interval)
	ret.MinList = make([]int, ret.Interval)
	for i := 0; i < ret.Interval; i++ {
		ret.MaxList[i] = math.MinInt32
		ret.MinList[i] = math.MaxInt32
		var begin = i * ret.Interval
		var end = begin + ret.Interval
		for j := begin; j < end; j++ {
			if ret.MaxList[i] < a[j] {
				ret.MaxList[i] = a[j]
			}
			if ret.MinList[i] > a[j] {
				ret.MinList[i] = a[j]
			}
		}
	}
	return ret
}

// 試合を行い結果を返す
func (bf *Battlefield) PlayMatch2(m Match) string {
	// プレイヤー A、Bの得点差を求める
	var a int = bf.PlayMatch(m.Al, m.Ar)
	var b int = bf.PlayMatch(m.Bl, m.Br)
	if a == b {
		return "DRAW"
	} else if a > b {
		return "A"
	}
	return "B"
}

// 生徒番号 begin と end の間で最大となる点数の差を返す
func (bf *Battlefield) PlayMatch(begin int, end int) int {
	// 選択生徒数が有効範囲か確認する
	if bf.Valid < (end - begin + 1) {
		return -1
	}
	// 配列は0始まりのため-1する
	var b = begin - 1
	var e = end - 1
	var min = math.MaxInt32
	var max = math.MinInt32
	for b <= e {
		// あらかじめ求めておいた区間内に収まるか判定
		var remainder int = b % bf.Interval
		var limit int = b + bf.Interval - 1
		if (remainder) == 0 && limit <= e {
			// 区間内に収まる場合
			var i = int(b / bf.Interval)
			if max < bf.MaxList[i] {
				max = bf.MaxList[i]
			}
			if min > bf.MinList[i] {
				min = bf.MinList[i]
			}
			b += bf.Interval
		} else {
			// 区切りの区間からはみ出る場合
			if max < bf.A[b] {
				max = bf.A[b]
			}
			if min > bf.A[b] {
				min = bf.A[b]
			}
			b++
		}
	}
	// 区間の最大差
	return max - min
}

// エントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、生徒数 N とおこなわれる試合数 K が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 続く N 行のうち、i 行目では、生徒番号 i の生徒のテストの得点 S_i が与えられます。
	var a = make([]int, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		a[i], _ = strconv.Atoi(strings.TrimSpace(sc.Text()))
	}
	// 続く K 行のうち、i 行目では、i 試合目のプレイヤー A が選んだ生徒のうち、
	// 最小の生徒番号と最大の生徒番号 A_{l_i} , A_{r_i} とプレイヤー B が選んだ生徒のうち、
	// 最小の生徒番号と最大の生徒番号 B_{l_i} , B_{r_i} が与えられます。
	var matchList = make([]Match, k)
	for i := 0; i < k; i++ {
		sc.Scan()
		var itemsI []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
		matchList[i].Al, _ = strconv.Atoi(itemsI[0])
		matchList[i].Ar, _ = strconv.Atoi(itemsI[1])
		matchList[i].Bl, _ = strconv.Atoi(itemsI[2])
		matchList[i].Br, _ = strconv.Atoi(itemsI[3])
	}
	// 試合準備
	var battlefield = NewBf(n, a)
	// 試合結果出力
	for _, match := range matchList {
		fmt.Println(battlefield.PlayMatch2(match))
	}

	return
}
