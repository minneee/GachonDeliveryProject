//
//  ReportViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/08.
//

import UIKit

class ReportViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var reportTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    

}
