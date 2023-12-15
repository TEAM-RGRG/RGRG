# RGRG: Reliable Gamers, Ready to Game

<img width="1372" alt="AppStoreImage" src="https://github.com/NBCAMP-FINAL-TEAM12/RGRG/assets/100465645/c290e3dc-2b80-4b3d-8a33-17f6f49b054b">

## 1. 기획

E스포츠의 대중화와 영상플랫폼의 발전으로 게임 인구가 늘어나고 있습니다.

한편 특정 인원이 모여야 플레이를 시작할 수 있는 몇몇 게임이 있는데요.

파티원을 모집 할 수 있는 플랫폼이 필요하다고 생각했습니다.

특히, 리그오브레전드의 경우 한국 사용자만 1000만명에 달한다는 점을 고려했을 때 

수요가 충분하고, 유저들의 니즈 또한 충족할 수 있는 서비스이라고 여겨서 기획하였습니다.

## 2. App 간단 소개
랜덤으로 매칭되는 롤, 더 이상 트롤로 고통받고 싶지 않은 분들을 위한 서비스를 만들었습니다.

이제 RGRG를 통해서 함께 게임할 파티원을 찾아보세요

## 3. Time frame & Developer
2023.10.10 - 2023.11.17 (6주간)
<table>
  <tbody>
    <tr>
    <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/jakkujakku">
       <img src="https://avatars.githubusercontent.com/u/89556301?v=4" width="100px;" alt="김준우"/>
       <br />
         <sub>
           <b>김준우</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
     <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/suzzang98">
       <img src="https://avatars.githubusercontent.com/u/114126053?v=4" width="100px;" alt="이수현"/>
       <br />
         <sub>
           <b>이수현</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
      <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/kiakim01">
       <img src="https://avatars.githubusercontent.com/u/100465645?v=4" width="100px;" alt="김귀아"/>
       <br />
         <sub>
           <b>김귀아</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
      <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/startingg">
       <img src="https://avatars.githubusercontent.com/u/132072642?v=4" width="100px;" alt="이시영"/>
       <br />
         <sub>
           <b>이시영</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
  </tbody>
</table>

## 4. Development environment and Libraries
<div> <img src="https://img.shields.io/badge/ UIKit - iOS -lightgrey.svg?{ style(optional) }" />
<img src="https://img.shields.io/badge/ Xcode - 15.0.1 -0099E5.svg?{ style(optional) }" />
<img src="https://img.shields.io/badge/ Swift - 5.9 -success.svg?{ style(optional) }" />
<img src="https://img.shields.io/badge/ iOS -  16.0 -orange.svg?{ style(optional) }" /></div>

|라이브러리|사용 목적|버전|
|:-:|:-:|:-:|
|Firebase|사용자 정보 관리|10.16.0|
|SnapKit|오토레이아웃|5.6.0|
|Then|짧은 코드 처리|3.0.0|



## 5. 주요 기능

### 1. 파티 모집 기능

다양한 티어, 다양한 포지션의 사람들이 쓴 글을 한번에 모아보세요!

원하는 티어와 포지션의 사람들을 필터링해서 내가 찾는 RG친구를 구할 수 있습니다.

상대방의 선호 챔피언이나, 상대방이 희망하는 포지션을 보고 내가 원하는 RG친구를 찾아보세요.

### 2. 쪽지 기능

내가 원하는 친구를 찾았나요? 쪽지를 보내보세요!

RG친구와 대화를 나누고, 게임 약속을 잡을 수 있습니다.

### 3. 신고하기 기능

비매너 유저가 있다면, 빠른 신고를 해 주세요!

RGRG는 신뢰할 수 있는 사람들과 게임을 할 수 있는 서비스를 제공합니다.

빠른 피드백은 더 신뢰할 수 있는 사람들과 게임할 수 있도록 만들어줄 수 있습니다!
<br>

## 6. 역할분담
* 김준우 : 채팅 기능
* 이수현 : 프로필 수정 기능
* 김귀아 : 로그인 / 회원가입 기능
* 이시영 : 파티 매칭 리스트 / 파티 매칭 상세 기능

## 7. File Structures
```
RGRG
├── Models
│   ├── BlockManager.swift
│   ├── Channel.swift
│   ├── ChatInfo.swift
│   ├── FirebaseStorageManager.swift
│   ├── FirebaseStoreManager.swift
│   ├── FirebaseUpdateManager.swift
│   ├── FirebaseUserManager.swift
│   ├── PartyInfo.swift
│   ├── PartyManager.swift
│   └── UserInfo.swift
├── Scenes
│   ├── ChatDetail
│   │   ├── ChatAlertCell.swift
│   │   ├── ChatDetailViewController.swift
│   │   ├── ChatSetting
│   │   ├── MyFeedCell.swift
│   │   └── YourFeedCell.swift
│   ├── ChatList
│   │   ├── ChatListCell.swift
│   │   └── ChatListViewController.swift
│   ├── EditProfile
│   │   ├── Cell
│   │   ├── ChooseChampViewController.swift
│   │   ├── ChooseIconViewController.swift
│   │   └── EditProfileViewController.swift
│   ├── Login
│   │   ├── CtaLageButton.swift
│   │   ├── CustomMemberInfoBox.swift
│   │   └── LoginViewController.swift
│   ├── Main
│   │   ├── Cell
│   │   ├── CreatePartyPageVC.swift
│   │   ├── MainViewController.swift
│   │   ├── NoticePageVC.swift
│   │   ├── PartyInfoDetailVC.swift
│   │   └── SearchOptionViewController.swift
│   ├── Notification
│   │   └── NotificationViewController.swift
│   ├── Profile
│   │   ├── PartyInfoIWroteViewController.swift
│   │   └── ProfileViewController.swift
│   ├── Setting
│   │   ├── BlockSettingViewController.swift
│   │   ├── Cell
│   │   ├── DeveloperInfoViewController.swift
│   │   ├── ReportViewController.swift
│   │   └── SettingViewController.swift
│   ├── SignUp
│   │   ├── PersonalInfoViewController.swift
│   │   ├── SignUpViewController.swift
│   │   └── resetPassword.swift
│   └── Tabbar
│       └── TabBarController.swift
└── View
    └── Subcomponents
        ├── CustomBackButton.swift
        ├── CustomBarButton.swift
        ├── CustomButton.swift
        ├── CustomImageView.swift
        ├── CustomLabel.swift
        ├── CustomStackView.swift
        ├── CustomTableView.swift
        ├── CustomTextField.swift
        └── CustomTextView.swift
```
## Team Notion Link 🔗

- [TEAM S.A][https://www.notion.so/RGRG-abe9675b6e1c4803a78647d0bbeff8f7]
