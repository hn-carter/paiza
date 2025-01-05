# これはpaizaラーニングの「ハッシュメニュー応用編」-「2 次元のハッシュテーブルを使おう」に
# Python3でチャレンジしたコードです。
# https://paiza.jp/works/mondai/hash_advanced/hash_advanced__two_dimention
# 
# 作成環境
# Ubuntu 22.04.5 LTS
# Python 3.10.12 (main, Nov  6 2024, 20:22:13) [GCC 11.4.0]

# ハッシュ関数X
# Hx(X) = X % A
# parameters
#   x X座標 1 ≦ X ≦ 100,000
# return xのハッシュ値
def hashFunctionX(x):
    return x % A
# ハッシュ関数Y
# Hy(Y) = Y % B
# parameters
#   y Y座標 1 ≦ Y ≦ 100,000
# return yのハッシュ値
def hashFunctionY(y):
    return y % B

# 2次元のハッシュテーブルを使う

# 1 行目に点の個数を表す整数 N と
# 調べる整数の組の個数を表す整数 M と
# ハッシュ関数で用いる整数 A と B が与えられます。
N, M, A, B = map(int, input().split(' '))
# 2 行目に点の X 座標を表す長さ N の整数列が与えられます。
X = list(map(int, input().split(' ')))
# 3 行目に点の Y 座標を表す長さ N の整数列が与えられます。
Y = list(map(int, input().split(' ')))
# ハッシュテーブル初期化
ht = [[[] for b in range(B)] for a in range(A)]
# X と Y のタプルをハッシュテーブルの最後尾に追加
for i in range(N):
    hx = hashFunctionX(X[i])
    hy = hashFunctionY(Y[i])
    ht[hx][hy].append((X[i], Y[i]))
#print(ht)
# 3 + j 行目に調べる整数の組 p_j と q_j が与えられます。(1 ≦ j ≦ M)
for j in range(M):
    p, q = map(int, input().split(' '))
    if len(ht[p][q]) == 0:
        # データがない
        print(-1)
    else:
        print('{0} {1}'.format(ht[p][q][-1][0], ht[p][q][-1][1]))
