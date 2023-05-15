//
//  ModifyViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/12.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift
import Alamofire


class ModifyViewController: UIViewController {

    @IBOutlet weak var startPlaceTextView: UITextView! // 출발 장소 텍스트 뷰
    @IBOutlet weak var endPlaceDropView: UIView! // 도착 장소 드롭 뷰
    @IBOutlet weak var endPlaceBtn: UIButton! // 도착 장소 버튼
    @IBOutlet weak var menuTextView: UITextView! // 메뉴 텍스트 뷰
    @IBOutlet weak var requestTextView: UITextView! // 요청사항 텍스트 뷰
    @IBOutlet weak var deliveryTipDropView: UIView! // 배달팁 드롭 뷰
    @IBOutlet weak var deliveryTipBtn: UIButton! // 배달팁 버튼
    
    @IBOutlet weak var startEndTime: UIDatePicker!
    @IBOutlet weak var endEndTime: UIDatePicker!
    
    var DList : [Data] = []
    var rowNum : Int = -1
    
    var startEndTimeString = ""
    var endEndTimeString = ""
    
    let dropdown = DropDown()
    
    let endPlaceList = ["AI공학관", "가천관", "중앙도서관"]
    let deliveryTipList = ["무료", "500원", "1000원", "1500원"]
    
    @IBAction func startEndTime(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        startEndTimeString = formatter.string(from: startEndTime.date)
    }
    
    @IBAction func endEndTime(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        endEndTimeString = formatter.string(from: endEndTime.date)
    }
    
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
        
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        let param = ModifyRequest(startingPoint: startPlaceTextView.text, arrivingPoint: endPlaceBtn.currentTitle ?? "", startDeliTime: startEndTimeString, endDeliTime: endEndTimeString, menu: menuTextView.text, userWant: requestTextView.text, deliTip: deliveryTipBtn.currentTitle ?? "", userId: id, articleId: DList[rowNum].articleId)
        
        putModify(param)
        
    }
    
    func putModify(_ parameters: ModifyRequest) {
        AF.request("http://43.200.179.53:3000/modify", method: .put , parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: ModifyResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("주문서 수정 성공")
                        
                        navigationController?.popViewController(animated: true)
                        
                    }
                    
                    else{
                        print("주문서 수정 실패 \(response.message)")
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        TextViewOption()
        viewOption()

        print("수정화면 DList: ", DList)
        print("수정화면 RowNum: ", rowNum)
        
        
        startPlaceTextView.text = DList[rowNum].startingPoint
        endPlaceBtn.setTitle(DList[rowNum].arrivingPoint, for: .normal)
        endPlaceBtn.tintColor = .black
        
        menuTextView.text = DList[rowNum].menu
        requestTextView.text = DList[rowNum].userWant
        deliveryTipBtn.setTitle(DList[rowNum].deliTip, for: .normal)
        deliveryTipBtn.tintColor = .black
 
//        // 작성된 시간으로 데이트 피커 설정 완료
//        let calendar = Calendar.current
//        var startComponents = DateComponents()
//        var endComponents = DateComponents()
//
//        startComponents.hour = DList[rowNum].startDeliTime / 100
//        startComponents.minute = DList[rowNum].startDeliTime % 100
//        startEndTime.setDate(calendar.date(from: startComponents)!, animated: false)
//
//        endComponents.hour = DList[rowNum].endDeliTime / 100
//        endComponents.minute = DList[rowNum].endDeliTime % 100
//        endEndTime.setDate(calendar.date(from: endComponents)!, animated: false)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        
        print("여기")
        print("rownum: \(self.rowNum)")
        print("data: \(DList)")
        let startTime = formatter.date(from: DList[rowNum].startDeliTime)
        print(startTime)
        startEndTime.setDate(startTime!, animated: false)
        
        let endTime = formatter.date(from: DList[rowNum].endDeliTime)
        endEndTime.setDate(endTime!, animated: false)
        
        
        //키보드 올라가면 화면 위로 밀기
        IQKeyboardManager.shared.enable = true
        //키보드 위에 Toolbar 없애기
        IQKeyboardManager.shared.enableAutoToolbar = false
        //키보드 밖 화면 터치 시 키보드 내려감
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

    }
    
    func viewOption(){
        // 배달 장소 드롭뷰
        endPlaceDropView.layer.borderWidth = 1
        endPlaceDropView.layer.cornerRadius = 5
        endPlaceDropView.layer.borderColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 0.17).cgColor
        
        // 배달팁 드롭뷰
        deliveryTipDropView.layer.borderWidth = 1
        deliveryTipDropView.layer.cornerRadius = 5
        deliveryTipDropView.layer.borderColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 0.17).cgColor
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
        startPlaceTextView.textColor = .black
        menuTextView.textColor = .black
        requestTextView.textColor = .black
        
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

extension ModifyViewController: UITextViewDelegate {
    
    // 텍스트 뷰에 수정하기 시작할 때 텍스트 컬러 변경
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "출발 장소" || textView.text == "메뉴" || textView.text == "요청사항" {
            textView.text = nil
            textView.textColor = .black
        }
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
    
    //textView 높이 조절
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        
        textView.constraints.forEach { constraint in
            //최소 높이 지정
            if estimatedSize.height > 40 {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
            
        }
    }
}
