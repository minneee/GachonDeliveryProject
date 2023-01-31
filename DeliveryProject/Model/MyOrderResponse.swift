//
//  MyOrderResponse.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/02/01.
//

import Foundation

struct MyOrderResponse : Decodable{
    var data : [Data]
    var success : Bool
    var message : String
    var property : Int
}


