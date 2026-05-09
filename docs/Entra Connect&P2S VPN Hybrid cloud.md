# Entra Connect と P2S VPN によるハイブリッドクラウドリモート運用実装

Microsoft Azure を活用し、オンプレミス環境とクラウドを安全に接続するハイブリッドクラウドアーキテクチャを実装しました。

---

## 想定シナリオ

台湾の中小企業が日本へ事業展開し、一部の従業員がリモートで勤務するケースを想定しています。

**核心的な課題：**
> リモート従業員が、サーバーを公網に露出させることなく、安全にクラウドサーバーへ接続して運用作業を行うにはどうすればよいか？

---

## 環境

**オンプレミス（台湾本社）**
- Windows Server 2025（Active Directory + Entra Connect）
- Rocky Linux（Ansible コントロールノード）
- VMware Workstation

**クラウド（Azure East US）**
- Azure Virtual Network（10.0.0.0/16）
- Azure VPN Gateway（Basic SKU / P2S）
- Azure VM（Ubuntu）
- Network Security Group（NSG）
- NAT Gateway

---

## アーキテクチャ概要

本プロジェクトは2つの主要フローで構成されています。

### ① アカウント同期フロー（Identity）

```
Windows Server AD → Entra Connect（HTTPS/TLS1.2+）→ Azure Entra ID
```

- 台湾従業員と日本従業員のアカウントを1台の AD で一元管理
- OU=Taiwan（TW001〜TW050）、OU=Japan（JP001〜JP050）に分類
- Entra Connect により、オンプレミス AD アカウントをクラウドへ一方向同期
- 従業員はオンプレミスとクラウドで**同一のアカウント・パスワード**を使用（SSO）

### ② リモート安全接続フロー（Networking + Security）

```
従業員端末 → P2S VPN（憑証認証）→ Azure VPN Gateway → NSG → Azure VM
```

- P2S VPN：物理的な VPN 機器不要。従業員 PC に VPN Client をインストールするだけ
- 接続後、P2S アドレスプール IP（172.16.201.x）が自動割り当て
- NSG：全ての公網インバウンドをブロック。VPN アドレスプールからの SSH（Port 22）のみ許可
- **Zero Trust アーキテクチャ**の実践：VPN なしでは VM に一切アクセス不可

### ③ 自動化運用（Automation）

```
Rocky Linux（Ansible）→ VPN トンネル経由 SSH → Azure VM → nginx インストール
```

- NAT Gateway：VM がパブリック IP なしでアウトバウンド接続可能
  （Azure 2025年の Default Outbound Access 廃止への対応）
- Ansible Playbook で nginx を自動デプロイ
- **「インバウンドは VPN、アウトバウンドは NAT」** のエンタープライズ標準設計

---

## AD アカウント自動化（期中専題との連携）

本プロジェクトでは、期中専題（[`Active Directory ユーザー自動作成ラボ`](../docs/ad-user-automation-ja.md)）で作成した PowerShell スクリプトを活用し、
100件の従業員アカウントを自動生成・AD へバッチインポートしました。

| スクリプト | 役割 |
|-----------|------|
| [`generate_users.ps1`](../scripts/ad/generate_users.ps1)| ランダムな従業員名簿100件を生成（CSV形式） |
| [`create_ad_users.ps1`](../scripts/ad/create_ad_users.ps1)| CSV を読み込み AD へバッチインポート・OU 振り分け |

**PowerShell 実行結果（一部）：**
```
Success: JP043 (Tsai_Wei) -> Japan
Success: JP044 (Wu_An)   -> Japan
警告: 姓名重複：Tsai_Yu 已存在，跳過。Duplicate Name: Tsai_Yu already exists. Skipped.
...
===== 完了 =====
Success : 63
Failed  : 37（重複名前によるスキップ）
```

> スクリプトは重複名を検出した場合、警告を表示してスキップします。
> バッチ処理全体は中断されません。

---

## 検証指標と結果

| 検証項目 | 検証方法 | 結果 |
|---------|---------|------|
| AD アカウント同期 | Azure Portal → Entra ID → ユーザーリスト確認 | 73名、ソース「オンプレミス同期」✓ |
| P2S VPN 接続 | VPN 切断/接続の ping 比較テスト（10.0.1.4） | 切断：応答なし、接続：応答あり ✓ |
| NSG ブロック検証 | VPN 切断後にブラウザでアクセス | 「このサイトにアクセスできません」✓ |
| Ansible nginx デプロイ | Playbook 実行 + ブラウザ確認 | Welcome to nginx! 表示 ✓ |

---

## トラブルシューティング記録

### ① VPN 接続エラー 809
- **現象：** Azure VPN Client でエラーコード 809 が発生
- **原因：** IKEv2 + OpenVPN プロトコルと Windows の互換性問題
- **解決：** プロトコルを **IKEv2 + SSL（SSTP）** に変更 → 即座に接続成功
- **所要時間：** 約2〜3時間

### ② Ansible タイムアウト（Azure 2025 アウトバウンドポリシー）
- **現象：** 環境再構築後、apt update でタイムアウト発生
- **原因：** Azure が Default Outbound Access を段階的廃止
- **解決：** **NAT Gateway** を導入し BackendSubnet に関連付け
- **結果：** Ansible によるデプロイが正常に完了

### ③ PowerShell Filter 変数展開問題
- **現象：** Get-ADUser の Filter 内で `$User.EmployeeID` が認識されず全件失敗
- **原因：** PowerShell の ScriptBlock 内は外部変数を自動展開しない
- **解決：** `$EmpID = $User.EmployeeID` と先に変数へ代入してから Filter 内で使用

---

## アーキテクチャの移植性

本プロジェクトの設計思想は **Azure に限定されません**。

「ID 同期 + VPN + ファイアウォール」というアーキテクチャは、他のクラウドプラットフォームにも同様に適用可能です。

| コンポーネント | Azure | AWS | GCP |
|--------------|-------|-----|-----|
| ID 同期 | Entra Connect | AWS Directory Service | Cloud Identity |
| VPN | P2S VPN Gateway | Client VPN | Cloud VPN |
| ファイアウォール | NSG | Security Group | Firewall Rules |
| アウトバウンド制御 | NAT Gateway | NAT Gateway | Cloud NAT |

ツール名は異なりますが、**設計ロジックは完全に共通**しています。
Azure でこのアーキテクチャを習得することで、AWS・GCP のドキュメントも素早く理解できます。

---

## 使用技術スタック

`Windows Server AD` 、`Microsoft Entra Connect` 、`Azure Entra ID`
、`Azure VPN Gateway (P2S)` 、`NSG` 、`NAT Gateway` 、`Azure VM`
、`Rocky Linux` 、`Ansible` 、`nginx` 、`PowerShell` 、`VMware Workstation`

---

## 関連リポジトリ

- [Active Directory ユーザー自動作成ラボ](../docs/ad-user-automation-ja.md)
