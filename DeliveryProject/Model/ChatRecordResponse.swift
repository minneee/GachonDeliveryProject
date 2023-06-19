//
//  ChatRecordResponse.swift
//  DeliveryProject
//
//  Created by 김민희 on 2023/05/01.
//

import Foundation

struct ChatRecordResponse: Decodable {
    var data: [chatRecordData]?
    var success: Bool
    var message: String
    var property: Int
}

struct chatRecordData: Decodable {
    var nickname: String
    var msg: String
    var sendDay: String
}
