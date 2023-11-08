//
//  PartyInfo.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/27/23.
//

import Foundation
import UIKit

struct PartyInfo {
    var champion: [String]
    var content: String
    var date: String
    var hopePosition: [String]
    var profileImage: String
    var tier: String
    var title: String
    var userName: String
    var writer: String
    var requester: [String: Bool] = [:]
    var position: String
    var thread: String? // 파이어베이스의 DocumentID
}
