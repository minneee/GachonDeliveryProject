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
    
    

    @IBAction func chattingBtn(_ sender: UIButton) {
        
        guard let chattingVC = storyboard?.instantiateViewController(withIdentifier: "ChattingVC") else {return}
        navigationController?.pushViewController(chattingVC, animated: true)
        print("asd")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(DList, rowNum)
        
        var startDeliTime = String(DList[rowNum].startDeliTime)
        startDeliTime.insert(":", at: startDeliTime.index(startDeliTime.startIndex, offsetBy: 2))
        
        var endDeliTime = String(DList[rowNum].endDeliTime)
        endDeliTime.insert(":", at: endDeliTime.index(endDeliTime.startIndex, offsetBy: 2))
        
        startPlace.text = DList[rowNum].startingPoint
        endPlace.text = DList[rowNum].arrivingPoint
        endTime.text = startDeliTime + " ~ " + endDeliTime
        menu.text = DList[rowNum].menu
        request.text = DList[rowNum].userWant
        deliveryTip.text = DList[rowNum].deliTip
        

        self.navigationController?.navigationBar.topItem?.title = ""
    }
    

 
}
