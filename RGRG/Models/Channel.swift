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
    var guest: String
    var host: String
    var channelID: String
    var currentMessage: String?
    var hostProfile: String
    var guestProfile: String
}
