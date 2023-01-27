//
//  SuggestionResponse.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/27.
//

import Foundation

struct SuggestResponse : Decodable{
    var success : Bool
    var message : String
    var property : Int
}
