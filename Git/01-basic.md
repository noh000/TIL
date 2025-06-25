# git 명령어

`git init`
- initialize(초기화)
- 디렉토리를 새로운 Git 저장소로 초기화
- .git 폴더 생성
---
`git config --global user.email "<email@example.com>"`   
`git config --global user.name "<name>"`
- 유저 이메일/이름 설정
- 처음 한 번만 설정하면 됨
---
`git add <filename>`
1. Untracked --> Tracked (1번)
2. 파일을 스테이징 영역에 추가
---
`git add .`
- 현재 디렉토리와 하위 디렉토리의 모든 파일을 `add`
---
`git commit -m "<message>"`
- **(전제조건)** <u>스테이징된 파일들</u>을 커밋
- `-m` commit message
---
`git remote add origin <GitHub URL>`
- 로컬저장소와 원격저장소(origin)를 연결 
- `origin` 이 URL에 있는 저장소를 앞으로 origin이라는 이름으로 부를게
---
`git push <원격저장소> <브랜치>`   
`git push origin main`
- main branch의 commit을 origin에 업로드
---
`git clone <GitHub URL>`
- 원격저장소를 복제하여 로컬저장소로 가져옴
----
`git status`
- 현재 작업 디렉토리와 스테이징 영역의 상태 확인
---
`git log`
- 커밋 히스토리 조회