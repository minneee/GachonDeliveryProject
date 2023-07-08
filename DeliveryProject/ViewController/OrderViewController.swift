//
//  OrderViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/01.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var startPlace: UILabel! // 출발 장소
    @IBOutlet weak var endPlace: UILabel! // 도착 장소
    @IBOutlet weak var endTime: UILabel! // 도착 시간
    @IBOutlet weak var menu: UILabel! // 메뉴
    @IBOutlet weak var request: UILabel! // 요청사항
    @IBOutlet weak var deliveryTip: UILabel! // 배달팁
    
//    @IBOutlet weak var goToChat: UIButton!
    
    var DList : [Data] = []
    var rowNum = -1
    
    

    // 채팅 버튼을 눌렀을 때 chattingViewController의 roomId 값을 설정해줘야 함
    @IBAction func chattingBtn(_ sender: UIButton) {
        
        guard let chattingVC = storyboard?.instantiateViewController(withIdentifier: "ChattingVC") as? ChattingViewController else {return}
        chattingVC.otherUserId = DList[rowNum].userId
        navigationController?.pushViewController(chattingVC, animated: true)
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(DList, rowNum)

        let splitStartTime = DList[rowNum].startDeliTime.split(separator: ":").map{String($0)}
        let setStartTime = splitStartTime[0] + ":" + splitStartTime[1]
        
        let splitEndTime = DList[rowNum].endDeliTime.split(separator: ":").map{String($0)}
        let setEndTime = splitEndTime[0] + ":" + splitEndTime[1]
        
        
        startPlace.text = DList[rowNum].startingPoint
        endPlace.text = DList[rowNum].arrivingPoint
        endTime.text = setStartTime + " ~ " + setEndTime
        menu.text = DList[rowNum].menu
        request.text = DList[rowNum].userWant
        deliveryTip.text = DList[rowNum].deliTip
        

        self.navigationController?.navigationBar.topItem?.title = ""
    }
    

 
}
