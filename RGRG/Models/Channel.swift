//
//  Channel.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/22/23.
//

import Foundation
import FirebaseFirestore

struct Channel: Hashable {
    var channelName: String
    var requester: String
    var writer: String
    var channelID: String
}
