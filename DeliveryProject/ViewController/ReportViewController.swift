//
//  ReportViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/08.
//

import UIKit
import Alamofire

class ReportViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var reportTextView: UITextView!
    
    // 상대 닉네임, 채팅 뷰에서 받아야 함
    let otherUserNickName = "미니"
    
    // 신고하기 버튼
    @IBAction func reportButton(_ sender: UIButton) {
        let userId = UserDefaults.standard.string(forKey: "id") ?? ""
        
        let param = ReportRequest(userId: userId, nickname: otherUserNickName, warningContent: reportTextView.text)
        postReport(param)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "신고하기"
        
//        self.navigationController?.navigationBar.topItem?.title = "신고하기"
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        TextViewOption()
        
    }
    
    override func viewWillLayoutSubviews() {
        //    UnderLine()
    }
    
    let textViewPlaceHolder = "신고 내용 작성."
    
    func TextViewOption(){
        
        //textview에 delegate 상속
        reportTextView.delegate = self
        
        // placeholder 설정
        reportTextView.text = textViewPlaceHolder
        
        
        // placeholder textColor 설정
        reportTextView.textColor = .placeholderText
        
        // placeholder의 텍스트 위치 설정
        reportTextView.contentInset.top = 8
        
        // 텍스트 뷰 테두리 설정
        reportTextView.layer.borderWidth = 1
        reportTextView.layer.borderColor = UIColor.systemGray4.cgColor
        
    }
    
    // 텍스트뷰가 수정을 시작할 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if reportTextView.text == textViewPlaceHolder {
            reportTextView.text = nil
            reportTextView.textColor = .black
        }
    }
    
    // 텍스트뷰를 종료했을 때 텍스트뷰의 텍스트가 비어있다면
    func reportTextView(_ textView: UITextView) {
        
        // 출발 장소
        if reportTextView.text.isEmpty{
            reportTextView.text = textViewPlaceHolder
            reportTextView.textColor = .placeholderText
        }
    }
    
    func postReport(_ parameters: ReportRequest) {
        AF.request("http://3.37.209.65:3000/warning", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: ReportResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("신고하기 성공")
                        
                        let successAlert = UIAlertController(title: "접수 완료", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        
                        let successAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { _ in                        self.navigationController?.popViewController(animated: true)
                        })
                        successAlert.addAction(successAction)
                        self.present(successAlert, animated: true, completion: nil)
                        
                        
                    }
                    
                    else{
                        print("신고하기 실패 \(response.message)")
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
    
    //    // 신고내용 작성 언더라인
    //    func UnderLine(){
    //        let border = CALayer()
    //        let width = CGFloat(1.0) // 선 굵기
    //        border.borderColor = UIColor.systemGray4.cgColor
    //
    //        // 텍스트 뷰 언더라인
    //        border.frame = CGRect(x: 0, y: reportTextView.frame.height-width, width: reportTextView.frame.width, height: reportTextView.frame.height)
    //
    //        border.borderWidth = 1
    //        border.backgroundColor = UIColor.black.cgColor
    //        reportTextView.layer.addSublayer(border)
    //        reportTextView.layer.masksToBounds = true
    //    }
    
    

