//
//  DeliverRatingRequest.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/08/17.
//

import Foundation

struct DeliverRatingRequest : Encodable {
    var nickname : String
    var rate : Int
}
