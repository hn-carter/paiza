/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最長増加連続部分列」
https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_step0
にC++でチャレンジしたコードです。

作成環境
Windows 10 Pro
Visual C++ 2019 (ISO C++14 標準)
*/
#include <algorithm>
#include <iostream>
#include <vector>
using namespace std;

int main()
{
    // 人数 n
    int n;
    cin >> n;
    // 身長 a_n
    vector<int> a(n, 0);
    for (int i = 0; i < n; ++i) {
        cin >> a[i];
    }
    // 動的計画法で問題を解く
    vector<int> dp(n, 0);
    dp[0] = 1;
    for (int i = 1; i < n; ++i) {
        if (a[i - 1] <= a[i]) {
            dp[i] = dp[i - 1] + 1;
        }
        else {
            dp[i] = 1;
        }
    }
    // 結果出力
    cout << *max_element(dp.begin(), dp.end()) << endl;
}
