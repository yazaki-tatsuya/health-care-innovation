#---- 掲載時不要START ----#
import sys,os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
#---- 掲載時不要END ----#
import datetime as dt
import requests
import time
import env

# === ユーザー設定 ===
LOGIC_APP_URL = env.get_env_variable("LOGIC_APP_URL_HEART")  # Logic App の URL

START_DATE    = "2024-12-10"                      # 取得開始日 (yyyy-mm-dd)
END_DATE      = "2024-12-11"                       # 取得終了日 (空なら今日)
PAUSE_SEC     = 30                                 # API 呼び出し間隔（秒）負荷対策
# ===========================================================
def date_range(start: str, end: str):
    """start～end(含む) の日付文字列を順に yield"""
    s, e = dt.date.fromisoformat(start), dt.date.fromisoformat(end)
    d = s
    while d <= e:
        yield d.isoformat()
        d += dt.timedelta(days=1)

def call_logic_app(date_str: str):
    payload = { "date": date_str }
    resp = requests.post(LOGIC_APP_URL, json=payload, timeout=90)
    if resp.ok:
        print(f"[OK ] {date_str}")
    else:
        print(f"[NG ] {date_str}  status={resp.status_code}  body={resp.text}")

def main():
    if not LOGIC_APP_URL:
        raise ValueError("LOGIC_APP_URL を設定してください")

    end_date = END_DATE or dt.date.today().isoformat()
    for d in date_range(START_DATE, end_date):
        call_logic_app(d)
        time.sleep(PAUSE_SEC)  # 速すぎる連打を回避

if __name__ == "__main__":
    main()
