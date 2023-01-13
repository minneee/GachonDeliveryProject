//
//  QuestionViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/08.
//

import UIKit

class QuestionViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var questionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        TextViewOption()
        
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
