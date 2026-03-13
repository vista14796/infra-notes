# Active Directory ユーザー自動作成ラボ

PowerShell を使って Active Directory のユーザー作成を自動化する練習をしました。

想定シナリオ：

人事部から **100人のインターン名簿** を受け取り、  
それを元に AD ユーザーを作成する。

手動作業だと時間がかかるため、PowerShell で自動化してみました。

---

## 環境

- Windows Server
- Active Directory
- PowerShell

---

## OU 構成

今回のラボでは部署を2種類に設定しました。

```
Sales
IT
```

ユーザーはそれぞれの OU に作成されます。

---

## Part1 テストユーザー生成

今回は実際の名簿がないため  
PowerShell を使って **ランダムな100人のユーザー名** を生成しました。

ユーザー情報：

- 名前
- 部署（Sales / IT）

例：

```
Tanaka - Sales
Suzuki - IT
Sato - Sales
```

---

## Part2 ADユーザー自動作成

スクリプトでは以下の処理を行います。

- ユーザー作成
- OU 振り分け
- 重複チェック

---

## 重複チェック

もし同じユーザー名が存在する場合：

```
Warning: Duplicate user detected
```

警告メッセージを表示します。

この場合は HR に確認する想定です。

---

## 作業時間比較

### 手動作成

1ユーザー：約30秒

100ユーザー：

```
約50分
```

---

### PowerShell 自動化

100ユーザー作成：

```
約23秒
```

---

## 感想

PowerShell を使うことで  
大量ユーザー作成の作業時間を大きく短縮できると感じました。

まだ基本的な機能だけですが  
今後は以下も試してみたいです。

- CSV からユーザー作成
- グループ自動追加
- ログ出力

## 関連スクリプト

- [`generate_users.ps1`](../scripts/ad/generate_users.ps1) - ユーザーリスト生成スクリプト
- [`create_ad_users.ps1`](../scripts/ad/create_ad_users.ps1) - ADユーザー自動作成スクリプト
