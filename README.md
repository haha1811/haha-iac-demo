好了！我幫你做了一張可放進 README 的「Git 小抄（繁中）」PNG。

[下載 PNG（git\_cheatsheet\_zhTW.png）](sandbox:/mnt/data/git_cheatsheet_zhTW.png)

---

## 直接嵌到 README 的 Markdown（貼紙版）

把下面這段貼到 `README.md` 就行：

````md
## Git 小抄（繁中）

> 常用指令速記（可列印貼紙 / README 封面用）

![Git 小抄（繁中）](docs/git_cheatsheet_zhTW.png)

<details>
<summary>文字版（可複製）</summary>

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


