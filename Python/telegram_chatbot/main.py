'''
# Uvicorn : 서버 역할(프레임워크, 손 안 댐)
# FastAPI : 요청(Request)과 응답(Response)을 처리하는 로직 담당

[클라이언트(브라우저, 앱 등)]
        ↓ 요청
+----------------------+
|      Uvicorn (서버)   |  ← 요청 받는 입구
|   (ASGI Web Server)  |
+----------------------+
         ↓
+----------------------+
|     FastAPI (로직)   |  ← 실제 처리 (함수 실행, DB 조회 등)
+----------------------+
         ↓
+----------------------+
|      Uvicorn (서버)   |  ← 응답 전달 출구
+----------------------+
        ↓ 응답
[클라이언트]

# 서버 켜기
uvicorn main(py 파일명):app(FastAPI 변수명) --reload
# 서버 끄기
Crtl+C
'''

from fastapi import FastAPI
import random

app =  FastAPI()

@app.get('/hi')
def hi():
    return {'status': 'HI! :)'}

@app.get('/lotto')
def lotto():
    return {
        'numbers' : sorted(random.sample(range(1, 46), 6))
    }