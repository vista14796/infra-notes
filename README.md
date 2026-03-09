# infra-notes
Infrastructure / Cloud learning notes
# Active Directory ユーザー自動作成（PowerShell 自動化）

## 概要

このラボでは PowerShell を使用して  
Active Directory のユーザーアカウントを自動作成するスクリプトを作成しました。

想定シナリオ：

人事部（HR）から **100人のインターン名簿** を受け取り、  
システム管理者が Active Directory にユーザーを作成する。

手動作業では時間がかかるため、PowerShell による自動化を実装しました。

---

## 使用技術

- Windows Server
- Active Directory
- PowerShell

---

## システム構成

OU（部署）は以下の2種類を想定しています。

```
Company
 ├─ Sales
 └─ IT
```

各ユーザーは指定された OU に自動的に作成されます。

---

# Part 1 : テスト用ユーザー名簿の自動生成

実際の企業では HR から名簿が提供されますが、  
今回のラボではテスト用として **ランダムな100人のユーザー名簿を自動生成**しました。

生成する情報：

- 名前
- 部署（Sales / IT）

PowerShell でランダムな組み合わせを作成します。

例：

```
Name        Department
Tanaka      Sales
Suzuki      IT
Sato        Sales
```

このデータを元に Active Directory のユーザーを作成します。

---

# Part 2 : Active Directory ユーザー自動作成

次の処理を自動化しました。

1. ユーザーアカウント作成  
2. 指定 OU に配置  
3. 重複チェック  
4. エラー表示  

---

## 処理フロー

```
HR名簿
 ↓
PowerShellスクリプト
 ↓
重複チェック
 ↓
Active Directory にユーザー作成
 ↓
指定OUへ配置
```

---

## 重複チェック機能

以下の重複をチェックします。

- ユーザー名
- アカウント名

もし重複が検出された場合：

```
Warning: Duplicate user detected
Please confirm with HR department
```

黄色メッセージで警告を表示し、  
HR 部門に確認するよう通知します。

---

## 作成されるユーザー例

```
User: tanaka.t
Department: Sales
OU: Sales
```

```
User: suzuki.k
Department: IT
OU: IT
```

---

# 自動化の効果（作業時間比較）

## 手動作業

ユーザー1人作成：

約30秒

100人の場合：

```
30秒 × 100
= 約50分
```

---

## PowerShell 自動化

100ユーザー作成：

```
約23秒
```

---

## 結果

| 方法 | 作業時間 |
|-----|------|
| 手動作成 | 約50分 |
| 自動作成 | 約23秒 |

PowerShell による自動化により  
**大幅な作業時間短縮**が可能になりました。

---

# 学習ポイント

このラボで学習した内容：

- Active Directory ユーザー管理
- PowerShell 自動化
- スクリプトによる大量ユーザー作成
- 重複チェックの実装

---

# 今後の改善

今後は以下の機能を追加したいと考えています。

- CSV ファイルからユーザー作成
- パスワード自動生成
- グループ自動割り当て
- ログ出力

---

# まとめ

PowerShell を使用することで  
Active Directory のユーザー管理作業を効率化できる。

特に大量ユーザー作成では  
**自動化の効果が非常に大きい**ことを確認しました。
