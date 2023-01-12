//
//  DeliveryListTableViewCell.swift
//  DeliveryProject
//
//  Created by 이수현 on 2022/12/31.
//

import UIKit

class DeliveryListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var startPlace: UILabel!
    @IBOutlet weak var endPlace: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var deliveryTip: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
