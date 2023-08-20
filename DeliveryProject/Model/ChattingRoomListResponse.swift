//
//  ChattingRoomListResponse.swift
//  DeliveryProject
//
//  Created by mini on 2023/03/10.
//

import Foundation

struct ChattingRoomListResponse: Decodable {
    var data: [RoomInfo]?
    var success : Bool
    var message : String
    var property : Int
}

struct RoomInfo: Decodable {
    var roomId: Int
    var userId: String
    var nickname: String
    var whoSend: String
    var msg: String
    var sendDay: String // 마지막으로 보낸 날
    var articleId : Int
    var deliverNickname : String
}
