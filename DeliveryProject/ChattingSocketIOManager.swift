//
//  ChattingSocketIOManager.swift
//  DeliveryProject
//
//  Created by 김민희 on 2023/04/30.
//

import UIKit
import SocketIO

class ChattingSocketIOManager: NSObject {
    static let shared = ChattingSocketIOManager()
    var manager = SocketManager(socketURL: URL(string: "http://3.37.209.65:3000/chat")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        socket = self.manager.socket(forNamespace: "/")
    }
}
