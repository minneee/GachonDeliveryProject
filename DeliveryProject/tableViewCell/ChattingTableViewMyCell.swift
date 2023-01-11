
import UIKit

class ChattingTableViewMyCell: UITableViewCell {
    
    @IBOutlet weak var speechLabel: UILabel!
    
    @IBOutlet weak var speechDateLabel: UILabel!
    
    @IBOutlet weak var speechBubbleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //채팅 뷰 모서리 둥글게하기
        speechBubbleView.layer.cornerRadius = 7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
