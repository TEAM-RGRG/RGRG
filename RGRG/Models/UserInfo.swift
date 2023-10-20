//
//  UserInfo.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 2023/10/11.
//

import Foundation

struct User {
    let userID: Int
    let email: String
    let password: String
    let userName: String
    let tier: String
    let position: String
    let profilePhoto: String = "Default"
    let mostChampion: [String] = []
}

