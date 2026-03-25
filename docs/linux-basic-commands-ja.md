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
# 📅 2026-03-11
---

## 権限一覧表示
```
ls -la /tmp/practice/
```

ディレクトリ内の全ファイルの権限を詳細表示します。

---

## 権限変更（数字モード）755
```
chmod 755 /tmp/practice/file1.txt
```

オーナーに読み・書き・実行権限、グループと他のユーザーに読み・実行権限を設定します。

---

## 権限変更（数字モード）644
```
chmod 644 /tmp/practice/file2_renamed.txt
```

オーナーに読み・書き権限、グループと他のユーザーに読み取り専用権限を設定します。

---

## 権限変更（数字モード）600
```
chmod 600 /tmp/practice/file4.txt
```

オーナーに読み・書き権限のみ設定し、グループと他のユーザーには権限を与えません。

---

## 権限変更（記号モード）u+x
```
chmod u+x /tmp/practice/file1.txt
```

オーナーに実行権限を追加します。

---

## 権限変更（記号モード）g-w
```
chmod g-w /tmp/practice/file2_renamed.txt
```

グループから書き込み権限を削除します。

---

## 権限変更（記号モード）o=r
```
chmod o=r /tmp/practice/file4.txt
```

他のユーザーの権限を読み取り専用に設定します。

---

## オーナー変更（rootへ）
```
sudo chown root:root /tmp/practice/file1.txt
```

ファイルのオーナーとグループを両方rootに変更します。

---

## オーナー変更（現在のユーザーへ）
```
sudo chown $USER:$USER /tmp/practice/file1.txt
```

ファイルのオーナーとグループを現在のログインユーザーに変更します。

---

## umask確認
```
umask
```

新規作成ファイルのデフォルト権限マスクを確認します。

---

## umask設定
```
umask 022
```

以降に作成するファイルのデフォルト権限マスクを022に設定します。
グループと他のユーザーへの書き込み権限を除外します。

---

## ファイル作成（umask確認用）
```
touch /tmp/umask_test
```

umaskの効果を確認するためのテストファイルを作成します。

---

## umask適用結果確認
```
ls -la /tmp/umask_test
```

作成したファイルにumask 022が正しく適用されているか確認します。

---
# 📅 2026-03-12
---

## ハードリンク作成
```
ln /tmp/practice/file1.txt /tmp/practice/hardlink1
```

`/tmp/practice/file1.txt` のハードリンクを `hardlink1` という名前で作成します。

---

## iノード番号確認
```
ls -lai /tmp/practice/
```

ディレクトリ内の詳細情報を表示します。`-i` オプションでiノード番号を確認できます。ハードリンクは元ファイルと同じiノード番号を持ちます。

---

## シンボリックリンク作成
```
ln -s /tmp/practice/file1.txt /tmp/practice/symlink1
```

`/tmp/practice/file1.txt` へのシンボリックリンクを `symlink1` という名前で作成します。

---

## シンボリックリンク確認
```
ls -la /tmp/practice/
```

先頭が `l` で、矢印 `->` があるエントリがシンボリックリンクです。

---

## ファイルコピー
```
cp /tmp/practice/file1.txt /tmp/practice/file1_backup.txt
```

`file1.txt` を `file1_backup.txt` という名前でコピーします。

---

## ハードリンク作成（削除テスト用）
```
ln /tmp/practice/file1_backup.txt /tmp/practice/hardlink2
```

`file1_backup.txt` のハードリンクを `hardlink2` という名前で作成します。

---

## シンボリックリンク作成（削除テスト用）
```
ln -s /tmp/practice/file1_backup.txt /tmp/practice/symlink2
```

`file1_backup.txt` へのシンボリックリンクを `symlink2` という名前で作成します。

---

## 元ファイル削除
```
rm /tmp/practice/file1_backup.txt
```

`file1_backup.txt` を削除してハードリンクとシンボリックリンクの挙動の違いを確認します。

