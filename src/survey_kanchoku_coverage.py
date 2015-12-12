#coding:utf-8

import sys

#入力方式のテーブルを読み込み、漢字をキーとしてストロークを値とする辞書を返す
def get_table(table_path_str):
    d = {}

    with open(table_path_str, 'r') as f:
        for line in f:
            line = line.rstrip()
            lst = line.split()
            d[lst[1]] = lst[0] #漢字->ストローク

    return d


# def get_tcode_table():
#     return get_table('stroke_tables/t_code.txt')

# def get_tut_table():
#     return get_table('stroke_tables/tut_code.txt')

# def get_tut_2_table():
#     d = {}

#     with open('stroke_tables/tut_code.txt', 'r') as f:
#         for line in f:
#             line = line.rstrip()
#             lst = line.split()
#             if len(lst[0]) == 2:
#                 d[lst[1]] = lst[0] #漢字->ストローク

#     return d

# def get_phoenix_table():
#     return get_table('stroke_tables/phoenix.txt')

# def get_gcode_table():
#     return get_table('stroke_tables/g_code.txt')

def main():
    argc = len(sys.argv)
    if argc != 2:
        raise Exception('Argument Error')

    table_path = sys.argv[1]
    stroke_table = get_table(table_path)

    for line in sys.stdin:
        line = line.rstrip()
        lst = line.split()
        if lst[2] in stroke_table:
            print("%s\tT\t%d" % (line, len(stroke_table[lst[2]])) )
        else:
            print("%s\tF\t0" % line )

    return

if __name__ == '__main__':
    main()
