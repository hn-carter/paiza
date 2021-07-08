/*
これはpaizaラーニングの「グリッド版ダイクストラ問題セット」から「問題3: ダイクストラ法 - 経路復元」
https://paiza.jp/works/mondai/grid_dijkstra/grid_dijkstra__d3
にGo言語でチャレンジした試行錯誤コードです。
Go初心者が学習用に作ったコードなので本来は不要な処理があります。
*/

/*
問題の解き方はpaiza開発日誌「最短経路問題で頻出の「ダイクストラ法」とは？練習問題で徹底解説」
https://paiza.hatenablog.com/entry/2020/11/27/150000
の通りです。

構造体 Position 盤面上の位置を表す
関数   func (p *Position) Equal(o *Position) bool ： 2つの位置が同一か判定する
       func (p *Position) Plus(o *Position) *Position ： 2つの位置を加算する

構造体 Board　盤面を表す
関数   func NewBoard(h int, w int) *Board ： 盤面を初期作成する
       func (b *Board) IsWithinRange(p *Position) bool ： 位置が盤面上か判定する
       func (b *Board) GetCost(p Position) int ： 指定位置のコストを返す
       func (b *Board) dijkstra(s Position, g Position) error ： 問題を解く　この問題のメイン

構造体 Route 通過経路を表す
関数   func NewRoute(p Position, c int) *Route ： 通過経路を新規作成する

PriorityQueue 通過経路の優先度付きキューを定義
go言語の"container/heap"を使用して優先度付きキューを実装
関数   func (pq PriorityQueue) Len() int 通過経路キューの要素数を返す
       func (pq PriorityQueue) Less(i, j int) bool ： 優先度付きキューの優先度判定に使用
       func (pq PriorityQueue) Swap(i, j int) ： 優先度付きキューの並べ替えに使用
       func (pq *PriorityQueue) Push(x interface{}) ： 優先度付きキューにアイテムを追加する
       func (pq *PriorityQueue) Pop() interface{} ： 優先度付きキューからアイテムを取り出す
*/

package main

import (
	"bufio"
	"container/heap"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
)

///////////////////////////
// ここからPosition構造体定義
// 盤面の位置を表す構造体
type Position struct {
	// x は列 0〜W-1
	x int
	// y は行 0〜H-1
	y int
}

// Equal は盤面位置が同じか判定する
func (p *Position) Equal(o *Position) bool {
	if o == nil {
		return false
	} else {
		return p.x == o.x && p.y == o.y
	}
}

// Plus は盤面位置を加算する　ただし、位置の範囲外チェックは行わない
func (p *Position) Plus(o *Position) *Position {
	if o == nil {
		return nil
	}
	// 加算した位置を生成し、返す
	// ここでは範囲外チェックは行わない
	var result Position = Position{x: p.x + o.x, y: p.y + o.y}
	return &result
}

// ここまでPosition構造体定義
///////////////////////////

// 盤面上の移動可能方向を定義する 右、上、左、下の4方向
// var定義だが定数のように使うことにする
var MOVABLE_DIRECTION []Position = []Position{
	{x: 1, y: 0},
	{x: 0, y: -1},
	{x: -1, y: 0},
	{x: 0, y: 1}}

///////////////////////////////
// ここから通過経路構造体定義
// 通過経路
type Route struct {
	// 現在位置
	pos Position
	// 現在地までのコスト
	cost int
	// 現在位置に来る直前にいたルート
	ref *Route
	// indexはヒープの更新のために使用する
	index int
}

// NewRoute は通過経路のコンストラクタ
// i p      : 位置
//   c      : コスト初期値
//   r      : 一つ前にいた位置
// o *Route : 初期化した通過経路
func NewRoute(p Position, c int, r *Route) *Route {
	var result *Route = new(Route)
	result.pos = p
	result.cost = c
	result.ref = r
	return result
}

// ここまで通過経路構造体定義
///////////////////////////////

///////////////////////////////////
// ここから優先度付きキューの定義
// 通過経路の優先度付きキューを定義
type PriorityQueue []*Route

// 優先度付きキューの要素数を返す
func (pq PriorityQueue) Len() int {
	return len(pq)
}

// 優先度を判定するためのLess関数
func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].cost < pq[j].cost
}

// キュー内のアイテム位置を入れ替える
func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
	pq[i].index = i
	pq[j].index = j
}

