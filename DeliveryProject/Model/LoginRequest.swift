//
//  LoginRequest.swift
//  DeliveryProject
//
//  Created by mini on 2023/01/27.
//

import Foundation

struct LoginRequest: Encodable {
    var userId: String
    var userPw: String
}
