//
//  OrderRatingRequest.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/08/17.
//

import Foundation

struct OrderRatingRequest : Encodable {
    var nickname : String
    var rate : Int
}
