//
//  HistoryResponse.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/31.
//

import Foundation


struct HistoryResponse : Decodable {
    var data : [Data]
    var success : Bool
    var message : String
    var property : Int
}

struct Data : Decodable{
    var startingPoint : String
    var arrivingPoint : String
    var startDeliTime : String
    var endDeliTime : String
    var menu : String
    var userWant : String
    var deliTip : String
    var userId : String
    var articleId : Int
    var create_dt : String
}


