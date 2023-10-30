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
                    if let userName = data["userName"] as? String, let email = data["email"] as? String, let tier = data["tier"] as? String, let position = data["position"] as? String, let mostChampion = data["mostChampion"] as? [String], let profilePhoto = data["profilePhoto"] as? String {
                        let user = User(email: email, userName: userName, tier: tier, position: position, profilePhoto: profilePhoto, mostChampion: mostChampion)
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
}
