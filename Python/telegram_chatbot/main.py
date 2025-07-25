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

from fastapi import FastAPI, Request
import random
import requests

bot_token = ''
URL = f'https://api.telegram.org/bot{bot_token}'
app =  FastAPI()

@app.get('/')  # 라우팅  (목록 : http://127.0.0.1:8000/docs)(http://localhost:8000/docs)
def home():
    return {'home': 'sweet home'}


# 라우팅으로 텔레그램 서버가 챗봇 업데이트가 있을 경우 알려줌

def send_message(chat_id, message):
    body = {
        'chat_id': chat_id,
        'text': message
    }
    requests.get(URL + '/sendMessage', body)

@app.post('/telegram')
async def telegram(request: Request):
    print('noh-bot에 새로운 메세지가 들어왔습니다')

    data = await request.json()    # 텔레그램이 보낸 데이터를 확인, 아직 이해 안 해도 됨
    print(data)
    
    sender_id = data['message']['from']['id']
    input_msg = data['message']['text']
    send_message(sender_id, input_msg)
    return {'status': 'message received'}


@app.get('/lotto')
def lotto():
    return {
        'numbers': sorted(random.sample(range(1, 46), 6))
    }