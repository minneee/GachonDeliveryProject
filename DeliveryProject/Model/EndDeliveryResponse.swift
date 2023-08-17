//
//  EndDeliveryResponse.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/08/17.
//

import Foundation

struct EndDeliveryResponse: Decodable {
    var success: Bool
    var message: String
    var property: Int
}
