//
//  ChattingListTableViewCell.swift
//  DeliveryProject
//
//  Created by mini on 2023/01/14.
//

import UIKit
import SnapKit
import Then

class ChattingListTableViewCell: UITableViewCell {

    lazy var chattingUserLabel = UILabel().then {
        $0.text = "채탕 상대"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    
    lazy var chattingContentLabel = UILabel().then {
        $0.text = "채팅 내용 미리보기"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 15)
    }

    lazy var chattingDateLabel = UILabel().then {
        $0.text = "23/01/01"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 10)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.addSubview(chattingUserLabel)
        self.contentView.addSubview(chattingContentLabel)
        self.contentView.addSubview(chattingDateLabel)
        
        chattingUserLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalTo(self.contentView.safeAreaLayoutGuide.snp.left).offset(20)
        }
        
        chattingContentLabel.snp.makeConstraints { make in
            make.top.equalTo(chattingUserLabel.snp.bottom).offset(5)
            make.left.equalTo(chattingUserLabel.snp.left)
            make.bottom.equalTo(self.contentView.safeAreaLayoutGuide.snp.bottom).offset(-15)
            
        }
        
        chattingDateLabel.snp.makeConstraints { make in
            make.top.equalTo(chattingUserLabel.snp.top)
            make.right.equalTo(self.contentView.safeAreaLayoutGuide.snp.right).offset(-15)
        }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