// キューにアイテムを追加する
func (pq *PriorityQueue) Push(x interface{}) {
	var n int = len(*pq)
	var item *Route = x.(*Route)
	item.index = n
	*pq = append(*pq, item)
}

// キューから先頭のアイテムを取り出し、元の配列から削除する
func (pq *PriorityQueue) Pop() interface{} {
	var old PriorityQueue = *pq
	var n int = len(old)
	var item *Route = old[n-1]
	old[n-1] = nil  // メモリリーク対策
	item.index = -1 // 削除されている
	*pq = old[0 : n-1]
	return item
}

// ここまで優先度付きキューの定義
///////////////////////////////////

/////////////////////////////
// ここから盤面構造体の定義
// Board は盤面を表す構造体
type Board struct {
	h    int     // h は盤面の行数
	w    int     // w は盤面の列数
	cell [][]int // cell はマス目のコスト

	r Route // 最短経路
}

// NewBoard はBoard(盤面)のコンストラクタ
// i h      : 盤面の行数
//   w      : 盤面の列数
// o *Board : 初期化した盤面
func NewBoard(h int, w int) *Board {
	var result *Board = new(Board)
	result.h = h
	result.w = w
	// 2次元sliceの初期化 [高さ][幅]
	result.cell = make([][]int, h)
	for i := range result.cell {
		result.cell[i] = make([]int, w)
	}
	var pos Position = Position{x: 0, y: 0}
	result.r = *NewRoute(pos, 0, nil)

	return result
}

// IsWithinRange は渡された位置が盤面の範囲内か判定する
// i p    : 盤面位置
// o bool : trueなら範囲内
func (b *Board) IsWithinRange(p Position) bool {
	return 0 <= p.y && p.y < b.h && 0 <= p.x && p.x < b.w
}

// GetCost は指定位置のコストを返す
// i p   : 盤面位置
// o int : マスのコスト 範囲外なら-1を返す
func (b *Board) GetCost(p Position) int {
	if b.IsWithinRange(p) {
		return b.cell[p.y][p.x]
	}
	return -1
}

// dijkstra はダイクストラ法で最短経路のコストを求める
// i s     : スタート位置
//   g     : ゴール位置
// o error : エラー
func (b *Board) dijkstra(s Position, g Position) error {
	// 移動先のマス
	var open PriorityQueue = make(PriorityQueue, 0)
	heap.Init(&open)
	// チェック済みのマス
	var closed map[Position]bool = make(map[Position]bool)
	// 開始位置にスタート地点を設定
	var start *Route = NewRoute(s, b.GetCost(s), nil)
	heap.Push(&open, start)
	for open.Len() > 0 {
		// 未チェックの経路から先頭位置を取得(移動先マスを取得)
		var st *Route = heap.Pop(&open).(*Route)
		// ゴール
		if st.pos.Equal(&g) {
			b.r = *st
			return nil
		}
		// 移動先がすでにチェック済みのマスなら処理スキップ
		// mapはキーのデータがなければ0を返す　0はbool値でfalseを表す
		if closed[st.pos] {
			continue
		}
		// ここの処理に来るということは移動先マスに移動することができるということ
		// 移動先マスを移動済みとして保存
		closed[st.pos] = true
		// 次に移動するマスを追加する
		// 移動可能方向数分ループし、盤面の範囲外でなければマスのコストを加算し
		// 次の移動先としてリストに追加
		for _, p := range MOVABLE_DIRECTION {
			var destination Position = *st.pos.Plus(&p)
			if b.IsWithinRange(destination) {
				var newCost = st.cost + b.GetCost(destination)
				var newRoute *Route = NewRoute(destination, newCost, st)
				//fmt.Println(newRoute)
				//fmt.Println(open)
				heap.Push(&open, newRoute)
			}
		}
	}
	// ゴールへたどり着けなかった
	// 通常ならばここに来ることはない
	return errors.New("ゴールへたどり着けませんでした。")
}

// ここまで盤面構造体の定義
/////////////////////////////

