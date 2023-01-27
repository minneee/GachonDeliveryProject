//
//  ChangeProfileRequest.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/27.
//

import Foundation


struct ChangeProfileRequest: Encodable {
    var userId: String
    var nickname : String
    var introduce : String
}
