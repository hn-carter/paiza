/*
これはpaizaラーニングの問題集にある「グリッド版ダイクストラ問題セット」-「問題1: 幅優先探索 - 迷路 (hard)」
https://paiza.jp/works/mondai/grid_dijkstra/grid_dijkstra__d2h
にC#でチャレンジしたコードです。
作成環境
Windows 10 Pro
Microsoft Visual Studio Community 2022 (.NET 6.0)
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

class Program
{
    static void Main()
    {
        // 1 行目には盤面の行数を表す h , 盤面の列数を表す w が与えられます。
        var line1 = Console.ReadLine()!.Trim();
        string[] items = line1.Split(' ');
        var h = int.Parse(items[0]);
        var w = int.Parse(items[1]);
        // 続く h 行のうち i 行目には、i 行目のマスのコストを表す整数値のリスト t_i が与えられます。
        // t_{ i,j} は i 行目の j 列目のコストです。
        var board = new Board(h, w);
        for (var i = 0; i < h; i++)
        {
            var line2 = Console.ReadLine()!.Trim();
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
        var cost = board.Dijkstra(start, goal);
        // 結果出力
        Console.WriteLine(cost);
    }
}

// 位置を表すクラス
class Position: IComparable<Position>
{
    public Position(int y, int x)
    {
        X = x;
        Y = y;
        Cost = 0;
    }

    // x座標
    public int X { get; set; }
    // y座標
    public int Y { get; set; }
    // 現在までの移動コスト
    public int Cost { get; set; }

    // HashSetで必要
    public override int GetHashCode()
    {
        int work = (Y << 16) + X;
        return work.GetHashCode();
    }
    // HashSetで必要
    public override bool Equals(object? obj)
    {
        Position? pos = obj as Position;
        if ((Object?)pos == null) return false;
        return (X == pos.X && Y == pos.Y);
    }

    // 優先度付きキューで使用
    public int CompareTo(Position? other)
    {
        if ((object?)other == null)
        {
            return 1;
        }
        return Cost - other.Cost;
    }

    public static Position operator +(Position a, Position b)
    {
        var result = new Position(a.Y + b.Y, a.X + b.X);
        return result;
    }
    public static bool operator ==(Position a, Position b)
    {
        // どちらか片方でも null なら false
        if (((object)a == null) || ((object)b == null))
        {
            return false;
        }
        return (a.X == b.X && a.Y == b.Y);
    }
    public static bool operator !=(Position a, Position b)
    {
        return !(a == b);
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
    }

    // ダイクストラ法で問題を解く
    public int Dijkstra(Position s, Position g)
    {
        // 未チェックの移動候補
        var open = new PriorityQueue<Position>();
        // チェック済みのマス
        var closed = new HashSet<Position>();
        // 処理開始位置にスタート地点を設定
        open.Push(s);

        while (!open.IsEmpty())
        {
            // 未チェックの経路から先頭位置を取得(移動先マスを取得)
            Position st = open.Pop();
            // ゴールに到着しているか
            if (st == g)
            {
                return st.Cost;
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
                    destination.Cost = st.Cost + GetCost(destination);
                    open.Push(destination);
                }
            }
        }
        return -1;
    }

    public int GetCost(Position p)
    {
        if (IsWithinRange(p))
        {
            return cell[p.Y, p.X];
        }
        return -1;
    }

    // 渡された座標が壁か判定
    public bool IsWall(Position p)
    {
        if (IsWithinRange(p))
        {
            return (cell[p.Y, p.X] == 1);
        }
        return true;
    }

    // 渡された座標が範囲内か判定
    public bool IsWithinRange(Position p)
    {
        return (0 <= p.Y && p.Y < this.h && 0 <= p.X && p.X < this.w);
    }
}

// 優先度付きキュー（プライオリティキュー）
public class PriorityQueue<T> where T : IComparable<T>
{
    // 格納データ
    private List<T> _buffer;
    // 比較用関数
    private readonly IComparer? _comparer;

    public PriorityQueue(IComparer? comparer = null)
    {
        _buffer = new List<T>();
        _comparer = comparer;
    }

    // 要素の数
    public int Count {
        get { return _buffer.Count; }
    }

    // キューに追加する
    public void Push(T item)
    {
        // heapの末尾に要素を追加
        _buffer.Add(item);
        int insert = Count - 1;

        // 追加した要素を正しい位置へ移動
        while (insert > 0)
        {
            // 追加した要素の親
            int parent = (insert - 1) / 2;
            // 追加要素と親を比較し、小さい方が優先されるように入れ替える
            if (Compare(_buffer[parent], item) > 0)
            {
                Swap(parent, insert);
                insert = parent;
            } else
            {
                break;
            }
        }
    }

    public T Pop()
    {
        T result = Peek();
        // 優先度が低い値を先頭に持ってくる
        Swap(0, Count - 1);
        _buffer.RemoveAt(Count - 1);
        int target = 0;
        // 左右の子と比較
        int child1 = target * 2 + 1;
        int child2;

        while (child1 < Count)
        {
            child2 = target * 2 + 2;
            // 小さい子と比較する
            if (child2 < Count &&
                Compare(_buffer[child1], _buffer[child2]) > 0)
            {
                child1 = child2;
            }
            if (Compare(_buffer[target], _buffer[child1]) < 0)
            {
                break;
            }
            Swap(target, child1);
            target = child1;
            child1 = target * 2 + 1;
        }

        return result;
    }

    public bool IsEmpty()
    {
        return _buffer.Count == 0;
    }

    // 大小比較 <0 : a<b, 0 : a=b, 0< : a>b
    private int Compare(T a, T b)
    {
        if (_comparer == null)
        {
            return a.CompareTo(b);
        }
        return _comparer.Compare(a, b);
    }

    // リストを変更せずに先頭の値を返す
    public T Peek()
    {
        if (Count == 0)
        {
            throw new InvalidOperationException("Queue is empty.");
        }
        return _buffer[0];
    }

    private void Swap(int a, int b)
    {
        T tmp = _buffer[a];
        _buffer[a] = _buffer[b];
        _buffer[b] = tmp;
    }
}
