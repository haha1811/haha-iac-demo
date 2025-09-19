
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






