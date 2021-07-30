/*
これはpaizaラーニングの「クエリメニュー」から「アイドルグループ」
https://paiza.jp/works/mondai/query_primer/query_primer__idle_group
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

// データ
type Node struct {
	// ソートに使用するキー項目
	key    string
	parent *Node
	left   *Node
	right  *Node
}

// データのコンストラクタ
func NewNode(val string) *Node {
	return &Node{key: val, parent: nil, left: nil, right: nil}
}

// データを格納する入れ物
// 2分探索木
// データを木構造で、キーが小さいのを左、大きいのを右に配置する
type Tree struct {
	root *Node
}

// 入れ物を空で新規作成
func NewTree() *Tree {
	var ret = new(Tree)
	ret.root = nil
	return ret
}

// データを追加
func (t *Tree) Append(val string) {
	// 追加するデータの入れ物
	var add *Node = NewNode(val)
	// 追加するデータの挿入位置
	var insPos *Node = nil
	// データの挿入位置を求めるための変数
	var v = t.root
	for v != nil {
		insPos = v
		if val < v.key {
			// 追加する値が小さいので左へ移動
			v = v.left
		} else {
			// 右へ移動
			v = v.right
		}
	}
	// 追加データの親を設定
	add.parent = insPos
	// 入れ物に追加データを設定
	if insPos == nil {
		//入れ物が空の場合
		t.root = add
	} else if val < insPos.key {
		//小さいので左に置く
		insPos.left = add
	} else {
		//大きいので右に置く
		insPos.right = add
	}
}

// データを検索
func (t *Tree) Find(key string) *Node {
	// 木の先頭から探索
	var pos = t.root
	// 木の末端か、データが見つかるまでループ
	for pos != nil && pos.key != key {
		// 探したいデータが小さければ左へ、大きければ右へたどった行く
		if key < pos.key {
			pos = pos.left
		} else {
			pos = pos.right
		}
	}
	return pos
}

// 小さいノードを返す
func (t *Tree) getMinNode(n *Node) *Node {
	var leftNode *Node = n
	for leftNode.left != nil {
		leftNode = leftNode.left
	}
	return leftNode
}

// データを削除
func (t *Tree) Delete(key string) {
	// 削除データを取得
	var del = t.Find(key)
	if del == nil {
		return
	}
	// 木から削除するノード del の位置に持ってくるノード x を求める
	var x *Node = nil
	if del.left == nil || del.right == nil {
		// 子が無いまたは、1つの場合は削除データのノードが削除対象
		x = del
	} else {
		// 子が2つの場合次に大きいノードが削除対象
		x = t.getMinNode(del.right)
	}
	// ノード x の子 y を決める
	var y *Node = nil
	if x.left != nil {
		y = x.left
	} else {
		y = x.right
	}
	// ノード x が移動してしまうので子の y に新しい親を設定する
	if y != nil {
		y.parent = x.parent
	}
	// ノード x を削除されたノードの位置に持っていく
	if x.parent == nil {
		t.root = y
	} else if x == x.parent.left {
		x.parent.left = y
	} else {
		x.parent.right = y
	}
	// 削除対象のノードが削除された場合
	if x != del {
		// 削除されたノード位置に次のデータをコピーする
		del.key = x.key
	}
}

// 順番にデータを表示する
func (t *Tree) Print() {
	t.printNode(t.root)
}

// 木の末端までたどりながら出力する
func (t *Tree) printNode(n *Node) {
	if n == nil {
		return
	}
	// 小さい値(左側)から出力
	t.printNode(n.left)
	fmt.Println(n.key)
	// 小さい値が出力し終わったら大きい値(右側)を出力
	t.printNode(n.right)
}

// エントリーポイント
func main() {

	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、アイドルグループの初期メンバー数 N とイベントの回数 K が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 続く N 行では、N 人の初期メンバーの名前が与えられます。
	var nameList = NewTree()
	for i := 0; i < n; i++ {
		sc.Scan()
		nameList.Append(sc.Text())
	}
	// 続く K 行では、起こったイベントを表す文字列が時系列順に与えられます。
	var event = make([]string, k)
	for i := 0; i < k; i++ {
		sc.Scan()
		event[i] = sc.Text()
	}
	// イベントを実後
	for _, e := range event {
		var eItems []string = strings.Split(e, " ")
		switch eItems[0] {
		case "join":
			// "join name" name という名前のアイドルが加入することを表す。
			nameList.Append(eItems[1])
		case "leave":
			// "leave name" name という名前のアイドルが脱退することを表す。
			nameList.Delete(eItems[1])
		case "handshake":
			// "handshake" 握手会が行われることを表す。
			nameList.Print()
		}
	}

	return
}
