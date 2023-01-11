//
//  MyOrderedListTableViewCell.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/09.
//

import UIKit

class MyOrderedListTableViewCell: UITableViewCell {
 
    @IBOutlet weak var startPlace: UILabel! // 출발 장소
    @IBOutlet weak var endPlace: UILabel! // 받는 장소
    @IBOutlet weak var doDeliveryNickName: UILabel! // 배달한 사람 닉네임
    @IBOutlet weak var receiveDeliveryNickName: UILabel! // 받은 사람 닉네임
    @IBOutlet weak var menu: UILabel! // 메뉴
    @IBOutlet weak var request: UILabel! // 요청사항
    @IBOutlet weak var deliveryTip: UILabel! // 배달 팁
    @IBOutlet weak var date: UILabel! // 날짜
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
