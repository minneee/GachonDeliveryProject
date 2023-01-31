//
//  ModifyRequest.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/31.
//

import Foundation
struct ModifyRequest : Encodable {
    var startingPoint : String
    var arrivingPoint : String
    var startDeliTime : Int
    var endDeliTime : Int
    var menu : String
    var userWant : String
    var deliTip : String
    var userId : String
    var articleId : Int
}
