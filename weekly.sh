#!/usr/bin/env bash

set -eu -o pipefail

week_start=$(date -d 'last friday - 6 days' +%Y%m%d)
week_end=$(date -d 'last friday' +%Y%m%d)

article_title="ツイートまとめ $week_start~$week_end"
article_title_english="Weekly tweet compilation $week_start"

output=$(bundle exec middleman article "$article_title_english" -t "Weekly" | tee /dev/tty)
article_file=$(echo "$output" | awk '{print $NF}')

sed -i "s/$article_title_english/$article_title/" "$article_file"

open -a Safari "https://twilog.org/ikuwow/date-$(date -d "$week_start" +%y%m%d)/asc"
vimr "$article_file"
