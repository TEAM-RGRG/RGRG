//
//  UserInfo.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import Foundation

struct UserInfo {
    let email: String
    let userName: String
    let tier: String
    let position: String
    var profilePhoto: String = "Default"
    var mostChampion: [String] = ["None", "None", "None"]
    let uid: String
    var iBlocked: [String]
    var youBlocked: [String]
}
