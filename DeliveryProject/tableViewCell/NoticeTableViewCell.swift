//
//  NoticeTableViewCell.swift
//  DeliveryProject
//
//  Created by mini on 2023/01/11.
//


import UIKit
import SnapKit
import Then

class NoticeTableViewCell: UITableViewCell {
    
    lazy var noticeTitleLabel = UILabel().then {
        $0.text = "공지사항 제목"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 17)
    }

    lazy var noticeDateLabel = UILabel().then {
        $0.text = "23/01/01"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 10)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.addSubview(noticeTitleLabel)
        self.contentView.addSubview(noticeDateLabel)
        
        noticeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalTo(self.contentView.safeAreaLayoutGuide.snp.left).offset(20)
        }
        
        noticeDateLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeTitleLabel.snp.bottom).offset(5)
            make.right.equalTo(self.contentView.safeAreaLayoutGuide.snp.right).offset(-15)
            make.bottom.equalTo(self.contentView.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
