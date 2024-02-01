//
//  ChannelInfo.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/22/23.
//

import Foundation

struct ChannelInfo: Hashable {
    var channelName: String
    var guest: String
    var host: String
    var channelID: String
    var currentMessage: String?
    var hostProfile: String
    var guestProfile: String
    var hostSender: Bool
    var guestSender: Bool
}
