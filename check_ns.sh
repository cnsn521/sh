#!/bin/bash

# 要查询的域名列表文件
input_file="domains.txt"
# 没有NS记录的域名记录文件
output_file="no_ns_domains.txt"

# 清空输出文件
> $output_file

# 读取域名列表文件并逐行处理
while IFS= read -r domain; do
    # 使用nslookup查询NS记录
    nslookup -type=ns $domain 119.29.29.29 | grep pp.ua | grep -v find > /dev/null
    if [ $? -ne 0 ]; then
        # 如果没有找到NS记录，将域名记录下来
        echo $domain >> $output_file
    fi
done < $input_file

echo "查询完成。没有NS记录的域名已记录在 $output_file 文件中。"
