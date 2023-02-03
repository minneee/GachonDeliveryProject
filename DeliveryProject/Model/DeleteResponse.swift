//
//  DeleteResponse.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/02/03.
//

import Foundation

struct DeleteResponse : Decodable {
    var data : Int?
    var success : Bool
    var message : String
    var property : Int
}
