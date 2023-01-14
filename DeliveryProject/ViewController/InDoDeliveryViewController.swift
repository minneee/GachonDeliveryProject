//
//  InDoDeliveryViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2022/12/29.
//

import UIKit
import DropDown

class InDoDeliveryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let startPlaceList = ["아메아메", "아토", "이삭토스트","아메아메", "아토", "이삭토스트","아메아메", "아토", "이삭토스트","아메아메", "아토", "이삭토스트","아메아메", "아토", "이삭토스트","아메아메", "아토", "이삭토스트"]
    let startTimeList = ["1시", "2시", "3시", "1시", "2시", "3시","1시", "2시", "3시","1시", "2시", "3시","1시", "2시", "3시","1시", "2시", "3시"]
    let deliveryTipList = ["무료", "500원", "1000원","무료", "500원", "1000원","무료", "500원", "1000원","무료", "500원", "1000원","무료", "500원", "1000원","무료", "500원", "1000원"]
    let endPlaceList = ["AI공학관", "가천관", "중앙도서관","AI공학관", "가천관", "중앙도서관","AI공학관", "가천관", "중앙도서관","AI공학관", "가천관", "중앙도서관","AI공학관", "가천관", "중앙도서관","AI공학관", "가천관", "중앙도서관"]
    
    @IBOutlet weak var startPlaceText: UITextField! // 출발 장소
    @IBOutlet weak var endTimeText: UITextField! // 도착 시간
    
    
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
    let itemList = ["AI공학관", "가천관", "중앙도서관"]
    let deliveryTip = ["무료", "500원", "1000원", "1500원"]
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""

        listTable.dataSource = self
        listTable.delegate = self
        
        viewOption()
        
  //      initUI()

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return startPlaceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! DeliveryListTableViewCell
        
        cell.startPlace.text = startPlaceList[indexPath.row]
        cell.startTime.text = startTimeList[indexPath.row]
        cell.endPlace.text = endPlaceList[indexPath.row]
        cell.deliveryTip.text = deliveryTipList[indexPath.row]
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 194/255, green: 209/255, blue: 255/255, alpha: 0.5)
        cell.selectedBackgroundView = view
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        // 화면 이동
        guard let orderVC = storyboard?.instantiateViewController(withIdentifier: "OrderViewVC") else {return}
        self.navigationController?.pushViewController(orderVC, animated: true)

    }
    

}
