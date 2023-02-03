//
//  DeleteRequest.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/02/03.
//

import Foundation

struct DeleteRequest : Encodable{
    var userId : String
    var articleId : Int
}
