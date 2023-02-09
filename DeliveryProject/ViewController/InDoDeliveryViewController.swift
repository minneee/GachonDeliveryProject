//
//  InDoDeliveryViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2022/12/29.
//

import UIKit
import DropDown
import Alamofire

class InDoDeliveryViewController: UIViewController, UITextFieldDelegate{

    var startPlaceList: [String] = []
    var startTimeList: [String] = []
    var endTimeList: [String] = []
    var deliveryTipList: [String] = []
    var endPlaceList: [String] = []
    
    var dataList : [Data] = []
    @IBOutlet weak var startPlaceText: UITextField! // 출발 장소
    @IBOutlet weak var endTimeText: UITextField! // 도착 시간
    
    // 도착 시간 View
    @IBOutlet weak var endTimeView: UIView!
    @IBOutlet weak var endTimeMinute: UITextField!
    @IBOutlet weak var endTimeHour: UITextField!
    
    // 도착 장소 outlet
    @IBOutlet weak var placeButton: UIButton!
    @IBOutlet weak var placeImg: UIImageView!
    @IBOutlet weak var placeDropView: UIView!
    
    // 배달팁 outlet
    @IBOutlet weak var tipDropView: UIView!
    @IBOutlet weak var tipButton: UIButton!
    @IBOutlet weak var tipImg: UIImageView!
    
    
    // 배달 리스트 테이블
    @IBOutlet weak var listTable: UITableView!
    
    
    // DropDown 객체 생성
    let dropdown = DropDown()
    
    // DropDown 아이템 리스트
    let itemList = ["전체", "AI공학관", "가천관", "중앙도서관"]
    let deliveryTip = ["전체", "배달팁 높은 순", "배달팁 낮은 순"]
    
    // 검색 버튼
    @IBAction func SearchButton(_ sender: UIButton) {
        
        
        var deliTip : String?
        if tipButton.currentTitle == "배달팁 높은 순" {
            deliTip = "desc"
        }else if tipButton.currentTitle == "배달팁 낮은 순"{
            deliTip = "asc"
        }
        
        
        var startingPoint : String? = startPlaceText.text
        var arrivingPoint : String? = placeButton.currentTitle
        var endDeliTime : String? = (endTimeHour.text ?? "") + (endTimeMinute.text ?? "")
        
        
        if (placeButton.currentTitle ==  "전체") || (placeButton.currentTitle == "도착 장소"){
            placeButton.setTitle(nil, for: .normal)
            print(" 도착 장소:",  placeButton.currentTitle ?? "")
            placeButton.setTitle("도착 장소", for: .normal)
            placeButton.tintColor = .systemGray4
            arrivingPoint = nil
        }
        
        if (tipButton.currentTitle == "전체") || (tipButton.currentTitle == "배달팁"){
            tipButton.setTitle(nil, for: .normal)
            print("팁: ", tipButton.currentTitle ?? "")
            tipButton.setTitle("배달팁 ", for: .normal)
            tipButton.tintColor = .systemGray4
            endDeliTime = nil
        }
        
        if (startPlaceText.text == ""){
            startingPoint = nil
        }


        
 
        
        print("deliTip : ", deliTip)
        print("startingPoint : ", startingPoint)
        print("arrivingPoint : ", arrivingPoint)
        print("endDeliTime : ", endDeliTime )
        
        
        let param = BoardRequesst(deliTip: deliTip, startingPoint: startingPoint, arrivingPoint: arrivingPoint, endDeliTime: Int(endDeliTime ?? ""))
        
        postOrderList(param)
        
        // viewWillAppear(true)
       

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""

        listTable.dataSource = self
        listTable.delegate = self
        
        endTimeHour.delegate = self
        endTimeMinute.delegate = self
        
        viewOption()
        
        getOrderList()
  //      initUI()

    }
    
    @IBAction func placeButton(_ sender: UIButton) {
        
        //dataSource로 ItemList 연결
        dropdown.dataSource = itemList
        
        dropdown.show()
        placeSetDropdown()
        placeSelectionAction()
    }
    
    @IBAction func tipButton(_ sender: UIButton) {
        dropdown.dataSource = deliveryTip
        
        dropdown.show()
        tipSetDropdown()
        tipSelectionAction()
    }
    
    
    
    // 버튼 테두리 설정
    func viewOption(){
        // 배달 장소 드롭뷰
        placeDropView.layer.borderWidth = 1
        placeDropView.layer.cornerRadius = 5
        placeDropView.layer.borderColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 0.17).cgColor
        
        // 배달팁 드롭뷰
        tipDropView.layer.borderWidth = 1
        tipDropView.layer.cornerRadius = 5
        tipDropView.layer.borderColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 0.17).cgColor
        
        // 도착시간 드롭뷰
        endTimeView.layer.borderWidth = 1
        endTimeView.layer.cornerRadius = 5
        endTimeView.layer.borderColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 0.17).cgColor
    }
    
    // DropDown UI 커스텀
