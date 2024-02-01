//
//  PartyManager.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/27/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

#warning("Todo-Stuff: Async/Await 로 교체 및 중복 코드 제거")
class FBPartyManager {
    static let shared = FBPartyManager()
    static let db = Firestore.firestore()
    func updateParty(tier: [String], position: [String], iBlocked: [String], youBlocked: [String], completion: @escaping ([PartyInfo]) -> Void) {
        var partyList: [PartyInfo] = []
        var currentUser: UserInfo?
        
        FBPartyManager.db.collection("party")
            .whereField("tier", in: tier)
            .whereField("position", in: position)
            .order(by: "date", descending: true)
            .addSnapshotListener { querySnapshot, error in
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        print("### snapshotDocument \(snapshotDocument)")
                        for doc in snapshotDocument {
                            let data = doc.data()
                            let thread = doc.documentID
                            
                            if let champions = data["champions"] as? [String], let content = data["content"] as? String, let date = data["date"] as? String, let hopePosition = data["hopePosition"] as? [String], let profileImage = data["profileImage"] as? String, let tier = data["tier"] as? String, let title = data["title"] as? String, let userName = data["userName"] as? String, let writer = data["writer"] as? String, let position = data["position"] as? String {
                                if let champions = data["champions"] as? [String], let content = data["content"] as? String, let date = data["date"] as? String, let hopePosition = data["hopePosition"] as? [String], let profileImage = data["profileImage"] as? String, let tier = data["tier"] as? String, let title = data["title"] as? String, let userName = data["userName"] as? String, let writer = data["writer"] as? String, let position = data["position"] as? String {
                                    let party = PartyInfo(champion: champions, content: content, date: date, hopePosition: hopePosition, profileImage: profileImage, tier: tier, title: title, userName: userName, writer: writer, position: position, thread: thread)
                                    
                                    if !iBlocked.contains(party.writer), !youBlocked.contains(writer) {
                                        partyList.append(party)
                                    }
                                }
                            }
                            completion(partyList)
                        }
                    }
                }
            }
    }
        
    func loadParty(iBlocked: [String], youBlocked: [String], completion: @escaping ([PartyInfo]) -> Void) {
        var partyList: [PartyInfo] = []

        FBPartyManager.db.collection("party")
            .order(by: "date", descending: true)
            .addSnapshotListener { querySnapshot, error in
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        print("### snapshotDocument \(snapshotDocument)")
                        
                        for doc in snapshotDocument {
                            let data = doc.data()
                            let thread = doc.documentID
                                
                            if let champions = data["champions"] as? [String], let content = data["content"] as? String, let date = data["date"] as? String, let hopePosition = data["hopePosition"] as? [String], let profileImage = data["profileImage"] as? String, let tier = data["tier"] as? String, let title = data["title"] as? String, let userName = data["userName"] as? String, let writer = data["writer"] as? String, let position = data["position"] as? String {
                                let party = PartyInfo(champion: champions, content: content, date: date, hopePosition: hopePosition, profileImage: profileImage, tier: tier, title: title, userName: userName, writer: writer, position: position, thread: thread)
                                
                                if !iBlocked.contains(party.writer), !youBlocked.contains(writer) {
                                    partyList.append(party)
                                }
                            }
                        }
                        completion(partyList)
                    }
                }
            }
    }
        
    func loadMyParty(completion: @escaping ([PartyInfo]) -> Void) {
        var partyList: [PartyInfo] = []
        let current = Auth.auth().currentUser?.uid
        FBPartyManager.db.collection("party")
            .whereField("writer", isEqualTo: current)
            .order(by: "date", descending: true)
            .addSnapshotListener { querySnapshot, error in
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocument = querySnapshot?.documents {
                        print("### snapshotDocument \(snapshotDocument)")
                        for doc in snapshotDocument {
                            let data = doc.data()
                            let thread = doc.documentID
                                
                            if let champions = data["champions"] as? [String], let content = data["content"] as? String, let date = data["date"] as? String, let hopePosition = data["hopePosition"] as? [String], let profileImage = data["profileImage"] as? String, let tier = data["tier"] as? String, let title = data["title"] as? String, let userName = data["userName"] as? String, let writer = data["writer"] as? String, let position = data["position"] as? String {
                                let party = PartyInfo(champion: champions, content: content, date: date, hopePosition: hopePosition, profileImage: profileImage, tier: tier, title: title, userName: userName, writer: writer, position: position, thread: thread)
                                    
                                partyList.append(party)
                            }
                        }
                        completion(partyList)
                    }
                }
            }
    }
        
    func addParty(party: PartyInfo, completion: @escaping (PartyInfo) -> Void) {
        let current = Auth.auth().currentUser?.uid
        FBPartyManager.db.collection("party")
            .addDocument(data: [
                "champions": party.champion,
                "content": party.content,
                "date": party.date,
                "hopePosition": party.hopePosition,
                "profileImage": party.profileImage,
                "tier": party.tier,
                "title": party.title,
                "userName": party.userName,
                "writer": current,
                "requester": party.requester,
                "position": party.position
            ]) { error in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    let party = PartyInfo(champion: party.champion, content: party.content, date: party.date, hopePosition: party.hopePosition, profileImage: party.profileImage, tier: party.tier, title: party.title, userName: party.userName, writer: party.writer, position: party.position)
                    completion(party)
                }
            }
    }
        
    func updateParty(party: PartyInfo, thread: String, completion: @escaping (PartyInfo) -> Void) {
        let path = FBPartyManager.db.collection("party")
        let current = Auth.auth().currentUser?.uid
        path.document(thread)
            .updateData(["champions": party.champion,
                         "content": party.content,
                         "date": party.date,
                         "hopePosition": party.hopePosition,
                         "profileImage": party.profileImage,
                         "tier": party.tier,
                         "title": party.title,
                         "userName": party.userName,
                         "writer": current,
                         "requester": party.requester,
                         "position": party.position])
        completion(party)
    }
        
    func deleteParty(thread: String, completion: @escaping () -> Void) {
        let path = FBPartyManager.db.collection("party")
        path
            .document(thread)
            .delete()
        completion()
    }
}
    
extension FBPartyManager {
    func dateFormatter(strDate: String) -> String {
        let strDateFormatter = DateFormatter()
        strDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        strDateFormatter.timeZone = TimeZone(identifier: "UTC")
        guard var date = strDateFormatter.date(from: strDate) else { return "" }
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }
}
    
extension FBPartyManager {
    func updatePartyStatus(completion: @escaping () -> Void) {
        Firestore.firestore().collection("party")
            .addSnapshotListener { snapshot, _ in
                guard let snapshot = snapshot else { return }
                    
                snapshot.documentChanges.forEach { change in
                    
                    switch change.type {
                    case .added:
                        print("##### Party added")
                        completion()
                    case .modified:
                        print("##### Party modified")
                        completion()
                    case .removed:
                        print("##### Party removed")
                        completion()
                    }
                }
            }
    }
}
