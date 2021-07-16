/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最安値を達成するには 2」
https://paiza.jp/works/mondai/dp_primer/dp_primer_apples_step1
にC++でチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
g++ (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
*/
#include <iostream>
#include <vector>
#include <climits>

using namespace std;

int main() {
    int n, a, b;
    cin >> n >> a >> b;

    vector<int> dp(n + 5, 0);
    dp[0] = 0;
    for (size_t i = 1, max = n + 4; i <= max; ++i) {
        if (i <= 2) {
            dp[i] = min(a, b);
        } else if (i <= 5) {
            dp[i] = min(dp[i-2] + a, b);
        } else {
            dp[i] = min(dp[i-2] + a, dp[i-5] + b);
        }
    }
    int result = INT_MAX;
    for (size_t i = n, max = n + 4; i <= max; ++i) {
        result = min(result, dp[i]);
    }

    cout << result << endl;
    return 0;
}