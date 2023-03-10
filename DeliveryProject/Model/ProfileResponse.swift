//
//  profileResponse.swift
//  DeliveryProject
//
//  Created by mini on 2023/01/27.
//

import Foundation

struct ProfileResponse: Decodable {
    var success: Bool
    var message: String
    var property: Int
    var nickname: String?
    var introduce: String?
    var orderRate: Int?
    var deliveryRate: Int?
    
}
