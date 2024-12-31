# これはpaizaラーニングの「ハッシュメニュー応用編」-「画ハッシュテーブルの衝突」に
# Python3でチャレンジしたコードです。
# https://paiza.jp/works/mondai/hash_advanced/hash_advanced__collision
# 
# 作成環境
# Ubuntu 22.04.5 LTS
# Python 3.10.12 (main, Nov  6 2024, 20:22:13) [GCC 11.4.0]

# ハッシュテーブルの衝突数を求める

# ハッシュ値１を求める
# parameters
#   dateNumber 日付を表す値yyyyMMdd
# return ハッシュ値１
def getHash1(dateNumber):
    return dateNumber % 10000

# ハッシュ値２を求める
# parameters
#   dateNumber 日付を表す値yyyyMMdd
# return ハッシュ値２
def getHash2(dateNumber):
    return dateNumber // 10000

# 1 行目にデータの数を表す整数 N が与えられます。
n = int(input())
# ハッシュ値の衝突を判定する配列を用意する
h1Table = [0] * 10000
h2Table = [0] * 2023
# i + 1 行目に日付を表す整数 d_i が与えられます。(1 ≦ i ≦ N)
for i in range(n):
    d_n = int(input())
    # ハッシュ値を求め判定配列に設定する
    h1 = getHash1(d_n)
    h1Table[h1] += 1
    h2 = getHash2(d_n)
    h2Table[h2] += 1
# 衝突したハッシュ値を数える
h1Counter = 0
for v in h1Table:
    if v > 1:
        h1Counter += v - 1
h2Counter = 0
for v in h2Table:
    if v > 1:
        h2Counter += v - 1
# 結果出力
print(h1Counter)
print(h2Counter)
