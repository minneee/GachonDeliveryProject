//
//  ModifyViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/12.
//

import UIKit
import DropDown

class ModifyViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var startPlaceTextView: UITextView! // 출발 장소 텍스트 뷰
    @IBOutlet weak var endPlaceDropView: UIView! // 도착 장소 드롭 뷰
    @IBOutlet weak var endPlaceBtn: UIButton! // 도착 장소 버튼
    @IBOutlet weak var menuTextView: UITextView! // 메뉴 텍스트 뷰
    @IBOutlet weak var requestTextView: UITextView! // 요청사항 텍스트 뷰
    @IBOutlet weak var deliveryTipDropView: UIView! // 배달팁 드롭 뷰
    @IBOutlet weak var deliveryTipBtn: UIButton! // 배달팁 버튼
    
    let dropdown = DropDown()
    
    let endPlaceList = ["AI공학관", "가천관", "중앙도서관"]
    let deliveryTipList = ["무료", "500원", "1000원", "1500원"]
    
    
    // 도착 장소 드롭다운
    @IBAction func endPlaceBtn(_ sender: UIButton) {
        dropdown.dataSource = endPlaceList
        
        dropdown.show()
        endplaceSetDropdown()
        endPlaceSelectionAction()
        
    }
    
    // 배달팁 드롭다운
    @IBAction func deliveryTipBtn(_ sender: UIButton) {
        dropdown.dataSource = deliveryTipList
        
        dropdown.show()
        deliveryTipSetDropdown()
        deliveryTipSelectionAction()
    }
    
    // 완료버튼
    @IBAction func completeBtn(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        TextViewOption()

    }
    
    // startPlace, menu, request TextView 설정
    func TextViewOption(){
        
        //textview에 delegate 상속
        startPlaceTextView.delegate = self
        menuTextView.delegate = self
        requestTextView.delegate = self
        
        // placeholder 설정
        startPlaceTextView.text = "출발 장소"
        menuTextView.text = "메뉴"
        requestTextView.text = "요청사항"
        
        // placeholder textColor 설정
        startPlaceTextView.textColor = .placeholderText
        menuTextView.textColor = .placeholderText
        requestTextView.textColor = .placeholderText
        
        // 텍스트 뷰 테두리 설정
        startPlaceTextView.layer.borderWidth = 1
        startPlaceTextView.layer.borderColor = UIColor.systemGray5.cgColor
        startPlaceTextView.layer.cornerRadius = 5
        
        menuTextView.layer.borderWidth = 1
        menuTextView.layer.borderColor = UIColor.systemGray5.cgColor
        menuTextView.layer.cornerRadius = 5
        
        requestTextView.layer.borderWidth = 1
        requestTextView.layer.borderColor = UIColor.systemGray5.cgColor
        requestTextView.layer.cornerRadius = 5
        
        // placeholder의 텍스트 위치 설정
        startPlaceTextView.contentInset.top = 8
        menuTextView.contentInset.top = 8
        requestTextView.contentInset.top = 8
    }
    
    // 텍스트뷰를 종료했을 때 텍스트뷰의 텍스트가 비어있다면
    func textViewDidEndEditing(_ textView: UITextView) {
        
        // 출발 장소
        if startPlaceTextView.text.isEmpty{
            startPlaceTextView.text = "출발 장소"
            startPlaceTextView.textColor = .placeholderText
        }
        
        // 메뉴
        if menuTextView.text.isEmpty{
            menuTextView.text = "메뉴"
            menuTextView.textColor = .placeholderText
        }

        // 요청 사항
        if requestTextView.text.isEmpty{
            requestTextView.text = "요청사항"
            requestTextView.textColor = .placeholderText
        }
    }
    
    // 텍스트 뷰에 수정하기 시작할 때 텍스트 컬러 변경
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        // 출발 장소
        if startPlaceTextView.isSelectable{
            if startPlaceTextView.text == "출발 장소"{
                startPlaceTextView.text = nil
                startPlaceTextView.textColor = .black
            }
        }
        
        // 메뉴
        else if menuTextView.isSelectable{
            if menuTextView.text == "메뉴" {
                menuTextView.text = nil
                menuTextView.textColor = .black
            }
        }
        
        
        // 요청 사항
        else if requestTextView.isSelectable{
            if requestTextView.text == "요청사항" {
                requestTextView.text = nil
                requestTextView.textColor = .black
            }
        }

    }
    
    // 화면 터치하여 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.startPlaceTextView.endEditing(true)
    }
    
    
    
    

    // 도착장소 드롭다운
    func endplaceSetDropdown(){

        //anchorView를 통해 UI와 연결
        dropdown.anchorView = self.endPlaceDropView
        
        //View를 가리지 않고 View 아래에 Item 팝업이 붙도록 설정
        dropdown.bottomOffset = CGPoint(x: 0, y: endPlaceDropView.bounds.height)
        
    }

    // https://developer-eungb.tistory.com/34 드롭다운
    // 선택한 드롭다운을 button의 title로 설정
    func endPlaceSelectionAction(){
        dropdown.selectionAction = { [weak self] (index, item) in
            self!.endPlaceBtn.setTitle(item, for: .normal)
            self!.endPlaceBtn.tintColor = .black
        }
    }

    
    
    // 배달팁 드롭다운
    func deliveryTipSetDropdown(){

        //anchorView를 통해 UI와 연결
        dropdown.anchorView = self.deliveryTipDropView
        
        //View를 가리지 않고 View 아래에 Item 팝업이 붙도록 설정
        dropdown.bottomOffset = CGPoint(x: 0, y: deliveryTipDropView.bounds.height)
        
    }

    // https://developer-eungb.tistory.com/34 드롭다운
    // 선택한 드롭다운을 button의 title로 설정
    func deliveryTipSelectionAction(){
        dropdown.selectionAction = { [weak self] (index, item) in
            self!.deliveryTipBtn.setTitle(item, for: .normal)
            self!.deliveryTipBtn.tintColor = .black
        }
    }
}
