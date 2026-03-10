# Linux 基本コマンドメモ

Linux を勉強し始めたときに練習した基本コマンドのメモです。

まだ勉強中なので、少しずつ追加していく予定です。

---
# 📅 2026-03-08
---
## IPアドレス確認

```
ip addr
```

または

```
ip a
```

ネットワークインターフェースと IP アドレスを確認できます。

---

## ディスク使用状況

```
df -h
```

ディスク容量の使用状況を確認できます。

---

## ディスク一覧

```
lsblk
```

接続されているディスクやパーティションを表示します。

---

## Linux カーネル確認

```
uname -r
```

現在使用している Linux カーネルのバージョンを確認できます。

---

## OS 情報確認

```
cat /etc/os-release
```

Linux ディストリビューションの名前やバージョンを表示します。

---

## 現在のユーザー

```
whoami
```

今ログインしているユーザーを確認します。

---

## 現在のディレクトリ

```
pwd
```

今作業しているディレクトリを表示します。

---
# 📅 2026-03-09
---
## ディレクトリ作成

```
mkdir -p /tmp/practice/test1
```

存在しないディレクトリもまとめて作成できます。

---

## ファイル作成

```
touch /tmp/practice/file{1..5}.txt
```

file1〜file5 までのファイルを作成します。

---

## ファイルコピー

```
cp /tmp/practice/file1.txt /tmp/practice/test1/
```

ファイルを別のディレクトリへコピーします。

---

## ファイル名変更

```
mv /tmp/practice/file2.txt /tmp/practice/file2_renamed.txt
```

ファイル名を変更します。

---

## ファイル削除

```
rm /tmp/practice/file3.txt
```

指定したファイルを削除します。

---

## ファイル一覧表示

```
ls -la /tmp/practice/
```

ディレクトリ内のファイル一覧を表示します。

---

## ファイル検索

```
find /etc -name "*.conf" -type f | head -10
```

/etc ディレクトリから .conf ファイルを検索し  
最初の10件を表示します。

---
# 📅 2026-03-10
---

## /etc/passwd 確認
```
cat /etc/passwd
```

/etc/passwdの内容を確認します。

---

## システムログ表示
```
less /var/log/messages
```

システムのログを1ページずつ表示します。

---

## 先頭20行表示
```
head -20 /etc/passwd
```

/etc/passwdの最初の20行を表示します。

---

## 末尾20行表示
```
tail -20 /etc/passwd
```

/etc/passwdの最後の20行を表示します。

---

## キーワード検索
```
grep "root" /etc/passwd
```

/etc/passwdファイルでrootを含む行を検索します。

---

## ログ再帰検索
```
grep -r "error" /var/log/ 2>/dev/null
```

システムログでエラーメッセージを再帰的に検索します。権限エラーは表示しません。

---

## 行数カウント
```
wc -l /etc/passwd
```

/etc/passwdの行数を数えます。

---

## ユーザー名抽出
```
cut -d: -f1 /etc/passwd
```

/etc/passwdからユーザー名のみ抽出して表示します。

---

## 並び替えと先頭表示
```
sort /etc/passwd | head -10
```

/etc/passwdをアルファベット順に並べ替え、先頭10行を表示します。

---
