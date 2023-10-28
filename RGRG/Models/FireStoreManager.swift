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

                            if let writer = data["writer"] as? String, let channelTitle = data["channelTitle"] as? String, let requester = data["requester"] as? String, let channelID = data["channelID"] as? String, let currentMessage = data["currentMessage"] as? String, let requesterProfile = data["requesterProfile"] as? String, let writerProfile = data["writerProfile"] as? String {
                                let channel = Channel(channelName: channelTitle, requester: requester, writer: writer, channelID: thread, currentMessage: currentMessage, writerProfile: writerProfile, requesterProfile: requesterProfile)
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
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")

                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        for doc in snapshotDocument {
                            let data = doc.data()

                            if let date = data["date"] as? String, let read = data["read"] as? Bool, let content = data["content"] as? String, let sender = data["sender"] as? String {
                                let item = ChatInfo(sender: sender, date: date, read: read, content: content)
                                messages.append(item)
                            }
                        }
                        completion(messages)
                    }
                }
            }
    }

    func addChannel(channelTitle: String, requester: String, writer: String, channelID: String, date: String, users: [String], requesterProfile: String, writerProfile: String, completion: @escaping (Channel) -> Void) {
        FireStoreManager.db
            .collection("channels")
            .addDocument(data: [
                "channelID": channelID,
                "date": date,
                "channelTitle": channelTitle,
                "requester": requester,
                "writer": writer,
                "users": users,
                "currentMessage": "",
                "requesterProfile": requesterProfile,
                "writerProfile": writerProfile
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    let channel = Channel(channelName: channelTitle, requester: requester, writer: writer, channelID: channelID, currentMessage: "", writerProfile: writerProfile, requesterProfile: requesterProfile)
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

    func updateChannel(currentMessage: String, thread: String) {
        let path = FireStoreManager.db.collection("channels")
        path.document(thread).updateData(["currentMessage": currentMessage])
    }

    func updateReadChat(thread: String, currentUser: String) {
        let path = FireStoreManager.db.collection("channels/\(thread)/thread")
        FireStoreManager.db
            .collection("channels/\(thread)/thread")
            .whereField("sender", isNotEqualTo: currentUser)
            .getDocuments { (querySnapshot, error) in
                var temp: [String] = []
                if let error = error {
                    print("### \(error)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        for doc in snapshotDocument {
                            let data = doc.data()
                            let docID = doc.documentID
                            guard let item = data["sender"] as? String else { return }

                            if item != currentUser {
                                path.document(docID).updateData(["read": true])
                            }
                        }
                    }
                }
            }
    }

    func deleteChannel(thread: String, completion: @escaping () -> Void) {
        FireStoreManager.db.collection("channels")
            .document(thread).delete()
        completion()
    }
}

extension FireStoreManager {
    func dateFormatter(value: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let result = formatter.string(from: value)
        return result
    }
}
