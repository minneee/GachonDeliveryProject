//
//  LoginResponse.swift
//  DeliveryProject
//
//  Created by mini on 2023/01/27.
//

import Foundation

struct LoginResponse: Decodable {
    var memberTrueFalse: Bool?
    var success: Bool
    var message: String
    var property: Int
}
