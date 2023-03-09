//
//  ReportRequest.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/03/07.
//

import Foundation

struct ReportRequest : Encodable{
    var userId : String
    var nickName : String
    var warningContent : String
}
