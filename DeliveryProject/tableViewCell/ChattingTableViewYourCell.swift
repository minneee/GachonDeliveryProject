//
//  ChattingTableViewYourCell.swift
//  DeliveryProject
//
//  Created by mini on 2023/01/14.
//

import UIKit

class ChattingTableViewYourCell: UITableViewCell {
    
    @IBOutlet weak var speechBubbleYourView: UIView!
    
    @IBOutlet weak var speechYourLabel: UILabel!
    
    @IBOutlet weak var speechYourDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        speechBubbleYourView.layer.cornerRadius = 7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
