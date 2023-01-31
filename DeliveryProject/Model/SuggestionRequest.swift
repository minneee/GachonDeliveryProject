//
//  SuggestionRequest.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/27.
//

import Foundation

struct SuggestionRequest: Encodable{
    var userId : String
    var suggestionContent : String
}
