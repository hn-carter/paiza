# これはpaizaラーニングの「効率的なソートアルゴリズムメニュー」から「マージソート」
# https://paiza.jp/works/mondai/sort_efficient/sort_efficient__merge
# にPython3でチャレンジした試行錯誤コードです。
# Python3初心者が学習用に作ったコードなので本来は不要な処理があります。
import sys
import traceback

# 例外クラスを自作してみた
class SortError(Exception):
    # このソートプログラムで発生する例外の基底クラス
    # pass : なにもしない
    pass

# 読み込み失敗例外
class InputSortError(SortError):
    # コンストラクタ
    def __init__(self, message):
        self.message = message

# 入力データが範囲外例外
class OutOfRangeSortError(SortError):
    # コンストラクタ
    def __init__(self, message):
        self.message = message

# 処理データクラス
class Data:
    # Pythonはここで変数定義を行うとクラス変数になってしまう

    # コンストラクタ
    def __init__(self):
        # クラスのインスタンス変数はコンストラクタで定義(初期化)する
        # 数列の要素数
        self.n = 0
        # 数列
        self.a = [] # 空の配列
        # アルゴリズムが正しく実装されていることを確認するために導入するカウンタ変数、
        # ソート処理には関係がないことに注意
        self.count = 0

    # 部分データ列 A[left] ~ A[mid-1], A[mid] ~ A[right-1] はそれぞれ整列済み
    # 2つの部分データ列をマージし、A[left] ~ A[right-1] を整列済みにする
    def merge(self, left, mid, right):
        # 2つの部分データ列のサイズ
        nl = mid - left
        nr = right - mid

        # 部分データ列をコピー スライスでコピー
        L = self.a[left:left + nl]
        R = self.a[mid:mid + nr]

        # 番兵を末尾に追加
        # sys.maxsize : Py_ssize_t型が取る最大数 64ビット環境では 2**63-1
        L.append(sys.maxsize)
        R.append(sys.maxsize)

        # 2つの部分データ列をマージして A[left] ~ A[right-1] に書き込む
        lindex = 0
        rindex = 0

        for i in range(left, right):
            if L[lindex] < R[rindex]:
                self.a[i] = L[lindex]
                lindex += 1
            else:
                self.a[i] = R[rindex]
                rindex += 1
                self.count += 1

    # A[left] ~ A[right-1] をマージソートする
    # 配列 A をマージソートするには merge_sort(A, 0, n) を呼び出す
    def merge_sort(self, left, right):
        if left + 1 < right:
            # // は整数の商を求める
            mid = (left + right) // 2
            self.merge_sort(left, mid)
            self.merge_sort(mid, right)
            self.merge(left, mid, right)

# inputData は処理対象データを読み込む
# o Data : 入力データを処理しやすい型で返す
def inputData():
    d = Data()
    # 1行目に、数列の要素数 n が与えられる
    # input 改行までの1行を読み込む
    # int 文字列から整数を返す
    try:
        number = int(input())
    except ValueError:
        # 引数が不適切な型
        # intで数値変換に失敗したらここに来るはず
        # 'from None'で既存の例外を無視する
        raise InputSortError('1行目が数値ではありません。') from None
    except:
        # ここは全ての例外を処理する
        print('[err] 1行目で不明なエラー。', sys.exc_info(), file=sys.stderr)
        # 改めて専用の例外を投げるときは'from None'を付けて既存の例外を無視する
        raise InputSortError('1行目で不明なエラー') from None

    # 数値範囲チェック
    if number < 1 or 500000 < number:
        mmsg = '数列の要素数が範囲外です。 [' + str(number) + ']'
        raise OutOfRangeSortError(mmsg)
    # 入力データ格納
    d.n = number

    # 2行目に、数列の要素 A_1, A_2, ... , A_n が半角スペース区切りで与えられる
    # rstrip 末尾の空白を除去する
    # split 区切り文字で区切った配列を返す
    items = input().rstrip().split(' ')
    # 文字列配列を"List Comprehension"を使って数値配列に変換する
    try:
        numbers = [int(s) for s in items]
    except ValueError:
        # 引数が不適切な型
        # intで数値変換に失敗したらここに来るはず
        raise InputSortError('2行目が数値ではありません。' + ','.join(items)) from None
    except:
        # ここは全ての例外を処理する
        print('[err] 2行目で不明なエラー。', sys.exc_info(), file=sys.stderr)
        raise InputSortError('2行目で不明なエラー' + ','.join(items)) from None

    # 数値範囲チェック
    for i in numbers:
        if i < -1000000000 or 1000000000 < i:
            raise OutOfRangeSortError('数列が範囲外です。 [' + str(i) + ']')
    if d.n != len(numbers):
        raise InputSortError('与えられた要素の数が異なります。n=' + str(d.n) + ' a=' + str(len(numbers)))

    # 入力データ格納
    d.a = numbers

    # 入力データを返す
    return d

# computeData は処理を行う
def computeData(d):
    # マージソートを行う
    d.merge_sort(0, d.n)
    # 処理結果を返す
    return d

def outputData(d):
    # 結果出力
    # join : 配列を文字で一つに連結した文字列を返す
    # joinには文字列配列を渡すため"List Comprehension"で文字列変換する
    line = ' '.join([str(s) for s in d.a])
    print(line)
    print(d.count)

# メイン処理関数
def main():
    # 処理データを読み込む
    d = inputData()
    if d is None:
        # なんでも例外で処理するのは手抜きでしかない気がする
        # Python3での例外の使い道が良く分からないけど練習用
        # 例外を発生させる
        raise SortError("入力データが取り込めなかった例外。")

    # データを処理する
    computeData(d)
    # 結果を出力する
    outputData(d)

# エントリーポイント
try:
    main()
except:
    # ここで全ての例外を処理する
    print('[err] エラー。: ', sys.exc_info(), file=sys.stderr)
    # トレースバックを表示する
    traceback.print_exc()
    # 異常終了コードを返す
    sys.exit(1)
