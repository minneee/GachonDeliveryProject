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

//var chattingUserList: [String] = ["1번 User", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 공지", "4번 공지", "1번 공지", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 공지", "4번 공지", "1번 공지", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 공지", "4번 공지", "1번 공지", "2번 공지사항 제목은 좀 길어요", "3번 공지3번 공지3번 공지3번 User"]

class ChattingListViewController: UIViewController {
    
    var chattingRoomList: [RoomInfo] = []

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
        
        
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        let param = ChattingRoomListRequest(userId: id)
        postRoomList(param)

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
    
    
    
    func postRoomList(_ parameters: ChattingRoomListRequest) {
        AF.request("http://3.37.209.65:3000/find-room-mine", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: ChattingRoomListResponse.self) { [weak self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print(parameters)
                        print(response)
                        if response.data != nil {
                            self?.chattingRoomList = response.data!
                            DispatchQueue.main.async { [weak self] in
                                guard let self else { return }
                                self.chattingListTableView.reloadData()
                            }
                        }
                    }
                    
                    else{
                        print("채팅목록 불러오기 실패\(response.message)")
                        //alert message
                        let FailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        
                        let FailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                        FailAlert.addAction(FailAction)
                        self?.present(FailAlert, animated: true, completion: nil)
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    print("서버 통신 실패")
                    let FailAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
                    
                    let FailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    FailAlert.addAction(FailAction)
                    self?.present(FailAlert, animated: true, completion: nil)
                }
                
                
                
            }
    }
    
}

extension ChattingListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chattingRoomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: "ChattingListTableViewCell", for: indexPath) as! ChattingListTableViewCell
        print(userCell)
        
        userCell.chattingUserLabel.text = self.chattingRoomList[indexPath.row].whoSend
        userCell.chattingContentLabel.text = self.chattingRoomList[indexPath.row].msg
        userCell.chattingDateLabel.text = self.chattingRoomList[indexPath.row].sendDay
        
        return userCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 화면 이동
        guard let chattingVC = storyboard?.instantiateViewController(withIdentifier: "ChattingVC") as? ChattingViewController else {return}
        
        /*  chatiingViewController의 otherUserId는 주문서 작성자의 ID인데
            chattingListViewController에서 상대의 userId를 넘겨주게 되면
            주문서 작성자 시점에서 배달하는 사람 ID를 넘겨주게 됨 
        */
//        chattingVC.otherUserId = self.chattingRoomList[indexPath.row].userId
        chattingVC.roomId = self.chattingRoomList[indexPath.row].roomId 
        
        self.navigationController?.pushViewController(chattingVC, animated: true)
    }
}
