//
//  NoticeViewController.swift
//  DeliveryProject
//
//  Created by mini on 2023/01/11.
//

import UIKit
import SnapKit
import Then
import Alamofire

var noticeList: [String] = ["1번 공지", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 공지", "4번 공지", "1번 공지", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 공지", "4번 공지", "1번 공지", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 공지", "4번 공지", "1번 공지", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 공지"]

class NoticeViewController: UIViewController {
    
    //네비게이션 바
//    lazy var navigationBar = UINavigationBar().then{
//        $0.barTintColor = .white
//        $0.tintColor = .black
//        let navItem = UINavigationItem(title: "공지사항")
//        $0.setItems([navItem], animated: true)
//    }
    
    lazy var noticeTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        //cell 최소 높이
        $0.estimatedRowHeight = 50
        //50 이상일 때 동적 높이
        $0.rowHeight = UITableView.automaticDimension
        
        $0.register(UINib(nibName: "NoticeTableViewCell", bundle: nil),  forCellReuseIdentifier: "NoticeTableViewCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
    }
    
    
    //레이아웃 설정
    private func setupLayout() {
        //view 추가
     //   self.view.addSubview(navigationBar)
        self.view.addSubview(noticeTableView)
        
        
        //오토레이아웃
//            navigationBar.snp.makeConstraints { make in
//            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
//            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
//        }
        
        noticeTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        
    }

    

}

extension NoticeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: "NoticeTableViewCell", for: indexPath) as! NoticeTableViewCell
        
        userCell.noticeDateLabel.text = "23/01/01"
        userCell.noticeTitleLabel.text = noticeList[indexPath.row]

        return userCell
    }
    
    
}