---

## ハードリンク読み込み確認
```
cat /tmp/practice/hardlink2
```

元ファイルを削除してもハードリンクはデータを保持しているため、読み込みが可能です。

---

## シンボリックリンク読み込み確認
```
cat /tmp/practice/symlink2
```

元ファイルを削除するとシンボリックリンクは無効になるため、読み込みができません（リンク切れ）。

---

## SUID設定
```
chmod u+s /tmp/practice/file1.txt
```

SUIDを設定します。実行時にオーナーの権限で動作します。権限表示に `s` が現れます。

---

## SGID設定
```
chmod g+s /tmp/practice/test1/
```

SGIDを設定します。ディレクトリ内に作成されたファイルはグループを継承します。権限表示に `s` が現れます。

---

## Sticky bit設定
```
chmod +t /tmp/practice/
```

Sticky bitを設定します。ディレクトリ内のファイルはオーナーのみ削除できます。権限表示に `t` が現れます。

---

## 権限確認
```
ls -la /tmp/practice/
```

SUID・SGID・Sticky bitが正しく設定されているか確認します。

---

## ACL確認
```
getfacl /tmp/practice/file1.txt
```

ファイルのアクセス制御リスト（ACL）を表示します。

---

## ACL設定
```
sudo setfacl -m u:nobody:rw /tmp/practice/file1.txt
```

`nobody` ユーザーに読み取りと書き込み権限を付与します。

---

## ACL設定後の確認
```
getfacl /tmp/practice/file1.txt
```

`nobody` ユーザーへのACLが正しく設定されているか確認します。

---
# 📅 2026-03-16
---

## `sudo useradd testuser1`
testuser1 を作成します。

---

## `sudo useradd -m -s /bin/bash -u 1500 testuser2`
testuser2 を作成します。同時にホームディレクトリを作成し（`-m`）、使用するシェルを bash に指定し（`-s`）、ユーザーIDを1500に指定します（`-u`）。

---

## `sudo passwd testuser1`
testuser1 にパスワードを設定します。

---

## `sudo usermod -aG wheel testuser1`
testuser1 を wheel グループに追加します。wheel グループのメンバーは `sudo` コマンドを使用して管理者権限で操作できます。

---

## `sudo usermod -L testuser1`
testuser1 のアカウントをロックします。（`-L` = Lock）

---

## `sudo usermod -U testuser1`
testuser1 のアカウントをアンロックします。（`-U` = Unlock）

---

## `id testuser1`
testuser1 のUID・GID・所属グループを確認します。

---

## `groups testuser1`
testuser1 が所属しているグループ一覧を表示します。

---

## `cat /etc/passwd | grep testuser`
/etc/passwd から testuser を含む行を検索します。

---

## `sudo groupadd testgroup`
testgroup グループを作成します。

---

## `sudo usermod -aG testgroup testuser1`
testuser1 を testgroup グループに追加します。

---

## `grep testgroup /etc/group`
/etc/group から testgroup のメンバーを確認します。

---

## `sudo userdel testuser1`
testuser1 を削除します。

---

## `sudo userdel -r testuser2`
testuser2 を削除し、ホームディレクトリを含む関連ファイルをすべて削除します。（`-r` = remove home directory）

---
# 📅 2026-03-17
---

## `ps aux`
システム上で実行中のすべてのプロセスを詳細に一覧表示します。

---

## `ps aux | grep sshd`
実行中のプロセスの中から sshd に関連するプロセスを検索します。

---

## `top`
システムのリソース使用状況をリアルタイムで表示します。CPU・メモリの使用率や実行中のプロセスを確認できます。

---

## `sleep 100 &`
`sleep 100` をバックグラウンドで実行します。

---

## `sleep 200 &`
`sleep 200` をバックグラウンドで実行します。

---

## `jobs`
現在バックグラウンドで実行中のジョブを一覧表示します。

