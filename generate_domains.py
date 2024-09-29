import itertools

# 生成所有长度为1到3的包含英文字母的域名组合
letters = 'abcdefghijklmnopqrstuvwxyz'
domains = [''.join(p) + '.pp.ua' for i in range(3, 4) for p in itertools.product(letters, repeat=i)]

# 将生成的域名保存到domains.txt文件
with open('domains.txt', 'w') as f:
    for domain in domains:
        f.write(domain + '\n')

print("domains.txt 文件已生成，包含所有可能的域名。")
