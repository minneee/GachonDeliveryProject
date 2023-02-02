//
//  WithdrawalResponse.swift
//  DeliveryProject
//
//  Created by mini on 2023/02/02.
//

import Foundation

struct WithdrawalResponse: Decodable {
    var data: String?
    var success : Bool
    var message : String
    var property : Int
}
