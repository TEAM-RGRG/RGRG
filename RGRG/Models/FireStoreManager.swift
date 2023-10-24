//
//  FireStoreManager.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/22/23.
//

import FirebaseFirestore
import Foundation

final class FireStoreManager {
    static let shared = FireStoreManager()
    static let db = Firestore.firestore()
    
    func loadChannels(collectionName: String, writerName: String, completion: @escaping (Channel) -> Void) {
        FireStoreManager.db.collection("channels")
            .whereField("writer", isEqualTo: "testUser1@naver.com")
            .addSnapshotListener { (querySnapshot, error) in
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        for doc in snapshotDocument {
                            let data = doc.data()
                            
                            if let writer = data["writer"] as? String, let channelTitle = data["channelTitle"] as? String, let requester = data["requester"] as? String {
                                let channel = Channel(channelName: channelTitle, requester: requester, writer: writer)
                                completion(channel)
                            }
                        }
                    }
                }
            }
    }
    
    func loadChatting(channelName: String, completion: @escaping (ChatInfo) -> Void) {
        FireStoreManager.db.collection(channelName)
            .whereField("writer", isEqualTo: "testUser1@naver.com")
            .addSnapshotListener { (querySnapshot, error) in
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        for doc in snapshotDocument {
                            let thread = doc.documentID
                            print("### doc's thread ::: \(thread)")
                            FireStoreManager.db.collection("channels/\(thread)/thread")
                                .addSnapshotListener { (querySnapshot, error) in
                                    if let e = error {
                                        print("There was an issue retrieving data from Firestore. \(e)")
                                        
                                    } else {
                                        if let snapshotDocument = querySnapshot?.documents {
                                            for doc in snapshotDocument {
                                                let data = doc.data()
                                                print("### \(data)")
                                                if let date = data["date"] as? Timestamp, let read = data["read"] as? Bool, let content = data["content"] as? String, let sender = data["sender"] as? String {
                                                    let item = ChatInfo(sender: sender, date: date, read: read, content: content)
                                                    print("### item ::: \(item)")
                                                    completion(item)
                                                }
                                            }
                                        }
                                    }
                                }
                        }
                    }
                }
            }
    }
}
