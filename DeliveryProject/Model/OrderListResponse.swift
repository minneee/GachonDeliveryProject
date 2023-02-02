//
//  OrderListResponse.swift
//  DeliveryProject
//
//  Created by mini on 2023/02/02.
//

import Foundation

struct OrderListResponse: Decodable {
    var data: [Data]
    var success: Bool
    var message: String
    var property: Int
}