//    func initUI(){
//
////        placeDropView.backgroundColor = .blue
//
//        dropdown.dataSource = itemList
//        dropdown.show()
//        DropDown.appearance().textColor = .black
//        DropDown.appearance().backgroundColor = .white
//        DropDown.appearance().selectionBackgroundColor = .lightGray
//        // 팝업을 닫을 모드 설정
//        dropdown.dismissMode = .automatic
//
//        placeImg.tintColor = .gray
//    }
    
    // 도착 시간 드롭다운
    func placeSetDropdown(){

        //anchorView를 통해 UI와 연결
        dropdown.anchorView = self.placeDropView
        
        //View를 가리지 않고 View 아래에 Item 팝업이 붙도록 설정
        dropdown.bottomOffset = CGPoint(x: 0, y: placeDropView.bounds.height)
    }
    
    
    // https://developer-eungb.tistory.com/34 드롭다운 
    func placeSelectionAction(){
        dropdown.selectionAction = { [weak self] (index, item) in
            
            self!.placeButton.setTitle(item, for: .normal)
            self!.placeButton.tintColor = .black
            self!.placeImg.image = UIImage.init(systemName: "arrowtriangle.up.fill")
            self!.placeImg.image?.withTintColor(.black)
//            self?.placeButton.tintColor = .black
        }
    }
    
    
    // 배달팁 드롭다운
    func tipSetDropdown(){

        //anchorView를 통해 UI와 연결
        dropdown.anchorView = self.tipDropView
        
        //View를 가리지 않고 View 아래에 Item 팝업이 붙도록 설정
        dropdown.bottomOffset = CGPoint(x: 0, y: tipDropView.bounds.height)
    }
    
    
    // https://developer-eungb.tistory.com/34 드롭다운
    func tipSelectionAction(){
        dropdown.selectionAction = { [weak self] (index, item) in
            self!.tipButton.setTitle(item, for: .normal)
            self!.tipButton.tintColor = .black
            self!.tipImg.image = UIImage.init(systemName: "arrowtriangle.up.fill")
            self!.tipImg.image?.withTintColor(UIColor.black)
        }
    }
    
    
    

}

extension InDoDeliveryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return startPlaceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! DeliveryListTableViewCell
        
        var startDeliTime = startTimeList[indexPath.row]
        startDeliTime.insert(":", at: startDeliTime.index(startDeliTime.startIndex, offsetBy: 2))
        
        var endDeliTime = endTimeList[indexPath.row]
        endDeliTime.insert(":", at: endDeliTime.index(endDeliTime.startIndex, offsetBy: 2))
        
        cell.startPlace.text = startPlaceList[indexPath.row]
        cell.endPlace.text = endPlaceList[indexPath.row]
        cell.startTime.text = startDeliTime + " ~ " + endDeliTime
        cell.deliveryTip.text = deliveryTipList[indexPath.row]
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 194/255, green: 209/255, blue: 255/255, alpha: 0.5)
        cell.selectedBackgroundView = view
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 화면 이동
        guard let orderVC = storyboard?.instantiateViewController(withIdentifier: "OrderViewVC") as? OrderViewController else {return}
        
        orderVC.rowNum = indexPath.row
        orderVC.DList = dataList
        print("rowNum :", orderVC.rowNum)
        
        self.navigationController?.pushViewController(orderVC, animated: true)

    }
    
    
    // 텍스트 필드 글자 수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let endTimeHourCount = (endTimeHour.text?.appending(string).count ?? 0) - 1
        let endTimeMinuteCount = (endTimeMinute.text?.appending(string).count ?? 0) - 1
        
        // 도착 시간 Hour
        if textField.text == endTimeHour.text{
            
            if (endTimeHourCount > 1){
                return false
            } else{
                return true
            }
            
        } else if (textField.text == endTimeMinute.text){
    
            // 도착 시간 Minute
            if (endTimeMinuteCount > 1){
                return false
            } else{
                return true
            }
        }
        return true
        
    }
    
    // 전체 주문서 목록
    func getOrderList () {
        AF.request("http://3.37.209.65:3000/board", method: .get, headers: nil)
            .validate()
            .responseDecodable(of: OrderListResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("주문목록 조회 성공")
                                                
                         dataList = response.data
                        if dataList.count > 0 {
                            for i in 0...(dataList.count - 1) {
                                startPlaceList.append(dataList[i].startingPoint)
                                endPlaceList.append(dataList[i].arrivingPoint)
                                startTimeList.append(String(dataList[i].startDeliTime))
                                endTimeList.append(String(dataList[i].endDeliTime))
                                deliveryTipList.append(dataList[i].deliTip)
                                
                            }
                        }
                        listTable.reloadData()
                        
                    }
                    
                    else{
                        print("주문목록 조회 실패\(response.message)")
                        //alert message
                        let loginFailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        
                        let loginFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                        loginFailAlert.addAction(loginFailAction)
                        self.present(loginFailAlert, animated: true, completion: nil)
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    print("서버 통신 실패")
                    let loginFailAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
                    
                    let loginFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    loginFailAlert.addAction(loginFailAction)
                    self.present(loginFailAlert, animated: true, completion: nil)
                }
                
            }
    }
    
    // 검색 주문서 목록
    func postOrderList (_ parameters: BoardRequesst) {
        AF.request("http://3.37.209.65:3000/board", method: .post, headers: nil)
            .validate()
            .responseDecodable(of: BoardResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("검색 조회 성공")
                        
                                                
                         dataList = response.data
                        if dataList.count > 0 {
                            for i in 0...(dataList.count - 1) {
                                startPlaceList.append(dataList[i].startingPoint)
                                endPlaceList.append(dataList[i].arrivingPoint)
                                startTimeList.append(String(dataList[i].startDeliTime))
                                endTimeList.append(String(dataList[i].endDeliTime))
                                deliveryTipList.append(dataList[i].deliTip)
                                
                            }
                        }
                        listTable.reloadData()
                        
                        print(dataList)
                        viewWillAppear(true)
                    }
                    
                    else{
                        print("검색 조회 실패\(response.message)")
                        //alert message
                        let loginFailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        
                        let loginFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                        loginFailAlert.addAction(loginFailAction)
                        self.present(loginFailAlert, animated: true, completion: nil)
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    print("서버 통신 실패")
                    let loginFailAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
                    
                    let loginFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    loginFailAlert.addAction(loginFailAction)
                    self.present(loginFailAlert, animated: true, completion: nil)
                }
                
            }
    }
    
}

