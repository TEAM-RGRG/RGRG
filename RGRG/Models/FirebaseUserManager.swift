//
//  FirebaseUserManager.swift
//  RGRG
//
//  Created by 이수현 on 10/24/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseUserManager {
    static let shared = FirebaseUserManager()
    static let db = Firestore.firestore()
    
    func getUserInfo (complition: @escaping ((User) -> Void)) {
        FirebaseUserManager.db.collection("users").document(Auth.auth().currentUser?.uid ?? "").getDocument { snapshot, error in
            if let error = error {
                print("Error : \(error)")
            } else {
                guard let snapshot = snapshot else {return}
                print("~~~~~~~~~~~~~~~~~\(snapshot.data())")
                if let data = snapshot.data(){
                
                    if let userName = data["userName"] as? String, let email = data["email"] as? String, let tier = data["tier"] as? String, let position = data["position"] as? String, let mostChampion = data["mostChampion"] as? [String], let profilePhoto = data["profilePhoto"] as? String {
                        let user = User(email: email, userName: userName, tier: tier, position: position)
                        complition(user)
                    }
                }
            }
        }
    }
}
