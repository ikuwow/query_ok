---

# title: usb-hdd-format-ext4
title: USB外付けHDDをext4にフォーマットする手順
date: 2021-09-04 12:10 JST
tags: Qiita, CentOS, ShellScript
thumbnail:

---

この記事は、2013年08月27日にQiitaで投稿した以下の記事を転記したものです。

> USB外付けHDDをext4にフォーマットする手順  
> https://qiita.com/ikuwow/items/c5832fd823e869825c80

---

## 現在の状況を確認し、パーティションを削除

dfコマンドで、現在マウントされているディスクの状態を見る。-hオプションは、通常KB単位で表示される容量をMBやGBで表示してくれるオプション（human readable）。

```bash:
# df -h
Filesystem            Size  Used Avail Use% マウント位置
/dev/sda3             2.0G  462M  1.4G  25% /
tmpfs                 939M  8.0K  939M   1% /dev/shm
/dev/sda1             291M   74M  202M  27% /boot
/dev/sda6              49G  2.5G   44G   6% /home
/dev/sda9             291M   14M  262M   6% /tmp
/dev/sda7             9.7G  2.4G  6.8G  26% /usr
/dev/sda8             2.0G   39M  1.8G   3% /usr/local
/dev/sda5              97G  3.4G   88G   4% /var
```

sdaがこのCent OSの内蔵ディスクについた名前で、あとの数字がパーティション番号を表す。今のサーバのスペックをNECのサイトで確認したらHDDはIDEだけど、それならhdaじゃないのかなあ？
わからないがスルーする。

次にUSB外付けHDDを接続し、どの名前で認識されているかを確認。`/var/log/dmesg`を見るとよいらしい。ここではsdbだとあたりをつけて先に進む。

ここからfdiskコマンドを駆使する。`/dev/sdb`を操作。

```bash:
# fdisk /dev/sdb

警告: DOS互換モードは廃止予定です。このモード (コマンド 'c') を止めることを
      強く推奨します。 and change display units to
         sectors (command 'u').

コマンド (m でヘルプ):
```

警告は無視で良いらしい。fdiskのコマンドプロンプトに入る。

`p`で状態を表示、`d`とパーティション番号指定でパーティションを削除、`w`でこれらの操作を書き込み。

```bash:
コマンド (m でヘルプ): p

ディスク /dev/sdb: 500.1 GB, 500107862016 バイト
ヘッド 255, セクタ 63, シリンダ 60801
Units = シリンダ数 of 16065 * 512 = 8225280 バイト
セクタサイズ (論理 / 物理): 512 バイト / 512 バイト
I/O size (minimum/optimal): 512 bytes / 512 bytes
ディスク識別子: 0xe6dbb923

デバイス ブート      始点        終点     ブロック   Id  システム
/dev/sdb1   *           1          13      102400    7  HPFS/NTFS
パーティション 1 は、シリンダ境界で終わっていません。
/dev/sdb2              13       59448   477408256    7  HPFS/NTFS
/dev/sdb3           59448       60802    10873856    7  HPFS/NTFS

コマンド (m でヘルプ): d
パーティション番号 (1-4): 1

コマンド (m でヘルプ): d
パーティション番号 (1-4): 2

コマンド (m でヘルプ): d
選択した領域 3

コマンド (m でヘルプ): p

ディスク /dev/sdb: 500.1 GB, 500107862016 バイト
ヘッド 255, セクタ 63, シリンダ 60801
Units = シリンダ数 of 16065 * 512 = 8225280 バイト
セクタサイズ (論理 / 物理): 512 バイト / 512 バイト
I/O size (minimum/optimal): 512 bytes / 512 bytes
ディスク識別子: 0xe6dbb923

デバイス ブート      始点        終点     ブロック   Id  システム

コマンド (m でヘルプ): d
領域が定義されていません

コマンド (m でヘルプ): w
パーティションテーブルは変更されました！

ioctl() を呼び出してパーティションテーブルを再読込みします。
ディスクを同期しています。
```

## 新たにパーティションを作成し、ext4でフォーマットする

もう一度`fdisk /dev/sdb`で、`n`コマンドで新たなパーティションを作成。パーティション番号、最初シリンダ（笑）、Lastシリンダを入力。まあ初期値でよい。

```bash:
コマンド (m でヘルプ): p

ディスク /dev/sdb: 500.1 GB, 500107862016 バイト
ヘッド 255, セクタ 63, シリンダ 60801
Units = シリンダ数 of 16065 * 512 = 8225280 バイト
セクタサイズ (論理 / 物理): 512 バイト / 512 バイト
I/O size (minimum/optimal): 512 bytes / 512 bytes
ディスク識別子: 0xe6dbb923

デバイス ブート      始点        終点     ブロック   Id  システム

コマンド (m でヘルプ): n
コマンドアクション
   e   拡張
   p   基本パーティション (1-4)
p
パーティション番号 (1-4): 1
最初 シリンダ (1-60801, 初期値 1): 1
Last シリンダ, +シリンダ数 or +size{K,M,G} (1-60801, 初期値 60801):
初期値 60801 を使います

コマンド (m でヘルプ): p

ディスク /dev/sdb: 500.1 GB, 500107862016 バイト
ヘッド 255, セクタ 63, シリンダ 60801
Units = シリンダ数 of 16065 * 512 = 8225280 バイト
セクタサイズ (論理 / 物理): 512 バイト / 512 バイト
I/O size (minimum/optimal): 512 bytes / 512 bytes
ディスク識別子: 0xe6dbb923

デバイス ブート      始点        終点     ブロック   Id  システム
/dev/sdb1               1       60801   488384001   83  Linux

コマンド (m でヘルプ): w
パーティションテーブルは変更されました！

ioctl() を呼び出してパーティションテーブルを再読込みします。
ディスクを同期しています。
```

mkfs.ext4というコマンドで、sdb1をext4にフォーマット。これは少し時間がかかる。

```bash:
# mkfs.ext4 /dev/sdb1
mke2fs 1.41.12 (17-May-2010)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
30531584 inodes, 122096000 blocks
6104800 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=4294967296
3727 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks:
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
	4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
	102400000

Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 30 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
```

## マウントする
`/mnt/backup_exHDD`ディレクトリを作成して、そこにマウント。ディレクトリ名はもちろん任意。

```bash:
# mkdir /mnt/backup_externalHDD
# mount /dev/sdb1 /mnt/backup_exHDD
```

無事マウントされていれば、dfで様子が見られるはず。

```bash:
# df -h
Filesystem            Size  Used Avail Use% マウント位置
/dev/sda3             2.0G  462M  1.4G  25% /
tmpfs                 939M  8.0K  939M   1% /dev/shm
/dev/sda1             291M   74M  202M  27% /boot
/dev/sda6              49G  2.5G   44G   6% /home
/dev/sda9             291M   14M  262M   6% /tmp
/dev/sda7             9.7G  2.4G  6.8G  26% /usr
/dev/sda8             2.0G   39M  1.8G   3% /usr/local
/dev/sda5              97G  3.4G   88G   4% /var
/dev/sdb1             459G  198M  435G   1% /mnt/backup_exHDD
```
