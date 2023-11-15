//
//  FirebaseUserManager.swift
//  RGRG
//
//  Created by 이수현 on 10/24/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class FirebaseUserManager {
    static let shared = FirebaseUserManager()
    static let db = Firestore.firestore()

    func getUserInfo(complition: @escaping ((User) -> Void)) {
        FirebaseUserManager.db.collection("users").document(Auth.auth().currentUser?.uid ?? "").getDocument { snapshot, error in
            if let error = error {
                print("Error : \(error)")
            } else {
                guard let snapshot = snapshot else { return }
                if let data = snapshot.data() {
                    if let userName = data["userName"] as? String, let email = data["email"] as? String, let tier = data["tier"] as? String, let position = data["position"] as? String, let mostChampion = data["mostChampion"] as? [String], let profilePhoto = data["profilePhoto"] as? String, let uid = data["uid"] as? String, let iBlocked = data["iBlocked"] as? [String], let youBlocked = data["youBlocked"] as? [String] {
                        let user = User(email: email, userName: userName, tier: tier, position: position, profilePhoto: profilePhoto, mostChampion: mostChampion, uid: uid, iBlocked: iBlocked, youBlocked: youBlocked)
                        complition(user)
                    }
                }
            }
        }
    }

    func updateUserInfo(userInfo: User) {
        let path = FirebaseUserManager.db.collection("users").document(Auth.auth().currentUser?.uid ?? "")
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
        FirebaseUserManager.db.collection("users").whereField("userName", isEqualTo: inputText).getDocuments { snapShot, error in
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

    func getUserInfo(searchUser: String, complition: @escaping ((User) -> Void)) {
        FirebaseUserManager.db
            .collection("users")
            .document(searchUser)
            .getDocument { snapshot, error in
                if let error = error {
                    print("Error : \(error)")
                } else {
                    guard let snapshot = snapshot else { return }
                    if let data = snapshot.data() {
                        if let userName = data["userName"] as? String, let email = data["email"] as? String, let tier = data["tier"] as? String, let position = data["position"] as? String, let mostChampion = data["mostChampion"] as? [String], let profilePhoto = data["profilePhoto"] as? String, let uid = data["uid"] as? String, let iBlocked = data["iBlocked"] as? [String], let youBlocked = data["youBlocked"] as? [String] {
                            let user = User(email: email, userName: userName, tier: tier, position: position, profilePhoto: profilePhoto, mostChampion: mostChampion, uid: uid, iBlocked: iBlocked, youBlocked: youBlocked)
                            complition(user)
                        }
                    }
                }
            }
    }
}
