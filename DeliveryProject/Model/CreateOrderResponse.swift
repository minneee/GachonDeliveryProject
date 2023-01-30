//
//  CreateOrderResponse.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/29.
//

import Foundation

struct CreateOrderResponse : Decodable{
    var articleId : Int?
    var success : Bool
    var message : String
    var property : Int
}
