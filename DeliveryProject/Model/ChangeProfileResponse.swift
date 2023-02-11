//
//  ChangeProfileResponse.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/27.
//

import Foundation
import UIKit

struct ChangeProfileResponse : Decodable{
    var success: Bool
    var message: String
    var property: Int
}
