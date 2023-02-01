//
//  OrderedListTableViewCell.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/01.
//

import UIKit

class OrderedListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var startPlace: UILabel! // 출발 장소
    @IBOutlet weak var endPlace: UILabel! // 도착 장소
    @IBOutlet weak var endTime: UILabel! // 도착 시간
    @IBOutlet weak var menu: UILabel! // 메뉴
    @IBOutlet weak var request: UILabel! // 요청사항
    @IBOutlet weak var deliveryTip: UILabel! // 배달팁
    
    
    @IBOutlet weak var modifyBtn: UIButton!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
