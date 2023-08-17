//
//  FindChatRoomRequest.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/03/22.
//

import Foundation

struct FindChatRoomRequest: Encodable{
    var myUserId : String
    var otherUserId : String
    var deliverId : String
    var articleId : Int
}
