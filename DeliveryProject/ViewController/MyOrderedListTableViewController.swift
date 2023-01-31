//
//  MyOrderedListTableViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/09.
//

import UIKit
import Alamofire

class MyOrderedListTableViewController: UITableViewController {

    @IBOutlet var MyOrderedListTable: UITableView!
    
    var DList : [Data] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        let param = HistoryRequest(userId: id)
        postHistory(param)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return DList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myOrderedList", for: indexPath) as! MyOrderedListTableViewCell
        
        let create_dt = DList[indexPath.row].create_dt
        let startIndex = create_dt.index(create_dt.startIndex, offsetBy: 0)
        let endIndex = create_dt.index(create_dt.startIndex, offsetBy: 9)
        let date = create_dt[startIndex ..< endIndex]

        cell.startPlace.text = DList[indexPath.row].startingPoint
        cell.endPlace.text = DList[indexPath.row].arrivingPoint
        cell.doDeliveryNickName.text = "채팅이 돼야 된대요"
        cell.receiveDeliveryNickName.text = "채팅이 돼야 된대요"
        cell.menu.text = DList[indexPath.row].menu
        cell.request.text = DList[indexPath.row].userWant
        cell.deliveryTip.text = DList[indexPath.row].deliTip
        cell.date.text = String(date)

  
        return cell
    }
    
    func postHistory(_ parameters: HistoryRequest) {
        AF.request("http://3.37.209.65:3000/history", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: HistoryResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("이용내역 불러오기 성공")
                        
                        DList = response.data
                        print(DList.count)
                        tableView.reloadData()
                    }
                    
                    else{
                        print("이용내역 불러오기 실패 \(response.message)")
                        //alert message
                        let FailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        
                        let FailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                        FailAlert.addAction(FailAction)
                        self.present(FailAlert, animated: true, completion: nil)
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    print("서버 통신 실패")
                    let serverFailAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
                    
                    let serverFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    serverFailAlert.addAction(serverFailAction)
                    self.present(serverFailAlert, animated: true, completion: nil)
                }
                
            }
    }


}


