import datetime as dt
import requests
import time
import os
import sys
from dotenv import load_dotenv

# 1) .env 読み込み
#    必要なら dotenv_path でフルパスを指定してください
load_dotenv()

# 2) 環境変数取得＆デバッグ出力
base_path = os.getenv("PROJECT_ROOT_PATH")
print("🔍 PROJECT_ROOT_PATH =", base_path)
if not base_path:
    raise RuntimeError("❌ PROJECT_ROOT_PATH が取得できません。 .env の場所／中身を確認してください。")

# 3) sys.path に追加＆デバッグ出力
sys.path.insert(0, base_path)
print("🔍 sys.path[0] =", sys.path[0])
print("🔍 env.py exists?:", os.path.isfile(os.path.join(base_path, "env.py")))

# 4) env モジュール読み込み
import env  
print("🔍 env module loaded:", env)

# === ユーザー設定 ===
LOGIC_APP_URL = env.get_env_variable("LOGIC_APP_URL_SLEEP")  # Logic App の URL
START_DATE    = "2025-04-01"                                # 取得開始日 (yyyy-mm-dd)
END_DATE      = "2025-05-10"                                # 取得終了日 (空文字 or None なら今日)
PAUSE_SEC     = 30                                          # API 呼び出し間隔（秒）
MAX_RETRIES   = 3                                           # リトライ回数
BACKOFF_BASE  = 2                                           # バックオフ係数
# ===========================================================

def date_range(start: str, end: str):
    """start～end(含む) を日付文字列で yield"""
    s = dt.date.fromisoformat(start)
    e = dt.date.fromisoformat(end)
    d = s
    while d <= e:
        yield d.isoformat()
        d += dt.timedelta(days=1)

def call_logic_app(date_str: str):
    payload = { "date": date_str }
    for attempt in range(1, MAX_RETRIES + 1):
        try:
            resp = requests.post(LOGIC_APP_URL, json=payload, timeout=90)
        except requests.RequestException as ex:
            print(f"[ERR] {date_str} attempt={attempt}: {ex}")
        else:
            if resp.ok:
                print(f"[OK ] {date_str}")
                return True
            # リトライ対象ステータス
            if resp.status_code in (429,) or 500 <= resp.status_code < 600:
                wait = BACKOFF_BASE ** (attempt - 1)
                print(f"[RETRY] {date_str} status={resp.status_code}, backoff={wait}s")
                time.sleep(wait)
            else:
                print(f"[NG ] {date_str} status={resp.status_code}")
                return False
    print(f"[FAIL] {date_str} after {MAX_RETRIES} attempts")
    return False

def main():
    if not LOGIC_APP_URL:
        raise ValueError("LOGIC_APP_URL を設定してください")

    # END_DATE が未設定なら今日を採用
    end_date = END_DATE.strip() or dt.date.today().isoformat()

    for d in date_range(START_DATE, end_date):
        call_logic_app(d)
        time.sleep(PAUSE_SEC)  # 速すぎる連打を回避

if __name__ == "__main__":
    main()
