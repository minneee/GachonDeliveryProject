//
//  FindChatRoomResponse.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/03/22.
//

import Foundation
struct FindChatRoomResponse : Decodable{
    var roomId : Int?
    var deliverNickname : String
    var articleId : Int
    var otherUserData : UserData?
    var myData : myData
    var success: Bool
    var message : String
    var property : Int
}

struct UserData : Decodable{
    var nickname : String
    var introduce : String
    var orderRate : Int?
    var deliveryRate : Int?
}

struct myData :Decodable{
    var nickname : String
}
