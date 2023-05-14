# Mogakco
> 📝 · 위치 기반 스터디 매칭 서비스(Service Level Project)  
> 📅 · 2022.11.07 ~ 2022.12.07

<img width="1002" alt="오오투두_스크린샷" src="https://github.com/Taehyeon-Kim/Mogakco/assets/61109660/a898f8eb-f727-4a7d-9891-bddee06acc8c">

## Summary
#### ▪️ 위치 및 지도 기반 스터디 매칭
#### ▪️ 스터디 찾기, 요청, 수락
#### ▪️ 매칭된 스터디원과 채팅
#### ▪️ 프로필 배경 및 스터디 아이콘 인앱 결제

<br />

## Main works
- Web Socket과 Realm을 이용한 채팅 기능 구현
- Firebase를 이용한 전화번호 문자 인증 구현
- 코드 기반 재사용 가능한 커스텀 UI 구현

## MISC
- MapKit, CLLocation Framework 기반 지도 및 위치 기능 구현
- RxSwift를 활용한 반응형 프로그래밍 구현
- MVVM + Clean Architecture 학습 및 적용
- GitHub Actions를 이용한 CI 구축
- URLSession을 이용한 Network Layer 추상화
- Firebase SDK, Apple Framework를 이용한 Remote Push Notification 구현

<br />

## Tech spec
- 구조 : UIKit, Code-based, MVC + MVVM, Clean Architecture
- 네트워킹 : URLSession
- 지도 : CLLocation, MapKit
- 인증 : Firebase Authetication
- 데이터베이스 : Realm
- 비동기 처리 : RxSwift, RxCocoa
- User Interface : SnapKit, AutoLayout
- 협업 : Confluence, Swagger, Figma, Notion

<br />

## Feedback
- 제한된 시간 내에 서비스 레벨 규모의 프로덕트를 혼자서 개발해보고, 코드 자체의 퀄리티 그리고 소프트웨어 아키텍처의 필요성에 대한 고민을 많이 해볼 수 있는 프로젝트였습니다.
- URLSession을 가지고 Network Layer를 직접 추상화해보면서 네트워크 라이브러리인 Alamofire, Moya를 내부 구현에 대해 이해해볼 수 있었습니다. 또한 네트워크 통신 라이브러리를 사용할 때와 하지 않을 때의 장단점을 비교해볼 수 있었습니다. 이후 네트워크 통신 라이브러리 선택에 대한 기준점을 세울 수 있게 되었습니다.
- 혼자서는 구현해보기 어려운 Socket, In-App Purchase를 활용한 기능에 대한 비즈니스 로직을 생각해보고 직접 구현해볼 수 있는 기회였습니다. 비슷한 기능을 구현하게 된다면 접근을 조금 더 쉽게 할 수 있을 것 같습니다.
