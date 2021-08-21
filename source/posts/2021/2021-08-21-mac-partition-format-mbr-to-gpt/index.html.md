---

# title: mac-partition-format-mbr-to-gpt
title: Macでディスクのパーティション形式をMBRからGPTに変える
date: 2021-08-21 12:08 JST
tags: Qiita, Mac
thumbnail:

---

この記事は、2017年09月30日にQiitaで投稿した以下の記事を転記したものです。

> Macでディスクのパーティション形式をMBRからGPTに変える  
> https://qiita.com/ikuwow/items/4bc3923d8f7f8bfb2da2

---

## いきさつ

Macはディスクを中のデータを消さずに暗号化できるようで、
ディスクのアイコンを右クリックするとでてくる「暗号化...」かDiskUtilityから暗号化された状態に変換できる。

先日外付けHDDを入手したのでそれを暗号化ファイルシステムに変えようとしたが、右クリックメニューにもないし、DiskUtilityのフォーマット欄にも出てこない。

![ 2017-09-29 at 20.05.39.png](https://qiita-image-store.s3.amazonaws.com/0/28666/9d688f74-f028-a5b9-30b0-5b0d59c2fd27.png)

ついでにパーティションも切れない。↓のようにグレーアウトする。

![ 2017-09-29 at 19.51.49.png](https://qiita-image-store.s3.amazonaws.com/0/28666/e09f9256-1369-852b-59de-f72b1df54132.png)

どうやらパーティション方式がMBRになっていたようだ。
これをGPTに変えると問題なくできるらしいのでやってみた。

## MBR,GPTとは？

それぞれパーティション方式？の一種。

MBR(Master Boot Record)は古い形式で、2TBまでしか容量を認識できず、パーティション数も4つまで。

GPT(GUID Partition Table)はMacにおいて標準で使われている？形式。
起動ディスクにするにもGPTである必要があるみたい。
https://support.apple.com/ja-jp/HT202796

特に違いを意識せずにMacを使いたいならGPTにしておくべきと感じた。

## 結論

`diskutil eraseDisk`を使う。
当たり前ですが**ディスク上のすべてのデータが消去される**のでディスクを間違わないように注意。

```
$ diskutil eraseDisk JHFS+ SecretDisk GPT /dev/disk3
Started erase on disk3
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk3s2 as Mac OS Extended (Journaled) with name SecretDisk
Initialized /dev/rdisk3s2 as a 931 GB case-insensitive HFS Plus volume with a 81920k journal
Mounting disk
Finished erase on disk3
```

`JHFS+`が`Mac OS Extended Journaled`（日本語だと「MacOS拡張（ジャーナリング）」？）の意。
`SecretDisk`がフォーマット後のディスクの名前。
GPTが今回のフォーマット。
`/dev/disk3`の部分はマウントポイントでもよいらしい。

オプションの詳細はマニュアルを参照

```
$ diskutil eraseDisk
Usage:  diskutil eraseDisk format name [APM[Format]|MBR[Format]|GPT[Format]]
        MountPoint|DiskIdentifier|DeviceNode
Completely erase an existing whole disk.  All volumes on this disk will be
destroyed.  Ownership of the affected disk is required.
Format is the specific file system name you want to erase it as (HFS+, etc.).
Name is the (new) volume name (subject to file system naming restrictions),
or can be specified as %noformat% to skip initialization (newfs).
You cannot erase the boot disk.
Example: diskutil eraseDisk JHFS+ UntitledUFS disk3
```

これで以下のように暗号化に対応する。

![ 2017-09-29 at 20.12.24.png](https://qiita-image-store.s3.amazonaws.com/0/28666/3bf57e4a-f769-12b1-fed0-46ddcfd17bcd.png)


## 右往左往していたログ

マウントポイント指定でうまく行かず、間違ったDeviceNodeIDを指定していて詰まっていた。

---

```
$ diskutil info "Secret Disk" | grep Device\ Node
   Device Node:              /dev/disk3s1
```

今回はSecret Diskを消したいので`/dev/disk3s1`。

Mac OS Extended Journaled (JHFS+) 

```
diskutil eraseDisk JHFS+ SecretDisk2 /dev/disk3s1 GPT
```

あれ

```
$ diskutil eraseDisk JHFS+ SecretDisk2 /dev/disk3s1 GPT
Unknown partition scheme: /dev/disk3s1
IkuosMacmini:imgs2pdf degawaikuo$ diskutil eraseDisk JHFS+ SecretDisk2 /dev/disk3s1
A volume was specified instead of a whole disk: /dev/disk3s1
Specify a whole disk, or instead use diskutil eraseVolume to erase a volume on a specific partition
```

こうか

```
$ diskutil eraseDisk JHFS+ SecretDisk2 GPT /dev/disk3s1
A volume was specified instead of a whole disk: /dev/disk3s1
Specify a whole disk, or instead use diskutil eraseVolume to erase a volume on a specific partition
```
うーん

他のもいじって試していたら

```
$ diskutil partitionDisk /Volumes/SecretDisk2 2 GPT JHFS+ JHFS+
/Volumes/SecretDisk2 does not appear to be a whole disk
```

指定が間違っているだけっぽいな。`/dev/disk3`か。

```
diskutil eraseDisk JHFS+ SecretDisk2 GPT /dev/disk3
```

いいかんじ。

## 参考

http://osxdaily.com/2016/08/30/erase-disk-command-line-mac/

