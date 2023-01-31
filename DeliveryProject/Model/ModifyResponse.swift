//
//  ModifyResponse.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/31.
//

import Foundation
struct ModifyResponse : Decodable {
    var data : Int?
    var success : Bool
    var message : String
    var property : Int
}
