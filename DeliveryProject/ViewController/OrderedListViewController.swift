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
    
    // 테이블
    @IBOutlet weak var orderedListTable: UITableView!
    
    // 네이게이션 바 주문서 작성 버튼 아울렛
    @IBOutlet var createOrder: UIBarButtonItem!

    //네비게이션 바 이미지
    let navImage = UIImage(named: "createOrder")
    

    
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
        
        var startDeliTime = String(DList[indexPath.row].startDeliTime)
//        startDeliTime.insert(":", at: startDeliTime.index(startDeliTime.startIndex, offsetBy: 2))
        
        var endDeliTime = String(DList[indexPath.row].endDeliTime)
        endDeliTime.insert(":", at: endDeliTime.index(endDeliTime.startIndex, offsetBy: 2))
        
        cell.endTime.text = startDeliTime + " ~ " + endDeliTime
        
        cell.modifyBtn.tag = indexPath.row
        
        
        
        return cell
        
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        rowNum = indexPath.row
    //        print(rowNum)
    //        modifyVC.rowNum = rowNum
//}
    
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
