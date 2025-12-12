
````md
## Git 小抄（繁中）

> 常用指令速記（可列印貼紙 / README 封面用）

### 最常用 5 招
```bash
git remote -v                  # 檢視遠端 URL（fetch/push）
git push -u origin main        # 首次推送並綁定上游
git add README.md              # 把檔案加入暫存區
git commit -m "訊息"           # 建立提交
git push                       # 推到已綁定的遠端分支
````

### 狀態 / 檢視

```bash
git status
git log --oneline --graph --decorate --all
git diff
git diff --staged
```

### 分支 / 合併

```bash
git branch
git switch -c <branch>
git switch main
git merge <branch>
git branch -d <branch>     # 安全刪除
git branch -D <branch>     # 強制刪除
```

### 遠端 / 上游

```bash
git remote add origin git@github.com:<you>/<repo>.git
git remote set-url origin <new-url>
git push -u origin <branch>
git pull --rebase
```

### 暫存 / 復原

```bash
git add .
git restore <file>
git restore --staged <file>
git reset HEAD <file>
git commit --amend
```

### 回滾 / 版本

```bash
git revert <commit>
git reset --hard <commit>
git checkout <commit> -- <file>
```

### 標籤（Tag）

```bash
git tag -a v1.0 -m "v1.0"
git push origin v1.0
git push --tags
```

### SSH / GitHub 自檢

```bash
ssh -T git@github.com         # 要看到：Hi <user>!
git remote -v                 # 確認是 SSH：git@github.com:...
git config user.name
git config user.email
```

</details>
```

---

## 🚀 Git + Terraform 雙小抄

| 工具            | 指令                                       | 說明                    |
| ------------- | ---------------------------------------- | --------------------- |
| **Git**       | `git init`                               | 初始化 Git 專案            |
|               | `git clone <url>`                        | 複製遠端 repo             |
|               | `git status`                             | 查看目前狀態                |
|               | `git add <file>`                         | 把檔案加入暫存區              |
|               | `git commit -m "訊息"`                     | 建立提交                  |
|               | `git push`                               | 推送到遠端分支               |
|               | `git pull`                               | 拉取遠端最新版本              |
|               | `git remote -v`                          | 查看遠端 repo             |
|               | `git log --oneline --graph --all`        | 簡潔查看提交歷史              |
| **Terraform** | `terraform init`                         | 初始化 provider 與 module |
|               | `terraform fmt -recursive`               | 統一格式（含子資料夾）           |
|               | `terraform validate`                     | 檢查語法是否正確              |
|               | `terraform plan`                         | 預覽變更（不會套用）            |
|               | `terraform apply`                        | 套用變更，建立/更新資源          |
|               | `terraform destroy`                      | 銷毀資源                  |
|               | `terraform state list`                   | 列出目前受管資源              |
|               | `terraform state show <resource>`        | 查看指定資源狀態              |
|               | `terraform apply -var-file="dev.tfvars"` | 使用變數檔案                |
|               | `terraform output`                       | 查看輸出的值                |

---

### 📌 小建議

* **日常開發工作流**

  1. `git pull` → 拿最新程式碼
  2. `terraform fmt -recursive` → 格式化
  3. `terraform validate` → 驗證語法
  4. `terraform plan` → 預覽變更
  5. `terraform apply` → 實際套用
  6. `git add . && git commit -m "更新 IaC"`
  7. `git push` → 提交到 repo

---

## 🌀 Git + Terraform 工作流

```text
          ┌──────────────┐
          │   編輯程式碼   │
          └───────┬──────┘
                  │
                  ▼
          ┌──────────────┐
          │   git add .   │
          └───────┬──────┘
                  │
                  ▼
          ┌──────────────┐
          │git commit -m ""│
          └───────┬──────┘
                  │
                  ▼
          ┌──────────────┐
          │   git push    │───────▶ (遠端 Repo)
          └───────┬──────┘
                  │
                  ▼
        =====================
        | Terraform WorkFlow |
        =====================
                  │
                  ▼
      ┌───────────────────────┐
      │ terraform fmt -recursive │  ← 格式化
      └───────────┬───────────┘
                  │
                  ▼
      ┌───────────────────────┐
      │  terraform validate    │  ← 驗證語法
      └───────────┬───────────┘
                  │
                  ▼
      ┌───────────────────────┐
      │   terraform plan       │  ← 預覽變更
      └───────────┬───────────┘
                  │
                  ▼
      ┌───────────────────────┐
      │   terraform apply      │  ← 套用變更
      └───────────┬───────────┘
                  │
                  ▼
      ┌───────────────────────┐
      │ terraform destroy (選用)│  ← 銷毀資源
      └───────────────────────┘
```

