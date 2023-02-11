//
//  BoardResponse.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/02/08.
//

import Foundation
struct BoardResponse : Decodable{
    var data : [Data]
    var success : Bool
    var message : String
    var property : Int
}
