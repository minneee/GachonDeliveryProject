//
//  CreateOrderRequest.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/29.
//

import Foundation

struct CreateOrderRequest : Encodable{
    var startingPoint : String
    var arrivingPoint : String
    var startDeliTime : String
    var endDeliTime : String
    var menu : String
    var userWant : String
    var deliTip : String
    var userId : String
}
