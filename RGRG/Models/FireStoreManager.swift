//
//  FireStoreManager.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/22/23.
//

import FirebaseFirestore
import Foundation

// 콜렉션 속 하위 콜렉션 생성
// 문서 id -> 채널 id 같을 수 있도록 생성

final class FireStoreManager {
    static let shared = FireStoreManager()
    static let db = Firestore.firestore()

    func loadChannels(collectionName: String, writerName: String, filter: String, completion: @escaping ([Channel]) -> Void) {
        FireStoreManager.db.collection("channels")
            .whereField("users", arrayContains: filter)
            .addSnapshotListener { (querySnapshot, error) in
                var channels: [Channel] = []
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        print("### snapshotDocument \(snapshotDocument)")
                        for doc in snapshotDocument {
                            let data = doc.data()
                            let thread = doc.documentID
                            if let writer = data["writer"] as? String, let channelTitle = data["channelTitle"] as? String, let requester = data["requester"] as? String, let channelID = data["channelID"] as? String {
                                let channel = Channel(channelName: channelTitle, requester: requester, writer: writer, channelID: thread)
                                channels.append(channel)
                            }
                        }
                        completion(channels)
                    }
                }
            }
    }

    func loadChatting(channelName: String, thread: String, startIndex: Int, completion: @escaping ([ChatInfo]) -> Void) {
        FireStoreManager.db.collection("channels/\(thread)/thread")
            .order(by: "date", descending: false)
            
            .addSnapshotListener { (querySnapshot, error) in
                var messages: [ChatInfo] = []
                print("&&& FireStoreIndex::: \(startIndex)")
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")

                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        for doc in snapshotDocument {
                            let data = doc.data()
                            print("&&& \(data)")

                            if let date = data["date"] as? String, let read = data["read"] as? Bool, let content = data["content"] as? String, let sender = data["sender"] as? String {
                                let item = ChatInfo(sender: sender, date: date, read: read, content: content)
                                messages.append(item)
                                print("### messages:::: \(messages)")
                            }
                        }
                        completion(messages)
                    }
                }
            }
    }

    func addChannel(channelTitle: String, requester: String, writer: String, channelID: String, date: String, users: [String], completion: @escaping (Channel) -> Void) {
        FireStoreManager.db
            .collection("channels")
            .addDocument(data: [
                "channelID": channelID,
                "date": date,
                "channelTitle": channelTitle,
                "requester": requester,
                "writer": writer,
                "users": users
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    let channel = Channel(channelName: channelTitle, requester: requester, writer: writer, channelID: channelID)
                    completion(channel)
                }
            }
            .collection("thread")
    }

    func addChat(thread: String, sender: String, date: String, read: Bool, content: String, completion: @escaping (ChatInfo) -> Void) {
        FireStoreManager.db.collection("channels/\(thread)/thread")
            .addDocument(data: [
                "sender": sender,
                "date": date,
                "read": read,
                "content": content
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    let chat = ChatInfo(sender: sender, date: date, read: read, content: content)
                    completion(chat)
                }
            }
    }
}

extension FireStoreManager {
    func dateFormatter(value: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let result = formatter.string(from: value)
        return result
    }
}
