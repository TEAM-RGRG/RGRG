//
//  FBUserManager.swift
//  RGRG
//
//  Created by 이수현 on 10/24/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

#warning("Todo-Stuff: Async/Await 로 교체 및 중복 코드 제거")
class FBUserManager {
    static let shared = FBUserManager()
    static let db = Firestore.firestore()

    func getUserInfo(complition: @escaping ((UserInfo) -> Void)) {
        FBUserManager.db.collection("users").document(Auth.auth().currentUser?.uid ?? "").getDocument { snapshot, error in
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

    func checkUserNameRepeat(inputText: String, completion: @escaping (Bool) -> Void) {
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

    func getUserInfo(searchUser: String, complition: @escaping ((UserInfo) -> Void)) {
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
