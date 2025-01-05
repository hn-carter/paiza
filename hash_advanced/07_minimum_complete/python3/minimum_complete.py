# これはpaizaラーニングの「ハッシュメニュー応用編」-「最小完全ハッシュ関数を作ろう」に
# Python3でチャレンジしたコードです。
# https://paiza.jp/works/mondai/hash_advanced/hash_advanced__minimum_complete
# 
# 作成環境
# Ubuntu 22.04.5 LTS
# Python 3.10.12 (main, Nov  6 2024, 20:22:13) [GCC 11.4.0]

# ハッシュ関数
# parameters
#   s 文字列
# return sのハッシュ値
def hashFunction(s):
    string = 'abcdef'
    total = 0
    length = len(s)
    for i in range(length):
        index = string.find(s[length - i - 1])
        total += index * 6 ** i
    return total

# 最小完全ハッシュ関数を作る

# 文字列 s が与えられます。
s = input().strip()
# ハッシュ値を求める
hashValue = hashFunction(s)
# 結果出力
print(hashValue)
