//
//  FirebaseUpdateManager.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 11/5/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

#warning("Todo-Stuff: Async/Await 로 교체 및 중복 코드 제거")
class FBUpdateManager {
    static let shared = FBUpdateManager()
    static let db = Firestore.firestore()
}

// MARK: - Party Update

extension FBUpdateManager {
    func partyUserUpdate(user: UserInfo) {
        let current = Auth.auth().currentUser?.uid
        FBUpdateManager.db.collection("party")
            .whereField("writer", isEqualTo: current)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("### \(error)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        for doc in snapshotDocument {
                            var data = doc.data()
                            var docID = doc.documentID

                            if data["writer"] as? String == current {
                                // writer 와 이름이 같을 때
                                // ex)
                                FBUpdateManager.db.collection("party")
                                    .document(docID)
                                    .updateData(["userName": user.userName, "tier": user.tier, "profileImage": user.profilePhoto, "position": user.position, "champions": user.mostChampion])

                            } else {
                                // guest 와 이름이 같을 때 - 추후 구현 예정...?
                            }
                        }
                    }
                }
            }
    }

    func partyUserDelete() {
        let current = Auth.auth().currentUser?.uid
        FBUpdateManager.db.collection("party")
            .whereField("writer", isEqualTo: current)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("### \(error)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        for doc in snapshotDocument {
                            var data = doc.data()
                            var docID = doc.documentID

                            if data["writer"] as? String == current {
                                FBUpdateManager.db.collection("party").document(docID).delete()
                            }
                        }
                    }
                }
            }
    }
}

// MARK: - Chatting Update

extension FBUpdateManager {
    func channelsUserUpdate(updateProfile: String) {
        let current = Auth.auth().currentUser?.uid
        FBUpdateManager.db.collection("channels")
            .whereField("users", arrayContainsAny: [current])
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("### \(error)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        for doc in snapshotDocument {
                            var data = doc.data()
                            var docID = doc.documentID

                            if data["host"] as? String == current {
                                // 호스트랑 같을 때
                                FBUpdateManager.db.collection("channels")
                                    .document(docID)
                                    .updateData(["hostProfile": updateProfile])

                            } else {
                                // 게스트랑 같을 때
                                FBUpdateManager.db.collection("channels")
                                    .document(docID)
                                    .updateData(["guestProfile": updateProfile])
                            }
                        }
                    }
                }
            }
    }

    func channelsUserDelete() {
        let current = Auth.auth().currentUser?.uid
        FBUpdateManager.db.collection("channels")
            .whereField("users", arrayContainsAny: [current])
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("### \(error)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        for doc in snapshotDocument {
                            var data = doc.data()
                            var docID = doc.documentID

                            FBUpdateManager.db.collection("channels").document(docID).delete()
                        }
                    }
                }
            }
    }
}
