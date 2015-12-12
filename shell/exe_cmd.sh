#!/bin/bash

set -ue

# #wikipediaのダンプデータを獲得
# wget -O data/jawiki-20151202-pages-articles.xml.bz2 https://dumps.wikimedia.org/jawiki/20151202/jawiki-20151202-pages-articles.xml.bz2

# #XMLタグの削除
# wp2txt -i data/jawiki-20151202-pages-articles.xml.bz2 -o wikipedia_text/

# #文字のカウント
# for f in wikipedia_text/*; do
#   cat $f | nkf -Z | tr -d '[a-z]' | tr -d '[A-Z]' | tr -d '[0-9]' | grep -o . | LC_ALL=C sort | uniq -c > wikipedia_chars/`basename $f`
# done

# # #カウントの統合
# #/[ぁ-ん]|[ァ-ヴ]|[一-龥]/ これはひらがな、かたかな、漢字の正規表現。今回は使わない
# #/[亜-腕]|[弌-熙]/ これはJIS第一・第二水準の正規表現
# cat wikipedia_chars/* | awk '$2 ~ /[亜-腕]|[弌-熙]/ {print $0}' | awk '{ a[$2] += $1 } END{ for(k in a){print a[k]"\t"k} }' | LC_ALL=C sort -nr > jis1_jis2_kanji_freq.txt

# #出現割合の計算
# char_sum=`cat jis1_jis2_kanji_freq.txt | awk '{sum += $1}; END{print sum}'`
# cat jis1_jis2_kanji_freq.txt | awk -v char_sum=$char_sum '{rate = 1.0 * $1 / char_sum; printf("%d\t%.10f\t%s\n", $1, rate, $2)}' > jis1_jis2_kanji_ratio_freq.txt

#pythonプログラムの実行
for table_file in stroke_tables/*.txt; do
  cat jis1_jis2_kanji_ratio_freq.txt | python3 src/survey_kanchoku_coverage.py $table_file | awk '$4 == "T" {sum += $2} {print $0"\t"sum}' | tee "result/"`basename $table_file` | awk '{print $6}' > "cumulative_density_"`basename $table_file`
done

cat -n cumulative_density_t_code.txt cumulative_density_tut_code.txt cumulative_density_g_code.txt cumulative_density_phoenix.txt > cumulative_density.txt




exit
