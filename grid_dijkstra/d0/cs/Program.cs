/*
これはpaizaラーニングの問題集にある「グリッド版ダイクストラ問題セット」-「問題0: グリッド上の移動」
https://paiza.jp/works/mondai/grid_dijkstra/grid_dijkstra__d0
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
        // 2次元配列上の移動方向を定義する 右、上、左、下
        // V_RIGHT は右へ移動するベクトル
        var V_RIGHT = new Vector(0, 1);
        // V_UP は上へ移動するベクトル
        var V_UP = new Vector(-1, 0);
        // V_LEFT は左へ移動するベクトル
        var V_LEFT = new Vector(0, -1);
        // V_DOWN は下へ移動するベクトル
        var V_DOWN = new Vector(1, 0);
        // 「右、下、右、上、左」と順に移動
        var travel = new Queue<Vector>();
        travel.Enqueue(V_RIGHT);
        travel.Enqueue(V_DOWN);
        travel.Enqueue(V_RIGHT);
        travel.Enqueue(V_UP);
        travel.Enqueue(V_LEFT);

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
        // 移動
        while (travel.Count > 0)
        {
            board.move(travel.Dequeue());
        }
        // 結果出力
        Console.WriteLine(board.cost);
    }
}

// ベクトルを表すクラス
class Vector
{
    // x は列方向の移動量
    public int x;
    // y は行方向の移動量
    public int y;

    public Vector(int y, int x)
    {
        this.x = x;
        this.y = y;
    }

    public static Vector operator +(Vector a, Vector b)
    {
        var result = new Vector(a.y + b.y, a.x + b.x);
        return result;
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
    public Vector pos;
    // 現在まで移動したコスト
    public int cost;

    public Board(int h, int w)
    {
        this.h = h;
        this.w = w;
        this.cell = new int[h, w];
        this.pos = new Vector(0, 0);
        this.cost = 0;
    }

    public void move(Vector v)
    {
        this.pos = this.pos + v;
        this.cost += this.cell[this.pos.y, this.pos.x];
    }
}
