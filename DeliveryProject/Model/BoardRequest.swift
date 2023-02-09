//
//  BoardRequest.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/02/08.
//

import Foundation

struct BoardRequesst : Encodable{
    var deliTip : String?
    var startingPoint : String?
    var arrivingPoint : String?
    var endDeliTime : Int?
}
