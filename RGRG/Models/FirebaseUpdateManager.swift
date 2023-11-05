//
//  FirebaseUpdateManager.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 11/5/23.
//

import FirebaseFirestore
import Foundation

class FirebaseUpdateManager {
    /*
     프로필 수정시, 변경되어야할 부분들 --> 유저 uid 이용
     1. 파티의 유저 데이터
     2. 채팅 유저 데이터 ✅
     */

    static let shared = FirebaseUpdateManager()
    static let db = Firestore.firestore()
}

// MARK: - Party Update

extension FirebaseUpdateManager {
    func partyUserUpdate(writerName: String, updateName: String, tier: String, updateProfile: String, updateMyPosition: String, updateHopePosition: [String], updateChampions: [String]) {
        FirebaseUpdateManager.db.collection("party")
            .whereField("writer", isEqualTo: writerName)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("### \(error)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        for doc in snapshotDocument {
                            var data = doc.data()
                            var docID = doc.documentID

                            if data["writer"] as? String == writerName {
                                // writer 와 이름이 같을 때
                                // ex)
                                FirebaseUpdateManager.db.collection("party")
                                    .document(docID)
                                    .updateData(["writer": updateName, "userName": updateName, "tier": tier, "profileImage": updateProfile, "position": updateMyPosition, "hopePosition": updateHopePosition, "champions": updateHopePosition])
                            } else {
                                // guest 와 이름이 같을 때 - 추후 구현 예정...?
                            }
                        }
                    }
                }
            }
    }
}

// MARK: - Chatting Update

extension FirebaseUpdateManager {
    func channelsUserUpdate(filterName myUserName: String, updateName: String, updateProfile: String) {
        FirebaseUpdateManager.db.collection("channels")
            .whereField("users", arrayContainsAny: [myUserName])
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("### \(error)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        for doc in snapshotDocument {
                            var data = doc.data()
                            var docID = doc.documentID

                            if data["host"] as? String == myUserName {
                                // 호스트랑 같을 때
                                FirebaseUpdateManager.db.collection("channels")
                                    .document(docID)
                                    .updateData(["host": updateName, "hostProfile": updateProfile])

                            } else {
                                // 게스트랑 같을 때
                                FirebaseUpdateManager.db.collection("channels")
                                    .document(docID)
                                    .updateData(["guest": updateName, "guestProfile": updateProfile])
                            }
                        }
                    }
                }
            }
    }
}