// convertNumArray はスペース区切り文字列を数値配列に変換する
// i str     : 処理対象文字列
// o []int   : 結果数値配列 変換にできない場合は0がセットされる
//   []error : 変換に失敗した場合に返す
func convertNumArray(str string) ([]int, []error) {
	var items []string = strings.Split(str, " ")
	var length int = len(items)
	var result []int = make([]int, length)
	// エラーをsliceで定義
	var err []error
	// 配列の個数分繰り返す iに0開始のループ回数、sに要素が入る
	for i, s := range items {
		// intに変換
		if num, e := strconv.Atoi(s); e == nil {
			// 変換成功
			result[i] = num
		} else {
			// sliceに追加
			err = append(err, errors.New(fmt.Sprintf(
				"[%d]番目 : [%s] 数値への変換に失敗しました。", (i+1), s)))
			result[i] = 0
		}
	}
	// エラー値はエラーがない場合はnilを返す
	if len(err) == 0 {
		return result, nil
	} else {
		return result, err
	}
}

// inputData は処理に必要なデータを入力する処理
// 0 *Board : 盤面情報
//   error  : 処理続行不可なエラーが発生した場合に設定される
func inputData() (*Board, error) {
	// 標準入力のScanner
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)

	// 1行目には盤面の行数を表す h , 盤面の列数を表す w が与えらる
	var ret bool = sc.Scan()
	if ret == false {
		return nil, errors.New("1行目が読み込めませんでした。")
	}
	var numbers1, err1 = convertNumArray(sc.Text())
	if err1 != nil || len(numbers1) != 2 {
		return nil, errors.New("1行目は不正な内容です。")
	}
	if numbers1[0] < 1 || 20 < numbers1[0] {
		return nil, errors.New(
			fmt.Sprintf("盤面の行数[%d]が範囲外です。", numbers1[0]))
	}
	if numbers1[1] < 1 || 20 < numbers1[1] {
		return nil, errors.New(
			fmt.Sprintf("盤面の列数[%d]が範囲外です。", numbers1[1]))
	}
	// 盤面の返却値を作成
	var board = NewBoard(numbers1[0], numbers1[1])

	// 2行目からのh行に盤面情報が与えられる
	// 盤面情報はスペース区切りの数字文字列になっている
	for i := 0; i < board.h; i++ {
		var ret bool = sc.Scan()
		if ret == false {
			return nil, errors.New(fmt.Sprintf(
				"[%d]行目が読み込めませんでした。", (i + 2)))
		}
		var line string = sc.Text()
		var numbers2, err2 = convertNumArray(line)
		if err2 != nil || len(numbers2) != board.w {
			return nil, errors.New(fmt.Sprintf(
				"[%d]行目は不正な内容です。[%s]", (i + 2), line))
		}
		for j := 0; j < board.w; j++ {
			if numbers2[j] < 0 || 100 < numbers2[j] {
				return nil, errors.New(fmt.Sprintf(
					"[%d]行目のマス情報が範囲外です。[%d]", (i + 2), numbers2[j]))
			}
			board.cell[i][j] = numbers2[j]
		}
	}

	return board, nil
}

// computeData は問題を解く
// i b     : 盤面情報
// o error : 処理続行不可なエラー発生時のみ返す
func computeData(b *Board) error {
	if b == nil {
		return errors.New("入力データがありません。")
	}

	// スタート位置
	var start Position = Position{x: 0, y: 0}
	//ゴール位置
	var goal Position = Position{x: b.w - 1, y: b.h - 1}
	b.dijkstra(start, goal)

	return nil
}

// outputData は処理結果を出力する
// i b     : 盤面情報
// o error : 処理続行不可なエラー発生時のみ返す
func outputData(b *Board) error {
	if b == nil {
		return errors.New("入力データがありません。")
	}
	// 最小のコストを出力する
	fmt.Println(b.r.cost)
	// 通過経路を出力する
	var r *Route = &b.r
	var line string = ""
	for r != nil {
		fmt.Println("--")
		for y := 0; y < b.h; y++ {
			line = ""
			for x := 0; x < b.w; x++ {
				if r.pos.x == x && r.pos.y == y {
					line += "*"
				} else {
					line += " "
				}
				line += strconv.Itoa(b.cell[y][x])
			}
			fmt.Println(line)
		}
		r = r.ref
	}
	return nil
}

// main はエントリーポイント
func main() {
	// データ入力
	var board, err1 = inputData()
	if err1 != nil {
		fmt.Fprintln(os.Stderr, err1)
		return
	}
	// 処理実行
	var err2 = computeData(board)
	if err2 != nil {
		fmt.Fprintln(os.Stderr, err2)
		return
	}
	// 結果出力
	var err3 = outputData(board)
	if err3 != nil {
		fmt.Fprintln(os.Stderr, err3)
		return
	}
	return
}
