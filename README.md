# Infra Notes

Infrastructure / Cloud learning notes.

---

## Learning Progress

- [x] Linux basic commands
- [x] Active Directory user automation
- [x] Hyper-V Bulk VM Deployment
- [x] Azure Hybrid Identity
- [x] Azure Hybrid Cloud VPN
- [ ] AWS basic infrastructure

---

## Projects

### Linux Basic Commands

Linux 基本コマンドの練習ノート。

学習の進捗に合わせて順次更新していきます。

[Read the notes](docs/linux-basic-commands-ja.md)

---

### Active Directory User Automation

PowerShell を使用して Active Directory のユーザー作成を自動化する練習。

[Read the lab](docs/ad-user-automation-ja.md)

[Read the generate_users script](scripts/ad/generate_users.ps1)

[Read the create_ad_users script](scripts/ad/create_ad_users.ps1)


---

### Hyper-V Bulk VM Deployment

PowerShell を使用して Windows Server 2025 を一括デプロイする自動化スクリプト。

[Read the lab notes](docs/hyperv-bulk-deploy-ja.md)

[Read the bulk_deploy_vm script](scripts/hyperv/bulk_deploy_vm.ps1)

[Read the rename_computer script](scripts/hyperv/rename_computer.ps1)


---

### Azure Hybrid Identity

地端 Active Directory と Azure Entra ID を連携させた混合クラウド環境の構築と除錯記録。

[Read the lab notes](docs/azure-hybrid-identity-ja.md)

---

### Azure Hybrid Cloud VPN

オンプレミス AD と Azure Entra ID を連携させ、P2S VPN 経由でセキュアなハイブリッドクラウド運用環境を構築したプロジェクトです。

Ansible による自動デプロイと NAT Gateway によるアウトバウンド制御を実装しています。

[Read the lab notes](docs/azure-hybrid-cloud-vpn-ja.md)

---
