#!/bin/bash

wget https://github.com/maintell/webBenchmark/releases/download/0.5/webBenchmark_linux_x64
chmod +x webBenchmark_linux_x64
nohup ./webBenchmark_linux_x64 -c 32 -s https://archlinux.cloudflaremirrors.com/archlinux/iso/latest/archlinux-x86_64.iso &
