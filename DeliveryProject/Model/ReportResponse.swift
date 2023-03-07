//
//  ReportResponse.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/03/07.
//

import Foundation
struct ReportResponse : Decodable{
    var success : Bool
    var message : String
    var property : Int
}
