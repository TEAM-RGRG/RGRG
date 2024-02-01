//
//  FBStoreManager.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/22/23.
//

import FirebaseFirestore
import Foundation

#warning("Todo-Stuff: Async/Await 로 교체 및 중복 코드 제거")
final class FBStoreManager {
    static let shared = FBStoreManager()
    static let db = Firestore.firestore()

    func loadWholeChannels() {
        Firestore.firestore().collection("channels")
            .order(by: "date", descending: true)
            .addSnapshotListener { querySnapshot, error in
                var channels: [ChannelInfo] = []
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        print("### snapshotDocument \(snapshotDocument)")
                        for doc in snapshotDocument {
                            let data = doc.data()
                            let thread = doc.documentID
                            let decoder = PropertyListDecoder()

                            if let host = data["host"] as? String, let channelTitle = data["channelTitle"] as? String, let guest = data["guest"] as? String, let channelID = data["channelID"] as? String, let currentMessage = data["currentMessage"] as? String, let guestProfile = data["guestProfile"] as? String, let hostProfile = data["hostProfile"] as? String, let hostSender = data["hostSender"] as? Bool, let guestSender = data["guestSender"] as? Bool {
                                let channel = ChannelInfo(channelName: channelTitle, guest: guest, host: host, channelID: thread, currentMessage: currentMessage, hostProfile: hostProfile, guestProfile: guestProfile, hostSender: hostSender, guestSender: guestSender)
                                channels.append(channel)
                            }
                        }
                    }
                }
            }
    }

    func loadChannels(collectionName: String, filter: String, completion: @escaping ([ChannelInfo], String) -> Void) {
        Firestore.firestore().collection("channels")
            .whereField("users", arrayContains: filter)
            .order(by: "date", descending: true)
            .addSnapshotListener { querySnapshot, error in
                var channels: [ChannelInfo] = []
                var channelID = ""

                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        querySnapshot?.documentChanges.forEach { change in

                            switch change.type {
                            case .added:
                                print("##### added")
                                print("##### indexNumber ||| \(change.newIndex)")
                                print("##### change ::: \(change.document.documentID)")
                                channelID = change.document.documentID
                            case .modified:
                                print("##### modified")
                                print("##### indexNumber ||| \(change.newIndex)")
                                print("##### change ::: \(change.document.documentID)")
                                channelID = change.document.documentID
                            case .removed:
                                print("##### removed")
                                print("##### indexNumber ||| \(change.newIndex)")
                                print("##### change ::: \(change.document.documentID)")
                                channelID = change.document.documentID
                            default:
                                print("##### change ::: \(change.document.documentID)")
                            }
//                            print("##### 222 ::: \(change.newIndex)")
                        }

                        print("### snapshotDocument \(snapshotDocument)")
                        for doc in snapshotDocument {
                            let data = doc.data()
                            let thread = doc.documentID

                            if let host = data["host"] as? String, let channelTitle = data["channelTitle"] as? String, let guest = data["guest"] as? String, let channelID = data["channelID"] as? String, let currentMessage = data["currentMessage"] as? String, let guestProfile = data["guestProfile"] as? String, let hostProfile = data["hostProfile"] as? String, let hostSender = data["hostSender"] as? Bool, let guestSender = data["guestSender"] as? Bool {
                                let channel = ChannelInfo(channelName: channelTitle, guest: guest, host: host, channelID: thread, currentMessage: currentMessage, hostProfile: hostProfile, guestProfile: guestProfile, hostSender: hostSender, guestSender: guestSender)
                                channels.append(channel)
                            }
                        }
                        completion(channels, channelID)
                    }
                }
            }
    }

    func loadChatting(channelName: String, thread: String, startIndex: Int, completion: @escaping ([ChatInfo]) -> Void) {
        FBStoreManager.db.collection("channels/\(thread)/thread")
            .order(by: "date", descending: false)
            .addSnapshotListener { querySnapshot, error in
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

    func addChannel(channelTitle: String, guest: String, host: String, channelID: String, date: String, users: [String], guestProfile: String, hostProfile: String, hostSender: Bool, guestSender: Bool, completion: @escaping (ChannelInfo) -> Void) {
        FBStoreManager.db
            .collection("channels")
            .addDocument(data: [
                "channelID": channelID,
                "date": date,
                "channelTitle": channelTitle,
                "guest": guest,
                "host": host,
                "users": users,
                "currentMessage": "",
                "guestProfile": guestProfile,
                "hostProfile": hostProfile,
                "hostSender": hostSender,
                "guestSender": guestSender
            ]) { error in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    let channel = ChannelInfo(channelName: channelTitle, guest: guest, host: host, channelID: channelID, currentMessage: "", hostProfile: hostProfile, guestProfile: guestProfile, hostSender: hostSender, guestSender: guestSender)
                    completion(channel)
                }
            }
            .collection("thread")
    }

    func addChat(thread: String, sender: String, date: String, read: Bool, content: String, completion: @escaping (ChatInfo) -> Void) {
        FBStoreManager.db.collection("channels/\(thread)/thread")
            .addDocument(data: [
                "sender": sender,
                "date": date,
                "read": read,
                "content": content
            ]) { error in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    let chat = ChatInfo(sender: sender, date: date, read: read, content: content)
                    completion(chat)
                }
            }
    }

    // 채팅방 들어갈 때
    func updateChannel(currentMessage: String, thread: String, sender: String, host: String, guest: String) {
        let path = FBStoreManager.db.collection("channels")
        path.document(thread).updateData(["currentMessage": currentMessage])

        if sender == host {
            path.document(thread).updateData(["guestSender": false])
        } else {
            path.document(thread).updateData(["hostSender": false])
        }
    }

    // 채팅 보낼 때
    func updateChannelSender(thread: String, sender: String, host: String, guest: String, date: String) {
        let path = FBStoreManager.db.collection("channels")

        if sender == host {
            path.document(thread).updateData(["hostSender": true])
        } else {
            path.document(thread).updateData(["guestSender": true])
        }
        path.document(thread).updateData(["date": date])
    }

    func updateReadChat(thread: String, currentUser: String) {
        let path = FBStoreManager.db.collection("channels/\(thread)/thread")
        let senderChatPath = FBStoreManager.db.collection("channels/\(thread)")
        FBStoreManager.db
            .collection("channels/\(thread)/thread")
            .whereField("sender", isNotEqualTo: currentUser)
            .getDocuments { querySnapshot, error in
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
        FBStoreManager.db.collection("channels")
            .document(thread).delete()
        completion()
    }
}

extension FBStoreManager {
    func dateFormatter(value: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let result = formatter.string(from: value)
        return result
    }
}

extension FBStoreManager {
    func updateChannelsStatus(completion: @escaping (Int) -> Void) {
        var indexNumber = 0
        Firestore.firestore().collection("channels")
            .addSnapshotListener { snapshot, _ in
                guard let snapshot = snapshot else { return }

                snapshot.documentChanges.forEach { change in

                    switch change.type {
                    case .added:
                        print("##### added")
                        completion(1)
                    case .modified:
                        print("##### modified")
                        completion(2)
                    case .removed:
                        print("##### removed")
                        completion(3)
                    }
                }
            }
    }
}
