/*
これはpaizaラーニングの問題集にある「グリッド版ダイクストラ問題セット」-「問題1: 幅優先探索 - 迷路 (hard)」
https://paiza.jp/works/mondai/grid_dijkstra/grid_dijkstra__d1h
にC#でチャレンジしたコードです。
作成環境
Windows 10 Pro
Microsoft Visual Studio Community 2022 (.NET 6.0)
*/

using System;
using System.Collections.Generic;
using System.Linq;

class Program
{
    static void Main()
    {
        // 1 行目には盤面の行数を表す h , 盤面の列数を表す w が与えられます。
        var line1 = Console.ReadLine().Trim();
        string[] items = line1.Split(' ');
        var h = int.Parse(items[0]);
        var w = int.Parse(items[1]);
        // 続く h 行のうち i 行目には、i 行目のマスのコストを表す整数値のリスト t_i が与えられます。
        // t_{ i,j} は i 行目の j 列目のコストです。
        var board = new Board(h, w);
        for (var i = 0; i < h; i++)
        {
            var line2 = Console.ReadLine().Trim();
            string[] words = line2.Split(' ');
            for (var j = 0; j < w; j++)
            {
                board.cell[i, j] = int.Parse(words[j]);
            }
        }
        // ゴールまで移動
        // スタート位置
        Position start = new Position(0, 0);
        //ゴール位置
        Position goal = new Position(board.h - 1, board.w - 1);
        // 移動
        board.Bfs(start, goal);
        // 結果出力
        Console.WriteLine(board.cost);
    }
}

// 1位置を表すクラス
class Position
{
    // x座標
    public int x;
    // y座標
    public int y;

    public Position(int y, int x)
    {
        this.x = x;
        this.y = y;
    }

    public static Position operator +(Position a, Position b)
    {
        var result = new Position(a.y + b.y, a.x + b.x);
        return result;
    }
    public static bool operator ==(Position a, Position b)
    {
        // どちらか片方でも null なら false
        if (((object)a == null) || ((object)b == null))
        {
            return false;
        }
        return (a.x == b.x && a.y == b.y);
    }
    public static bool operator !=(Position a, Position b)
    {
        return !(a == b);
    }
    // HashSetで必要
    public override int GetHashCode()
    {
        return y.GetHashCode() ^ x.GetHashCode();
    }
    // HashSetで必要
    public override bool Equals(object obj)
    {
        Position pos = obj as Position;
        if ((Object)pos == null) return false;
        return (x == pos.x && y == pos.y);
    }
}

// 盤面を表すクラス
class Board
{
    // 盤面の行数
    public int h;
    // 盤面の列数
    public int w;
    // マス目のコスト
    public int[,] cell;
    // 現在位置
    public Position pos;
    // 現在まで移動したコスト
    public int cost;

    // 移動可能方向
    private static Position[] MOVABLE_DIRECTION = {
            new Position(0, 1),
            new Position(-1, 0),
            new Position(0, -1),
            new Position(1, 0)
    };

    public Board(int h, int w)
    {
        this.h = h;
        this.w = w;
        this.cell = new int[h, w];
        this.pos = new Position(0, 0);
        this.cost = 0;
    }

    // 幅優先探索(Breadth First Search)で問題を解く
    public void Bfs(Position s, Position g)
    {
        // 未チェックの移動候補
        var open = new LinkedList<Position>();
        // チェック済みのマス
        var closed = new HashSet<Position>();
        // 処理開始位置にスタート地点を設定
        open.AddFirst(s);
        // 移動コストの初期化
        this.cost = 1;

        while (true)
        {
            // 移動先のマスを追加していくリスト
            var tmpQ = new LinkedList<Position>();

            while (open.Count > 0)
            {
                // 未チェックの経路から先頭位置を取得(移動先マスを取得)
                Position st = open.First.Value;
                open.RemoveFirst();
                // ゴールに到着しているか
                if (st == g) {
                    return;
                }
                // 移動先が壁なら処理スキップ
                if (IsWall(st))
                {
                    continue;
                }
                // 移動先がすでにチェック済みのマスなら処理スキップ
                if (closed.Contains(st))
                {
                    continue;
                }
                // ここの処理に来るということは移動先マスに移動することができるということ
                // 移動先マスを移動済みとして保存
                closed.Add(st);
                // 次に移動するマスを追加する
                // 移動可能方向数分ループし、盤面の範囲外でなければ次の移動先としてリストに追加
                foreach (Position v in MOVABLE_DIRECTION)
                {
                    Position destination = st + v;
                    if (IsWithinRange(destination))
                    {
                        tmpQ.AddLast(destination);
                    }
                }

            }
            open = tmpQ;
            // 1マス進んだ
            this.cost++;
        }
    }

    // 渡された座標が壁か判定
    public bool IsWall(Position p)
    {
        if (IsWithinRange(p))
        {
            return (cell[p.y, p.x] == 1);
        }
        return true;
    }

    // 渡された座標が範囲内か判定
    public bool IsWithinRange(Position p)
    {
        return (0 <= p.y && p.y < this.h && 0 <= p.x && p.x < this.w);
    }
}
