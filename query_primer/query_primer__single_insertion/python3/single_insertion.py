# Pythonにはdoctestというテストを行う機能が標準であるというので使ってみます
# このプログラムはpaizaラーニングの「クエリメニュー」内の「指定の位置への要素の追加」
# という問題を解きます
# https://paiza.jp/works/mondai/query_primer/query_primer__single_insertion

# 処理データクラス
class Data:
    # コンストラクタ
    def __init__(self):
        # クラスのインスタンス変数定義
        # 数列の要素数
        self.n = 0
        self.k = 0
        self.q = 0
        # 数列
        self.a = [] # 空の配列

# single_insertion は配列の指定位置に値を挿入する
# i a : 挿入される配列
#   k : 挿入位置
#   q : 挿入値
def single_insertion(a, k, q):
    # doctestでテスト 呼び出しと結果を交互に記述すればいいらしい
    # とりあえずpaizaの問題文にあった例を試す
    """
    >>> single_insertion([17,57,83], 1, 57)
    [17, 57, 57, 83]
    >>> single_insertion([38, 83, 46, 57, 15, 30, 51, 88, 96, 85], 6, 45)
    [38, 83, 46, 57, 15, 30, 45, 51, 88, 96, 85]
    """
    a.insert(k, q)
    return a

# inputData は処理対象データを読み込む
# o Data : 入力データを処理しやすい型で返す
def inputData():
    d = Data()
    # 1 行目では、配列 A の要素数 N と整数 K , Q が半角スペース区切りで与えられる
    line1 = input()
    items = line1.rstrip().split(' ')
    # 文字列配列を"List Comprehension"を使って数値配列に変換する
    try:
        numbers = [int(s) for s in items]
    except ValueError:
        # 数値変換例外
        print('[err] 1行目で数値変換失敗。', sys.exc_info(), file=sys.stderr)
        return

    if 3 != len(numbers):
        print('[err] 1行目の入力データが不正です。[', line1, ']', file=sys.stderr)
        return
    elif numbers[0] < 1 or 100000 < numbers[0]:
        print('[err] 要素数Nが範囲外です。[', line1, ']', file=sys.stderr)
        return
    elif numbers[1] < 1 or numbers[0] < numbers[1]:
        print('[err] 挿入位置Kが範囲外です。[', line1, ']', file=sys.stderr)
        return
    elif numbers[2] < 0 or 100 < numbers[2]:
        print('[err] 挿入値Qが範囲外です。[', line1, ']', file=sys.stderr)
        return
    else:
        d.n = numbers[0]
        d.k = numbers[1]
        d.q = numbers[2]

    # 続く N 行では、配列 A の要素が先頭から順に与えられる
    # List Comprehensionを使って配列に読み込む
    try:
        a = [int(input()) for i in range(d.n)]
    except ValueError:
        # 数値変換例外
        print('[err] 2行目以降で数値変換失敗。', sys.exc_info(), file=sys.stderr)
        return
    except:
        print('[err] 2行目以降でエラー。', sys.exc_info(), file=sys.stderr)
        return

    # ループ回数を指定して読み込んでいるので数値配列の数は正しい
    d.a = a

    # 入力データを返す
    return d

# computeData は処理を行う
def computeData(d):
    # Pythonでは配列の途中に追加するinsert()があるのでこれを使う
    d.a = single_insertion(d.a, d.k, d.q)
    # 処理結果を返す
    return d

# outputData は処理結果を出力する
def outputData(d):
    # 結果出力
    # List Comprehensionで一つずつ出力
    [print(str(i)) for i in d.a]

# メイン処理関数
def main():
    # 処理データを読み込む
    d = inputData()
    if d is None:
        # 入力データが読み込めなかったのでここで異常終了コードを返して終了
        sys.exit(1)
    # データを処理する
    d = computeData(d)
    if d is None:
        # 結果が返ってこないということはどうしようもないのでここで異常終了コードを返して終了
        sys.exit(1)
    # 結果を出力する
    outputData(d)

# エントリーポイント
# コマンドラインからスクリプトとして実行された場合に処理する
if __name__ == '__main__':
    # 以下の2行でテストを実行する
    # デフォルトではテスト結果が正常の場合、なにも出力されいなのでpaizaのジャッジも通過できる
    import doctest
    doctest.testmod()
    # これが本当の処理
    main()
