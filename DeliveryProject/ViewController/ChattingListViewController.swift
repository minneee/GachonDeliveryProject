//
//  ChattingListViewController.swift
//  DeliveryProject
//
//  Created by mini on 2023/01/14.
//

import UIKit
import SnapKit
import Then
import Alamofire

var chattingUserList: [String] = ["1번 User", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 공지", "4번 공지", "1번 공지", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 공지", "4번 공지", "1번 공지", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 공지", "4번 공지", "1번 공지", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 User"]

class ChattingListViewController: UIViewController {

    lazy var chattingListTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        //cell 최소 높이
        $0.estimatedRowHeight = 50
        //50 이상일 때 동적 높이
        $0.rowHeight = UITableView.automaticDimension
        
        $0.register(UINib(nibName: "ChattingListTableViewCell", bundle: nil),  forCellReuseIdentifier: "ChattingListTableViewCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "채팅방 목록"

    }
    
    
    
    //레이아웃 설정
    private func setupLayout() {
        //view 추가
        self.view.addSubview(chattingListTableView)
        
        
        //오토레이아웃
        chattingListTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        
    }
    
}

extension ChattingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chattingUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: "ChattingListTableViewCell", for: indexPath) as! ChattingListTableViewCell
        
        userCell.chattingUserLabel.text = "채팅 상대 이름"
        userCell.chattingContentLabel.text = chattingUserList[indexPath.row]
        userCell.chattingDateLabel.text = "23/02/01"

        return userCell
    }
    
    
}
