//
//  BlockManager.swift
//  RGRG
//
//  Created by 이수현 on 11/14/23.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class BlockManager {
    static let shared = BlockManager()
    static let db = Firestore.firestore()
    
    func blockUser(uid: String, complition: @escaping ((User) -> Void)) {
        let myPath = FirebaseUserManager.db.collection("users").document(Auth.auth().currentUser?.uid ?? "")
        let yourPath = FirebaseUserManager.db.collection("users").document(uid)
        
        var myBlock: [String] = []
        var yourBlock: [String] = []
        
        BlockManager.db.collection("users").document(Auth.auth().currentUser?.uid ?? "").getDocument { snapshot, error in
            if let error = error {
                print("Error : \(error)")
            } else {
                guard let snapshot = snapshot else { return }
                if let data = snapshot.data() {
                    myBlock = data["iBlocked"] as! [String]
                    myBlock.append(uid)
                    myPath.updateData(["iBlocked": myBlock])
                }
            }
        }
        BlockManager.db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Error : \(error)")
            } else {
                guard let snapshot = snapshot else { return }
                if let data = snapshot.data() {
                    yourBlock = data["youBlocked"] as! [String]
                    yourBlock.append(Auth.auth().currentUser?.uid ?? "")
                    yourPath.updateData(["youBlocked": yourBlock])
                }
            }
        }
    }
    
    func unBlockUser(uid: String, complition: @escaping ((User) -> Void)) {
        let current = Auth.auth().currentUser?.uid
        let myPath = FirebaseUserManager.db.collection("users").document(current ?? "")
        let yourPath = FirebaseUserManager.db.collection("users").document(uid)
        
        
        var myBlock: [String] = []
        var yourBlock: [String] = []
        
        BlockManager.db.collection("users").document(current ?? "").getDocument { snapshot, error in
            if let error = error {
                print("Error : \(error)")
            } else {
                guard let snapshot = snapshot else { return }
                if let data = snapshot.data() {
                    myBlock = data["iBlocked"] as! [String]
                    let index = myBlock.firstIndex(of: uid)
                    myBlock.remove(at: index ?? 0)
                    myPath.updateData(["iBlocked": myBlock])
                }
            }
        }
        
        BlockManager.db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Error : \(error)")
            } else {
                guard let snapshot = snapshot else { return }
                if let data = snapshot.data() {
                    yourBlock = data["youBlocked"] as! [String]
                    let index = yourBlock.firstIndex(of: current ?? "")
                    yourBlock.remove(at: index ?? 0)
                    yourPath.updateData(["youBlocked": yourBlock])
                }
            }
        }
    }
}
