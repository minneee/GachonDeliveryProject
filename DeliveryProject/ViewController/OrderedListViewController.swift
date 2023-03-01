//
//  OrderedListViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/01.
//

import UIKit
import Alamofire

class OrderedListViewController: UIViewController {
    
    var DList : [Data] = []
    var rowNum = -1
    
    // 테이블
    @IBOutlet weak var orderedListTable: UITableView!
    
    // 네이게이션 바 주문서 작성 버튼 아울렛
    @IBOutlet var createOrder: UIBarButtonItem!

    //네비게이션 바 이미지
    let navImage = UIImage(named: "createOrder")
    

    @IBAction func deleteBtn(_ sender: UIButton) {
        let deleteAlert = UIAlertController(title: "주문서 삭제", message: "주문서를 삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        let falseAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        let TrueAction = UIAlertAction(title: "삭제", style: UIAlertAction.Style.destructive) { ACTION in
            
            let id = UserDefaults.standard.string(forKey: "id") ?? ""
            let articleId = self.DList[sender.tag].articleId
            
            let param = DeleteRequest(userId: id, articleId: articleId)
            self.deleteDelete(param)

            
        }
        
        deleteAlert.addAction(falseAction)
        deleteAlert.addAction(TrueAction)

        self.present(deleteAlert, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""

        // 테이블 뷰 설정
        orderedListTable.delegate = self
        orderedListTable.dataSource = self

        // 네비게이션 바 색상 변경
        navigationItem.titleView?.tintColor = .black
        
        //네비게이션 바 주문서 작성 이미지 넣기(크기 조절)
        let scaledImage = navImage?.resizeImage(size: CGSize(width:26, height:26))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: scaledImage, style: .plain, target: self, action: #selector(goToCreateOrderVC))
        
  
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "주문서 목록"
        
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        let param = MyOrderRequest(userId: id)
        postMyOrder(param)
        
        self.view.layoutIfNeeded()
        
    }
    // 주문서 수정 버튼
    @IBAction func fixBtn(_ sender: UIButton) {
        
        guard let modifyVC = storyboard?.instantiateViewController(withIdentifier: "ModifyVC") as? ModifyViewController else{return}
        
        modifyVC.rowNum = sender.tag
        modifyVC.DList = DList
        print("rowNum :", modifyVC.rowNum)
        
        
        navigationController?.pushViewController(modifyVC, animated: true)

       
    }
    
    // 주문서 작성으로 이동
    @objc func goToCreateOrderVC () {
        guard let createOrderVC = storyboard?.instantiateViewController(withIdentifier: "CreateOrderVC") else{return}
        navigationController?.pushViewController(createOrderVC, animated: true)
        
    }

        
   
    func postMyOrder(_ parameters: MyOrderRequest) {
        AF.request("http://3.37.209.65:3000/myorder", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: MyOrderResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("주문 내역 불러오기 성공")
                        
                        DList = response.data
                        print(DList, DList.count)
                        
                        if DList.count > 0 {
                            for i in 0...(DList.count - 1) {
                                let splitStartTime = DList[i].startDeliTime.split(separator: ":").map{String($0)}
                                let startTime = splitStartTime[0] + ":" + splitStartTime[1]
                                DList[i].startDeliTime = startTime
                                
                                let splitEndTime = DList[i].endDeliTime.split(separator: ":").map{String($0)}
                                let endTime = splitEndTime[0] + ":" + splitEndTime[1]
                                DList[i].endDeliTime = endTime
                                
                                print("🔊[DEBUG] \(startTime) \(endTime)")
                                
                            }
                        }
                        
//                        let splitStartTime = dataList[i].startDeliTime.split(separator: ":").map{String($0)}
//                        let startTime = splitStartTime[0] + ":" + splitStartTime[1]
//                        startTimeList.append(startTime)
                        
                        orderedListTable.reloadData()
                        
                    }
                    
                    else{
                        print("주문 내역 불러오기 실패 \(response.message)")
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

    func deleteDelete(_ parameters: DeleteRequest) {
        AF.request("http://3.37.209.65:3000/delete", method: .delete, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: DeleteResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        
                        print("주문서 삭제 성공")
                        self.viewWillAppear(true)
                        
                        print(DList, DList.count)

                    }
                    
                    else{
                        print("주문서 삭제 실패 \(response.message)")
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


extension OrderedListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("셀 개수: " , DList.count)
        return DList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! OrderedListTableViewCell
        
        // cell이 클릭되지 않게 하기
        cell.selectionStyle = .none
        
        cell.startPlace.text = DList[indexPath.row].startingPoint
        cell.endPlace.text = DList[indexPath.row].arrivingPoint
        cell.menu.text = DList[indexPath.row].menu
        cell.request.text = DList[indexPath.row].userWant
        cell.deliveryTip.text = DList[indexPath.row].deliTip
        cell.endTime.text = DList[indexPath.row].startDeliTime + " ~ " + DList[indexPath.row].endDeliTime
        
//        var startDeliTime = String(DList[indexPath.row].startDeliTime)
//        startDeliTime.insert(":", at: startDeliTime.index(startDeliTime.startIndex, offsetBy: 2))
//
//        var endDeliTime = String(DList[indexPath.row].endDeliTime)
//        endDeliTime.insert(":", at: endDeliTime.index(endDeliTime.startIndex, offsetBy: 2))
//
//        cell.endTime.text = startDeliTime + " ~ " + endDeliTime
        
        cell.modifyBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        
        
        
        
        
        return cell
        
    }

    
}
//네비게이션 바 이미지 크기 조절
//extension UIImage {
//    func resizeImage(size: CGSize) -> UIImage {
//        let originalSize = self.size
//        let ratio: CGFloat = {
//            return (originalSize.width > originalSize.height) ? (1 / (size.width / originalSize.width)) : (1 / (size.height / originalSize.height))
//        }()
//
//        return UIImage(cgImage: self.cgImage!, scale: self.scale * ratio, orientation: imageOrientation)
//    }
//}
