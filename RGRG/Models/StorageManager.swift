//
//  StorageManager.swift
//  RGRG
//
//  Created by 이수현 on 10/24/23.
//

import FirebaseCore
import FirebaseStorage
import Foundation
import UIKit

class StorageManager {
    static let shared = StorageManager()
    let storage = Storage.storage()

    func getImage(_ select: String, _ name: String, completion: @escaping (UIImage?) -> Void) {
        let storageRef = storage.reference()
        var imagesRef = storageRef.child("\(select)/\(name).png")
        let megaByte = Int64(1 * 1024 * 1024)

        imagesRef.getData(maxSize: megaByte) { data, _ in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }

    func getAllImage(_ folder: String, completion: @escaping ([StorageReference]?) -> Void) {
        var folderList: [StorageReference]?
        let storageRef = storage.reference()
        var imagesRef = storageRef.child("\(folder)/uid")
        imagesRef.listAll(completion: { result, _ in
            folderList = result?.items
        })
        let megaByte = Int64(1 * 1024 * 1024)

        imagesRef.getData(maxSize: megaByte) { data, _ in
            guard let imageData = data else {
                return
            }
            completion(folderList)
        }
    }
}