---

## `fg %1`
バックグラウンドのジョブ1番をフォアグラウンドに戻します。

---

## `bg %1`
一時停止中のジョブ1番をバックグラウンドで再開します。

---

## `kill -l`
使用可能なシグナルの一覧を表示します。

---

## シグナルの種類
```
1  = SIGHUP  （設定を再読み込みする。サービスを停止せずに適用できる）
9  = SIGKILL （強制終了。無視できないシグナル）
15 = SIGTERM （正常終了。killコマンドのデフォルト値）

実務の原則：まず -15 を試し、応答しない場合のみ -9 を使用する
```

---

## `kill -15 $(pgrep sleep)`
sleep プロセスを正常終了させます。`pgrep sleep` で sleep のPIDを取得し、シグナル15を送ります。

---

## `kill -9 [PID]`
指定したPIDのプロセスを強制終了します。

---

## `nice -n 10 sleep 300 &`
優先度（niceness値）を10に設定して `sleep 300` をバックグラウンドで実行します。値が高いほど優先度が低くなります。

---

## `renice -n 5 [PID]`
実行中のプロセスの優先度をniceness値5に変更します。

---
# 📅 2026-03-18
---

## `dnf list installed | head -20`
インストール済みパッケージの一覧から先頭20件を表示します。

---

## `dnf search httpd`
利用可能なパッケージから httpd を検索します。

---

## `dnf info httpd`
httpd パッケージの詳細情報（バージョン・説明・サイズ等）を表示します。

---

## `sudo dnf install httpd -y`
httpd をインストールします。確認プロンプトを省略します（`-y`）。

---

## `sudo dnf remove httpd -y`
httpd をアンインストールします。確認プロンプトを省略します（`-y`）。

---

## `sudo dnf update -y`
インストール済みの全パッケージを最新バージョンに更新します。

---

## `dnf history`
DNF コマンドによるパッケージ操作の履歴を表示します。

---

## `rpm -qa | head -20`
インストール済みの全 RPM パッケージ一覧から先頭20件を表示します。

---

## `rpm -qi bash`
bash パッケージの詳細情報（バージョン・説明・インストール日等）を表示します。

---

## `rpm -ql bash | head -10`
bash パッケージに含まれるファイルのパス一覧から先頭10件を表示します。

---

## `rpm -qf /bin/bash`
`/bin/bash` がどの RPM パッケージによってインストールされたかを確認します。

---
# 📅 2026-03-19
---

## `crontab -e`
現在のユーザーの定期実行タスク（crontab）を編集します。

---

## `crontab -l`
現在設定されている定期実行タスクの一覧を表示します。

---

## `crontab -r`
現在のユーザーのcrontabを削除します。

---

## cron書式
```
分 時 日 月 週 コマンド
* * * * * echo "$(date)" >> /tmp/crontest.txt
→ 毎分、現在時刻を/tmp/crontest.txtに追記する
```

---

## `sleep 120`
120秒待機します。cronが実行されるまで待つための確認用コマンドです。

---

## `cat /tmp/crontest.txt`
cronが正しく実行されたか、/tmp/crontest.txtの内容を確認します。

---

## `ls /etc/cron.d/`
システム全体の追加cronジョブが格納されているディレクトリの内容を表示します。

---

## `ls /etc/cron.daily/`
毎日自動実行されるスクリプトが格納されているディレクトリの内容を表示します。

---

## `ls /etc/cron.hourly/`
毎時自動実行されるスクリプトが格納されているディレクトリの内容を表示します。

---
# 📅 2026-03-20
---

## `systemctl list-units --type=service | head -20`
現在起動中のサービス一覧を先頭20件表示します。

---

## `systemctl status sshd`
sshdサービスの現在の状態（起動中・停止中・エラー等）を確認します。

---

## `sudo systemctl stop sshd`
sshdサービスを停止します。

---

## `sudo systemctl start sshd`
sshdサービスを起動します。

