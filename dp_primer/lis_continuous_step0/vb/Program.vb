' これはpaizaラーニングの問題集にある「DPメニュー」-「最長増加連続部分列」
' https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_step0
' にVisual Basicでチャレンジしたコードです。
'
' 作成環境
' Windows 10 Pro
' Microsoft Visual Studio Community 2019 (.NET 5.0)

Imports System

Module Program
    Sub Main()
        ' 人数 n
        Dim line1 As String = Console.ReadLine().Trim()
        Dim n As Integer = Integer.Parse(line1)
        ' 身長 a_n
        Dim a(n) As Integer
        For i As Integer = 0 To n - 1
            Dim line2 As String = Console.ReadLine().Trim()
            a(i) = Integer.Parse(line2)
        Next
        ' 動的計画法で問題を解く
        Dim dp(n) As Integer
        dp(0) = 1
        For i As Integer = 1 To n - 1
            If a(i - 1) <= a(i) Then
                dp(i) = dp(i - 1) + 1
            Else
                dp(i) = 1
            End If
        Next
        ' 結果出力
        Dim max As Integer = dp(0)
        For i As Integer = 1 To n - 1
            If max < dp(i) Then
                max = dp(i)
            End If
        Next
        Console.WriteLine(max)
    End Sub
End Module