---

## 🎯 不想把改動 push 到 GitHub，並想完全還原成 GitHub 目前的版本

* ✅ **Cloud9 本地有改過一些語法**
* ❌ **不想把這些改動 push 到 GitHub**
* ✅ **希望 Cloud9 完全還原成 GitHub 目前的版本**
* GitHub Repo（public）
  👉 [https://github.com/haha1811/haha-iac-demo](https://github.com/haha1811/haha-iac-demo)

---

# ✅ 最推薦做法（安全、乾淨、不留後遺症）

### 👉 **直接丟掉 Cloud9 的本地修改，強制同步 GitHub**

### 1️⃣ 先確認目前狀態（建議一定要看）

```bash
git status
```

你可能會看到類似：

```
modified:   main.tf
modified:   variables.tf
```

---

### 2️⃣ 丟掉「所有尚未 commit 的修改」

⚠️ **這一步會直接刪掉 Cloud9 上的本地改動**

```bash
git reset --hard
```

📌 效果：

* 回到「**最後一次 commit 的狀態**」
* 不會產生任何 commit
* 不會影響 GitHub

---

### 3️⃣ 從 GitHub 抓最新版本（強制同步）

```bash
git pull origin main
```

✅ 到這一步為止：

* Cloud9 = GitHub 目前版本
* 本地改動完全清空
* 不會有任何東西被推上 GitHub

---

### 4️⃣ 再確認一次（保險）

```bash
git status
```

看到這行就對了：

```
working tree clean
```

---

# 🟢 快速版（你很確定不要本地修改）

如果你 **100% 確定 Cloud9 的修改都不要了**，可以直接三行搞定：

```bash
git fetch origin
git reset --hard origin/main
git status
```

📌 這一組等於：

> 「Cloud9 強制對齊 GitHub main 分支」

---

:::info
把這些 untracked 目錄刪掉
```bash!
# 先預覽會刪哪些
git clean -nd

# 確認沒問題後，真正刪除：
git clean -fd

# 做完再看一次：
git status
```
:::

---

# ⚠️ 常見錯誤提醒（你這次剛好避開）

❌ **不要做這些事**

```bash
git add .
git commit -m "fix"
git push
```

一旦 commit + push
👉 就真的會上 GitHub（即使是測試用）

---

# 🧠 補充（進階但很實用）

## 如果你只是「想暫時保留」Cloud9 改動

可用 stash（之後還原）

```bash
git stash
git pull origin main
```

之後想拿回來：

```bash
git stash pop
```

👉 適合「我改到一半，但現在想先回 GitHub 版本看看」

---

## 🚀 Aurora Serverless v2 PostgreSQL 練習記錄

本次練習在現有的 IAC 模組結構上，加入了 **Aurora Serverless v2 (PostgreSQL)**、**Subnet Group**、**SNS 通知** 以及 **CloudWatch CPU 告警**，達到完整的 AWS 資料庫自動化部署流程。

### 📌 本次練習重點

* 建立 Aurora Serverless v2（engine = `aurora-postgresql`）
* 使用 Private Subnets 建立 DB Subnet Group
* 建置 Serverless v2 Scaling 設定（min/max ACU）
* 建立 SNS Topic + Email Subscription
* 建立 CloudWatch Alarm（CPUUtilization > 70%）
* 將 Writer / Reader Endpoint 輸出供 AP/CLI 使用

### 📁 新增檔案

* `aurora.tf` — 包含 Aurora Cluster、Instance、Subnet Group、SNS、Alarm、Outputs
* `variables.tf` — 新增 Aurora 與 SNS 相關變數
* `terraform.tfvars` — 補上密碼與收信 email

---

### 🧩 Aurora Serverless v2 — Terraform 語法摘要

```hcl
resource "aws_rds_cluster" "aurora_pg" {
  engine = "aurora-postgresql"

  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 4
  }
}
```

---

### 📡 CloudWatch CPU Alarm（SNS 通知）

```hcl
resource "aws_cloudwatch_metric_alarm" "aurora_cpu_high" {
  metric_name = "CPUUtilization"
  threshold   = 70
  alarm_actions = [
    aws_sns_topic.aurora_alarm_topic.arn
  ]
}
```

---

### 🎯 實作成果

Terraform 自動建立：

* Aurora Serverless v2 叢集 + Writer Instance
* 私網 Subnet Group
* SNS 通知（Email 訂閱）
* CloudWatch CPU Alarm（>70%）
* Writer / Reader Endpoint 輸出至 CLI

---






