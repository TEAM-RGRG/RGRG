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
    
    func blockUser(uid: String) {
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
    
    func unBlockUser(ind: Int) {
        let current = Auth.auth().currentUser?.uid
        let myPath = FirebaseUserManager.db.collection("users").document(current ?? "")
        var yourUid = ""
        
        
        var myBlock: [String] = []
        var yourBlock: [String] = []
        
        BlockManager.db.collection("users").document(current ?? "").getDocument { snapshot, error in
            if let error = error {
                print("Error : \(error)")
            } else {
                guard let snapshot = snapshot else { return }
                if let data = snapshot.data() {
                    myBlock = data["iBlocked"] as! [String]
                    yourUid = myBlock[ind]
                    
                    BlockManager.db.collection("users").document(yourUid).getDocument { snapshot, error in
                        let yourPath = FirebaseUserManager.db.collection("users").document(yourUid)
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
                    
                    myBlock.remove(at: ind)
                    myPath.updateData(["iBlocked": myBlock])
                }
            }
        }
        
        
    }

    func getBlockedUser(complition: @escaping ([String]) -> Void) {
        let current = Auth.auth().currentUser?.uid
        var blockList: [String] = []
        
        BlockManager.db.collection("users").document(Auth.auth().currentUser?.uid ?? "").getDocument { snapshot, error in
            if let error = error {
                print("Error : \(error)")
            } else {
                guard let snapshot = snapshot else { return }
                if let data = snapshot.data() {
                    blockList = data["iBlocked"] as! [String]
                    complition(blockList)
                }
            }
        }
    }
}
