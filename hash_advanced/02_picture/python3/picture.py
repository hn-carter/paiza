# これはpaizaラーニングの「ハッシュメニュー応用編」-「画像のハッシュ値」に
# Python3でチャレンジしたコードです。
# https://paiza.jp/works/mondai/hash_advanced/hash_advanced__picture
# 
# 作成環境
# Ubuntu 22.04.5 LTS
# Python 3.10.12 (main, Nov  6 2024, 20:22:13) [GCC 11.4.0]

# 画像のハッシュ値を求める
# H(picture) = 各 # の (i^2 * j) の和 % 100

# 各 # についてその位置 i, j を求めて (i^2 * j)の合計
total = 0
# 6行の画像 (picture)を処理する
for i in range(1, 7):
    line = input().strip()
    for idx, c in enumerate(line):
        if c == '#':
            j = idx + 1
            total += i ** 2 * j

hash = total % 100
# 結果出力
print(hash)
