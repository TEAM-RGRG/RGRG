//
//  FBStorageManager.swift
//  RGRG
//
//  Created by 이수현 on 10/24/23.
//

import FirebaseCore
import FirebaseStorage
import UIKit

#warning("Todo-Stuff: Async/Await 로 교체 및 중복 코드 제거")
class FBStorageManager {
    static let shared = FBStorageManager()
    let storage = Storage.storage()

    func getImage(_ select: String, _ name: String, completion: @escaping (UIImage?) -> Void) {
        let storageRef = storage.reference()
        var imagesRef = storageRef.child("\(select)/\(name).png")
        let megaByte = Int64(1 * 1024 * 1024) / 2

        imagesRef.getData(maxSize: megaByte) { data, _ in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }
}
