//
//  QuestionViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/08.
//

import UIKit
import Alamofire

class QuestionViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var questionTextView: UITextView!
    
    // 네비게이션 바 확인 버튼
    @IBAction func completeBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        let suggestionContent = questionTextView.text ?? ""
        let param = SuggestionRequest(userId: id, suggestionContent: suggestionContent)
        postSuggestion(param)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        TextViewOption()
        
    }
    
    func postSuggestion(_ parameters: SuggestionRequest){
        AF.request("http://43.200.179.53:3000/suggestion", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("문의 성공")
                    }
                    
                    else{
                        print("문의 실패\(response.message)")
                        //alert message
                        let SuggestFailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        
                        let SuggestFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                        SuggestFailAlert.addAction(SuggestFailAction)
                        self.present(SuggestFailAlert, animated: true, completion: nil)
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
    
    
    
    let textViewPlaceHolder = "문의사항을 입력해주세요."
    
    func TextViewOption(){
        
        //textview에 delegate 상속
        questionTextView.delegate = self
        
        
        
        // placeholder 설정
        questionTextView.text = textViewPlaceHolder
        
        
        // placeholder textColor 설정
        questionTextView.textColor = .placeholderText
        
        // 텍스트 뷰 테두리 설정
        //        questionTextView.layer.borderWidth = 1
        //        questionTextView.layer.borderColor = UIColor.systemGray5.cgColor
        //        questionTextView.layer.cornerRadius = 5
        
        
        // placeholder의 텍스트 위치 설정
        questionTextView.contentInset.top = 8
        
    }
    
    // 텍스트뷰가 수정을 시작할 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if questionTextView.text == textViewPlaceHolder {
            questionTextView.text = nil
            questionTextView.textColor = .black
        }
    }
    
    // 텍스트뷰를 종료했을 때 텍스트뷰의 텍스트가 비어있다면
    func textViewDidEndEditing(_ textView: UITextView) {
        
        // 출발 장소
        if questionTextView.text.isEmpty{
            questionTextView.text = textViewPlaceHolder
            questionTextView.textColor = .placeholderText
        }
        
    }
}
