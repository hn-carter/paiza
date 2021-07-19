/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最長増加連続部分列」
https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_step0
にKotlinでチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
kotlinc-native 1.5.0-743 (JRE 16.0.1+9-Ubuntu-120.04)
*/

fun main() {
    // 人数 n
    val n = readLine()!!.toInt()
    // 身長 a_n
    val a = IntArray(n)
    for (i in a.indices) {
        a[i] = readLine()!!.toInt()
    }
    // 動的計画法で問題を解く
    val dp = IntArray(n)
    dp[0] = 1
    for (i in 1 until n) {
        if (a[i-1] <= a[i]) {
            dp[i] = dp[i-1] + 1
        } else {
            dp[i] = 1
        }
    }
    // 結果出力
    println(dp.maxOrNull()!!)
}