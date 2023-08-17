//
//  StarScoreViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/09.
//

import UIKit
import Alamofire

class StarScoreViewController: UIViewController {
    
    var myNickname = ""
    var otherUserNickname = ""
    var deliverNickname = ""
    var rate = 0
    
    @IBOutlet weak var oneStarBtn: UIButton!
    @IBOutlet weak var twoStarBtn: UIButton!
    @IBOutlet weak var threeStarBtn: UIButton!
    @IBOutlet weak var fourStarBtn: UIButton!
    @IBOutlet weak var fiveStarBtn: UIButton!
    
    let colorImage = UIImage(named: "colorGachon")
    let WBImage = UIImage(named: "Gachon")
    
   
    // 1점 버튼
    @IBAction func oneStarBtn(_ sender: UIButton) {
        rate = 1
        
//        sender.setImage(image, for: .normal)
        oneStarBtn.setImage(colorImage, for: .normal)
        twoStarBtn.setImage(WBImage, for: .normal)
        threeStarBtn.setImage(WBImage, for: .normal)
        fourStarBtn.setImage(WBImage, for: .normal)
        fiveStarBtn.setImage(WBImage, for: .normal)
        
        
    }
    
    // 2점 버튼
    @IBAction func twoStarBtn(_ sender: UIButton) {
        rate = 2
        
        oneStarBtn.setImage(colorImage, for: .normal)
        twoStarBtn.setImage(colorImage, for: .normal)
        threeStarBtn.setImage(WBImage, for: .normal)
        fourStarBtn.setImage(WBImage, for: .normal)
        fiveStarBtn.setImage(WBImage, for: .normal)
    }
    
    // 3점 버튼
    @IBAction func threeStarBtn(_ sender: UIButton) {
        rate = 3
        
        oneStarBtn.setImage(colorImage, for: .normal)
        twoStarBtn.setImage(colorImage, for: .normal)
        threeStarBtn.setImage(colorImage, for: .normal)
        fourStarBtn.setImage(WBImage, for: .normal)
        fiveStarBtn.setImage(WBImage, for: .normal)
    }
    
    // 4점 버튼
    @IBAction func fourStarBtn(_ sender: UIButton) {
        rate = 4
        
        oneStarBtn.setImage(colorImage, for: .normal)
        twoStarBtn.setImage(colorImage, for: .normal)
        threeStarBtn.setImage(colorImage, for: .normal)
        fourStarBtn.setImage(colorImage, for: .normal)
        fiveStarBtn.setImage(WBImage, for: .normal)
    }
    
    // 5점 버튼 
    @IBAction func fiveStarBtn(_ sender: UIButton) {
        rate = 5
        
        oneStarBtn.setImage(colorImage, for: .normal)
        twoStarBtn.setImage(colorImage, for: .normal)
        threeStarBtn.setImage(colorImage, for: .normal)
        fourStarBtn.setImage(colorImage, for: .normal)
        fiveStarBtn.setImage(colorImage, for: .normal)
    }
    
    
    // 확인 버튼 클릭 액션
    @IBAction func submitButton(_ sender: UIButton) {
        
        if (myNickname == deliverNickname){
            let param = OrderRatingRequest(nickname: otherUserNickname, rate: rate)
            postOrderRating(param)
        }
        else{
            let param1 = DeliverRatingRequest(nickname: otherUserNickname, rate: rate)
            postDelierRating(param1)
        }
        
        // 배달할지 주문할지 선택 창으로 이동 
        guard let chooseVC = storyboard?.instantiateViewController(withIdentifier: "NavController") else {return}
        navigationController?.pushViewController(chooseVC, animated: true)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = ""
        
            
        }
    
    
    // 배달원 별점 남기기
    func postDelierRating(_ parameters: DeliverRatingRequest) {
        AF.request("http://43.200.179.53:3000/deliverrating", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: CreateOrderResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("배달원 별점 등록 성공")
                    }
                    
                    else{
                        print("배달원 별점 등록 실패 :  \(response.message)")
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
    
    // 주문자 별점 남기기
    func postOrderRating(_ parameters: OrderRatingRequest) {
        AF.request("http://43.200.179.53:3000/orderrating", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: CreateOrderResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("주문자 별점 등록 성공")
                    }
                    
                    else{
                        print("주문자 별점 등록 실패 :  \(response.message)")
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
    