---

## `sudo systemctl restart sshd`
sshdサービスを再起動します。設定変更後に使用します。

---

## `sudo systemctl enable sshd`
sshdをシステム起動時に自動起動するよう設定します。

---

## `sudo systemctl disable sshd`
sshdの自動起動設定を無効にします。

---

## `systemctl is-enabled sshd`
sshdが自動起動に設定されているか確認します。

---

## `systemctl is-active sshd`
sshdが現在起動中かどうか確認します。

---

## `journalctl -u sshd`
sshdに関連するログを表示します。

---

## `journalctl -f`
システムログをリアルタイムで監視します。

---

## `journalctl -p err`
システム全体のエラーレベルのログのみ表示します。

---

## `journalctl -p err --since "1 hour ago"`
直近1時間以内に発生したエラーログを表示します。

---

## `systemctl get-default`
システムの起動時のデフォルトターゲット（モード）を確認します。
```

---
# 📅 2026-03-23
---

## `lsblk`
接続されている全ディスクとパーティション構成を確認します。

---

## `fdisk -l`
全ディスクの詳細情報（サイズ・パーティションテーブル）を確認します。

---

## `df -hT`
現在マウントされているファイルシステムの使用状況とタイプを確認します。

---

## `sudo fdisk /dev/vdb`
vdbディスクのパーティション設定を対話形式で開始します。

## `# n → p → 1 → Enter → +1G → w`
新規パーティション作成の手順：新規(n)→基本(p)→番号1→開始位置デフォルト→サイズ+1G→書き込み(w)。

---

## `sudo mkfs.ext4 /dev/vdb1`
vdb1パーティションをext4ファイルシステムでフォーマットします。

---

## `sudo mkdir /mnt/testdisk`
vdb1のマウントポイントとなるディレクトリを作成します。

---

## `sudo mount /dev/vdb1 /mnt/testdisk`
フォーマット済みのvdb1をtestdiskディレクトリにマウントします。

---

## `df -h | grep testdisk`
testdiskのマウントが成功しているか確認します。

---
# 📅 2026-03-24
---

## `sudo blkid /dev/vdb1`
vdb1のUUIDを確認します。fstabへの記載に使用します。

---

## `sudo vi /etc/fstab`
システム起動時の自動マウント設定を編集します。

## `# UUID=xxxx /mnt/testdisk ext4 defaults 0 2`
UUIDを使って永続マウントを設定する書式です。

---

## `sudo umount /mnt/testdisk`
testdiskをアンマウントします。

---

## `sudo mount -a`
/etc/fstabの内容を再読み込みし、全エントリをマウントします。

---

## `df -h | grep testdisk`
mount -aによるマウントが成功しているか確認します。

---
# 📅 2026-03-25
---

## `sudo pvcreate /dev/vdb2`
vdb2をLVM用の物理ボリューム（PV）として初期化します。

---

## `sudo vgcreate vg_test /dev/vdb2`
vg_testというボリュームグループ（VG）を作成し、PVを追加します。

---

## `sudo lvcreate -L 500M -n lv_data vg_test`
vg_testから500MBを切り出し、lv_dataという論理ボリューム（LV）を作成します。

---

## `pvdisplay`
物理ボリュームの詳細情報を確認します。

---

## `vgdisplay`
ボリュームグループの詳細情報を確認します。

---

## `lvdisplay`
論理ボリュームの詳細情報を確認します。

---

## `sudo mkfs.xfs /dev/vg_test/lv_data`
論理ボリュームをXFSファイルシステムでフォーマットし、データの読み書きができる状態にします。

---

## `sudo mkdir /mnt/lvmtest`
論理ボリュームのマウントポイントとなるディレクトリを作成します。

---

## `sudo mount /dev/vg_test/lv_data /mnt/lvmtest`
フォーマット済みの論理ボリュームをlvmtestディレクトリにマウントします。
