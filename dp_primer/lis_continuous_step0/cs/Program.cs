/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最長増加連続部分列」
https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_step0
にC#でチャレンジしたコードです。

作成環境
Windows 10 Pro
Microsoft Visual Studio Community 2019 (.NET 5.0)
*/
using System;
using System.Linq;

class Program
{
    static void Main()
    {
        // 人数 n
        var line1 = Console.ReadLine().Trim();
        var n = int.Parse(line1);
        // 身長 a_n
        var a = new int[n];
        for (var i = 0; i < n; i++)
        {
            var line2 = Console.ReadLine().Trim();
            a[i] = int.Parse(line2);
        }
        // 動的計画法で問題を解く
        var dp = new int[n];
        dp[0] = 1;
        for (var i = 1; i < n; i++)
        {
            if (a[i-1] <= a[i])
            {
                dp[i] = dp[i - 1] + 1;
            } else
            {
                dp[i] = 1;
            }
        }
        // 結果出力
        Console.WriteLine(dp.Max());
    }
}
