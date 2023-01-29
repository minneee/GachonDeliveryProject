//
//  CreateOrderRequest.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/29.
//

import Foundation

struct CreateOrderRequest : Encodable{
    var startPoint : String
    var arrivingPoint : String
    var deliTime : Int
    var menu : String
    var deliTip : String
    var userId : String
}
