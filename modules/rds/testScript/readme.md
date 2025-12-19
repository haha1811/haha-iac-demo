# ✅ Aurora PostgreSQL Serverless v2

## Database / Table 初始化速查筆記（實作版）

### 環境前提

* Aurora PostgreSQL Serverless v2 已建立
* Writer Endpoint 可連線
* 已有管理者帳號（例：`auroraadmin`）

---

## 1️⃣ 連線到預設 postgres database

```bash
psql \
  -h haha-iac-demo-aurora-pg-writer-1.cbzkloua6rqu.ap-northeast-1.rds.amazonaws.com \
  -U auroraadmin \
  -d postgres
```

---

## 2️⃣ 建立 application database（若已存在會噴錯，可忽略）

```sql
CREATE DATABASE appdb;
```

確認：

```sql
\l
```

---

## 3️⃣ 切換到 appdb

```sql
\c appdb
```

---

## 4️⃣ 建立測試用資料表（INSERT 測試用）

```sql
CREATE TABLE IF NOT EXISTS connection_test (
  id SERIAL PRIMARY KEY,
  source_host VARCHAR(50) NOT NULL,
  note TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

驗證：

```sql
\dt
\d connection_test
```

---

## 5️⃣ 手動測試 INSERT / SELECT

```sql
INSERT INTO connection_test (source_host, note)
VALUES ('manual-test', 'first insert');

SELECT * FROM connection_test ORDER BY id DESC LIMIT 5;
```

---

## 6️⃣ 離開 psql

```sql
\q
```

---

# 7️⃣ 批次寫入測試（模擬流量 / ACU 壓力）

好，我直接給你一份「**有 retry + 記錄失敗次數 + 最後輸出統計**」的版本（可直接取代你原本的 `auroraSLV2PgInsertData.sh`）。

下面這版有幾個重點：

* 每筆 `no:i` **最多重試 N 次**（預設 5 次）
* 每次失敗會記錄到 `insert_fail_log.csv`（含時間、no、attempt、錯誤訊息）
* 成功也會印 `no:i OK (attempt=x)`，方便你觀察 scale 抖動
* 最後會印出：總筆數、成功筆數、失敗筆數、總重試次數、最大連續失敗次數

---

## ✅ Script：retry + fail log + summary

```bash
#!/bin/bash
set -u

HOST="haha-iac-demo-aurora-pg-writer-1.cbzkloua6rqu.ap-northeast-1.rds.amazonaws.com"
USER="auroraadmin"
DB="appdb"
SOURCE_HOST="ap01"

TOTAL=500
MAX_RETRY=5          # 每筆最多重試幾次
BASE_SLEEP=1         # 退避秒數基底（會做 exponential backoff）
LOG_FILE="insert_fail_log.csv"

# 統計用
success_count=0
fail_count=0
total_retry_used=0
consec_fail=0
max_consec_fail=0

# log header（如果檔案不存在才寫）
if [ ! -f "$LOG_FILE" ]; then
  echo "ts,no,attempt,rc,error" > "$LOG_FILE"
fi

for i in $(seq 1 $TOTAL); do
  attempt=1
  ok=0
  last_err=""
  last_rc=0

  while [ $attempt -le $MAX_RETRY ]; do
    echo "no:$i attempt:$attempt inserting..."

    # 把 stderr 也抓下來，方便記錄錯誤
    out=$(psql -h "$HOST" -U "$USER" -d "$DB" \
      -v ON_ERROR_STOP=1 \
      -c "INSERT INTO connection_test (source_host, note)
          VALUES ('$SOURCE_HOST', 'no:$i');" 2>&1)
    rc=$?

    if [ $rc -eq 0 ]; then
      echo "no:$i OK (attempt=$attempt)"
      ok=1
      success_count=$((success_count + 1))

      # 成功但若 attempt>1 代表用了 retry
      if [ $attempt -gt 1 ]; then
        total_retry_used=$((total_retry_used + attempt - 1))
      fi

      consec_fail=0
      break
    else
      ts=$(date '+%F %T')
      # CSV 內避免換行，把錯誤訊息壓成一行
      err_one_line=$(echo "$out" | tr '\n' ' ' | sed 's/  */ /g' | sed 's/"/""/g')
      echo "\"$ts\",$i,$attempt,$rc,\"$err_one_line\"" >> "$LOG_FILE"

      echo "no:$i FAIL (attempt=$attempt rc=$rc)"
      last_err="$out"
      last_rc=$rc

      consec_fail=$((consec_fail + 1))
      if [ $consec_fail -gt $max_consec_fail ]; then
        max_consec_fail=$consec_fail
      fi

      # Exponential backoff：1,2,4,8...（上限 30 秒）
      sleep_sec=$((BASE_SLEEP * (2 ** (attempt - 1))))
      if [ $sleep_sec -gt 30 ]; then sleep_sec=30; fi
      echo "no:$i retry in ${sleep_sec}s..."
      sleep "$sleep_sec"

      attempt=$((attempt + 1))
    fi
  done

  if [ $ok -ne 1 ]; then
    echo "no:$i FINAL FAIL after $MAX_RETRY attempts (last rc=$last_rc)"
    fail_count=$((fail_count + 1))
    # 不中斷，繼續跑下一筆，才能觀察整段期間的抖動
  fi
done

echo "================ SUMMARY ================"
echo "TOTAL            : $TOTAL"
echo "SUCCESS          : $success_count"
echo "FAILED           : $fail_count"
echo "TOTAL RETRIES USED (sum): $total_retry_used"
echo "MAX CONSEC FAILS : $max_consec_fail"
echo "FAIL LOG         : $LOG_FILE"
echo "========================================="
```

---

## ✅ 使用方式

```bash
chmod +x auroraSLV2PgInsertData.sh
./auroraSLV2PgInsertData.sh
```

它會在同目錄產生：

* `insert_fail_log.csv`：失敗明細（時間、no、attempt、rc、error）

---

## ✅ 事後查「到底有哪些 no 沒成功寫入」

你目前的 table 只有 `note`，所以可用 note 反查（因為我們寫了 `no:i`）：

```bash
psql -h "$HOST" -U "$USER" -d "$DB" -c \
"SELECT * FROM connection_test WHERE note LIKE 'no:%' ORDER BY id DESC LIMIT 10;"
```

或快速算有幾筆 no：

```bash
psql -h "$HOST" -U "$USER" -d "$DB" -c \
"SELECT count(*) FROM connection_test WHERE note LIKE 'no:%';"
```

---

