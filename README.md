## 🙆🏻‍♀️🙅🏻‍♂️ 프로젝트 설명 
🌟 

## 📌Coding Convention
## 1️⃣ **Class 이름**
플러터는 카멜케이스가 아니라 lowercase가 보편적이네요..! 아래에 예시 첨부해뒀습니다
**LowerCase**를 사용합니다.

- //this is the right method
  - user_data.dart (lower case for both words separated by underscore)
- //these methods should be avoided
  - userData.dart (camel case)
  - UserData.dart (upper case for both words)
  - Loginview.dart (upper case for first word)
  - Login_View.dart (upper case for both words separated by underscore)
 
  ## 3️⃣ **변수 및 상수 이름**

- 알아볼 수 있는 네이밍을 사용해주세요!
- **lowerCamelCase**를 사용합니다.
- 약어인 경우 CamelCase라고 하더라도 모두 대문자로 씀
  <details>
    <summary>대문자로만 쓰는 용어 모음</summary>
    <div>
    <br>
    - URL<br>
    - ID<br>
    - API<br>
    - 필요시 여기에 추가<br>
    </div>
    </details>
- myContentCollectionViewCell (O)
    
    myContentCVCell (x)

  ## 📌Commit Convention
- [Feat] : 새로운 기능 구현
- [Fix] : 버그, 오류 해결
- [Chore] : 코드 수정, 내부 파일 수정, 애매한 것들이나 잡일은 이걸로!
- [Add] : 라이브러리 추가, 에셋 추가
- [Del] : 쓸모없는 코드 삭제
- [Docs] : README나 WIKI 등의 문서 개정
- [Refactor] : 전면 수정이 있을 때 사용합니다
- [Setting] : 프로젝트 설정관련이 있을 때 사용합니다.
- [Merge] - {#이슈번호} Pull Develop

### Message

커밋 메시지 : `[종류/#이슈번호]작업 이름` - 예시 `[Feat/#1] 메인 UI 구현`

Conflict 해결 시 : `[Conflict/ #이슈] Conflict 해결`

PR을 develop에 merge 시 : 기본 머지 메시지

내 브랜치에 develop merge 시 (브랜치 최신화) : `[Merge/#이슈] Pull Develop` - `[Merge/#13] Pull Develop`
## 📌Issue Convention

### Branch

브랜치명 시작은 소문자로 한다.

default branch : `develop`

작업 branch : `커밋타입/이슈번호 - 작업뷰` - 예시 `feat/#12-MainView`

### Issue

이슈 이름 : `[종류] 작업 명` - 예시 `[Feat] Main View UI 구현`

담당자, 라벨 추가 꼭 하기


## 📂 Foldering Convention
![image](https://github.com/user-attachments/assets/0a1c75c7-a497-4d4c-914e-ff332cfd9ee6)


#### models
  - 앱에서 사용되는 데이터 모델
  - 데이터베이스와 데이터를 주고받기 위해 사용하는 파일들을 모아두는 폴더
#### screens
- 화면 UI에 대한 폴더, 해당 화면을 표현하는 코드들을 모아두는 곳
#### widgets
- 전체적으로 사용되는 위젯 AppBar등 여러 화면에서 이용되는 Widget들을 모아두는 공간
- screens폴더가 화면 전반을 담당한다면, widgets은 그 화면의 부분부분의 요소들 중 재사용되는 UI들을 모아둔 곳
#### utils
- 앱 전체적으로 사용되는 기능을 위한 것.
- 반복되는 logic이나 func 모아두는 공간
#### services
 - 이 폴더에는 API 호출, 데이터 저장소 또는 기타 서비스를 처리하기 위한 클래스가 포함
#### assets 폴더
- 안에 fonts, images, logo 등의 세부 폴더들이 위치할 수 있으며, 앱에서 사용할 asset들을 모아두는 폴더


