//
//  FBUserManager.swift
//  RGRG
//
//  Created by 이수현 on 10/24/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

/// FB DB 에서 발생하는 Error 모음
enum UserDBError: Error {
    case userNotFound
    case dataNotFound
    case invalidDataFormat
    case documentDoesNotExist
}

class FBUserManager {
    static let shared = FBUserManager()
    static let db = Firestore.firestore()

    /// 유저 호출
    /// - Returns: FB DB에서 CurrentUser 와 일치하는 User 데이터
    func requestUserInfo() async throws -> UserInfo {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw UserDBError.userNotFound
        }

        let snapshot = try await FBUserManager.db.collection("users").document(userId).getDocument()

        guard let data = snapshot.data() else {
            throw UserDBError.dataNotFound
        }

        guard let userName = data["userName"] as? String,
              let email = data["email"] as? String,
              let tier = data["tier"] as? String,
              let position = data["position"] as? String,
              let mostChampion = data["mostChampion"] as? [String],
              let profilePhoto = data["profilePhoto"] as? String,
              let uid = data["uid"] as? String,
              let iBlocked = data["iBlocked"] as? [String],
              let youBlocked = data["youBlocked"] as? [String]
        else {
            throw UserDBError.invalidDataFormat
        }

        return UserInfo(email: email, userName: userName, tier: tier, position: position, profilePhoto: profilePhoto, mostChampion: mostChampion, uid: uid, iBlocked: iBlocked, youBlocked: youBlocked)
    }

    func getUserInfo(complition: @escaping ((UserInfo) -> Void)) {
        FBUserManager.db.collection("users").document(Auth.auth().currentUser?.uid ?? "").getDocument { snapshot, error in
            if let error = error {
                print("Error : \(error)")
            } else {
                guard let snapshot = snapshot else { return }
                if let data = snapshot.data() {
                    if let userName = data["userName"] as? String,
                       let email = data["email"] as? String,
                       let tier = data["tier"] as? String,
                       let position = data["position"] as? String,
                       let mostChampion = data["mostChampion"] as? [String],
                       let profilePhoto = data["profilePhoto"] as? String,
                       let uid = data["uid"] as? String,
                       let iBlocked = data["iBlocked"] as? [String],
                       let youBlocked = data["youBlocked"] as? [String]
                    {
                        let user = UserInfo(email: email, userName: userName, tier: tier, position: position, profilePhoto: profilePhoto, mostChampion: mostChampion, uid: uid, iBlocked: iBlocked, youBlocked: youBlocked)
                        complition(user)
                    }
                }
            }
        }
    }

    /// 유저 업데이트
    /// - Parameter userInfo: 현재 로그인한 UserInfo 데이터
    func updateUserInfo(userInfo: UserInfo) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw UserDBError.userNotFound
        }

        let path = FBUserManager.db.collection("users").document(userId)
        let document = try await path.getDocument()

        guard document.exists else {
            throw UserDBError.documentDoesNotExist
        }

        do {
            try await path.updateData([
                "profilePhoto": userInfo.profilePhoto,
                "userName": userInfo.userName,
                "position": userInfo.position,
                "tier": userInfo.tier,
                "mostChampion": userInfo.mostChampion
            ])
        } catch {
            print("#### User Update 실패 : \(error)")
        }
    }

    func updateUserInfo(userInfo: UserInfo) {
        let path = FBUserManager.db.collection("users").document(Auth.auth().currentUser?.uid ?? "")
        path.getDocument { snapshot, error in
            if let error = error {
                print("Error : \(error)")
            } else {
                guard let snapshot = snapshot else { return }
                if let data = snapshot.data() {
                    path.updateData(["profilePhoto": userInfo.profilePhoto])
                    path.updateData(["userName": userInfo.userName])
                    path.updateData(["position": userInfo.position])
                    path.updateData(["tier": userInfo.tier])
                    path.updateData(["mostChampion": userInfo.mostChampion])
                }
            }
        }
    }

    /// 닉네임 중복성 검사
    /// - Parameter inputText: 바꾸고 싶은 닉네임
    /// - Returns: 중복성 여부 검사 결과 Bool 값
    func checkExistUserName(inputText: String) async throws -> Bool {
        do {
            let snapshot = try await FBUserManager.db.collection("users").whereField("userName", isEqualTo: inputText).getDocuments()
            return !snapshot.isEmpty
        } catch {
            print("오류 발생: \(error.localizedDescription)")
            throw error // 오류를 호출자에게 전파합니다.
        }
    }

    func checkExistUserName(inputText: String, completion: @escaping (Bool) -> Void) {
        var boolean = false
        FBUserManager.db.collection("users").whereField("userName", isEqualTo: inputText).getDocuments { snapShot, error in
            if let error = error {
                print("오류 발생: \(error.localizedDescription)")
            } else {
                if snapShot?.isEmpty == false {
                    completion(true)
                }
            }
        }
        completion(false)
    }

    /// 유저명을 입력하여 유저 데이터 불러오는 메서드
    /// - Parameter searchUser: 채팅 리스트의 uid 를 사용하여 FB UserDB에서 User 를 검색
    /// - Returns: 검색된 UserInfo 값을 반환
    func requestUserInfo(searchUser: String) async throws -> UserInfo {
        let document = FBUserManager.db.collection("users").document(searchUser)
        let snapshot = try await document.getDocument()

        guard let data = snapshot.data() else {
            throw UserDBError.dataNotFound // CustomError는 사용자 정의 에러 타입입니다. 필요에 따라 정의해주세요.
        }

        guard let userName = data["userName"] as? String,
              let email = data["email"] as? String,
              let tier = data["tier"] as? String,
              let position = data["position"] as? String,
              let mostChampion = data["mostChampion"] as? [String],
              let profilePhoto = data["profilePhoto"] as? String,
              let uid = data["uid"] as? String,
              let iBlocked = data["iBlocked"] as? [String],
              let youBlocked = data["youBlocked"] as? [String]
        else {
            throw UserDBError.invalidDataFormat // CustomError는 사용자 정의 에러 타입입니다. 필요에 따라 정의해주세요.
        }

        return UserInfo(email: email, userName: userName, tier: tier, position: position, profilePhoto: profilePhoto, mostChampion: mostChampion, uid: uid, iBlocked: iBlocked, youBlocked: youBlocked)
    }

    func requestUserInfo(searchUser: String, complition: @escaping ((UserInfo) -> Void)) {
        FBUserManager.db
            .collection("users")
            .document(searchUser)
            .getDocument { snapshot, error in
                if let error = error {
                    print("Error : \(error)")
                } else {
                    guard let snapshot = snapshot else { return }
                    if let data = snapshot.data() {
                        if let userName = data["userName"] as? String, let email = data["email"] as? String, let tier = data["tier"] as? String, let position = data["position"] as? String, let mostChampion = data["mostChampion"] as? [String], let profilePhoto = data["profilePhoto"] as? String, let uid = data["uid"] as? String, let iBlocked = data["iBlocked"] as? [String], let youBlocked = data["youBlocked"] as? [String] {
                            let user = UserInfo(email: email, userName: userName, tier: tier, position: position, profilePhoto: profilePhoto, mostChampion: mostChampion, uid: uid, iBlocked: iBlocked, youBlocked: youBlocked)
                            complition(user)
                        }
                    }
                }
            }
    }
}
