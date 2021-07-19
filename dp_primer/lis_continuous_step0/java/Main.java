/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最長増加連続部分列」
https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_step0
にJavaでチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
openjdk version "16.0.1" 2021-04-20
*/

import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        Scanner sc =new Scanner(System.in);
        // 人数 n
        int n = sc.nextInt();
        // 身長 a_n
        int[] a = new int[n];
        for (int i = 0; i < n; i++) {
            a[i] = sc.nextInt();
        }
        sc.close();
        // 動的計画法で問題を解く
        int[] dp = new int[n];
        dp[0] = 1;
        for (int i = 1; i < n; i++) {
            if (a[i-1] <= a[i]) {
                dp[i] = dp[i-1] + 1;
            } else {
                dp[i] = 1;
            }
        }
        // 結果出力
        int max = dp[0];
        for (int i = 1, len = dp.length; i < len; i++) {
            if (max < dp[i]) {
                max = dp[i];
            }
        }
        System.out.println(max);
    }
}