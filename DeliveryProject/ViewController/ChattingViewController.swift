
import UIKit
import Alamofire
import IQKeyboardManagerSwift
import DropDown
import SocketIO


class ChattingViewController: UIViewController {
    
    let dropdown = DropDown()
    
    // 메뉴 드롭다운 리스트 
    let dropdownList = ["사용자 신고하기", "채팅방 나가기", "배달 완료"]
    
    
    @IBOutlet weak var announcementView: UIView!
    
    @IBOutlet weak var chattingTableView: UITableView!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var chattingBarView: UIView!
    
    @IBOutlet weak var bottomConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var chattingMenuImageView: UIImageView!
    
    @IBOutlet weak var chattingTextView: UITextView!
    
    @IBOutlet weak var sendMessageButton: UIButton!
    
    
    var speechBubbleList: [String] = ["hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //채팅창 공지 뷰 모서리 둥글게하기
        announcementView.layer.cornerRadius = 8
        
        // 텍스트 뷰 테두리 설정
        chattingTextView.layer.borderWidth = 1
        chattingTextView.layer.borderColor = UIColor.systemGray5.cgColor
        chattingTextView.layer.cornerRadius = 8
        
        //키보드 올라오면 화면도 같이 올라가도록 만들기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidenHandle), name: UIResponder.keyboardWillHideNotification, object: nil)

        //키보드 올라가면 화면 위로 밀기 (이건 전체가 올라가서 지금 사용 x)
//        IQKeyboardManager.shared.enable = true
        
        //키보드 위에 Toolbar 없애기
        IQKeyboardManager.shared.enableAutoToolbar = false
        //키보드 밖 화면 터치 시 키보드 내려감
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
       
        //테이블뷰 오토레이아웃을 위한 설정
        chattingTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //네비게이션 바 없애기
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //텍스트 뷰 delegate
        self.chattingTextView.delegate = self
        
        //테이블 뷰 설정
        self.chattingTableView.delegate = self
        self.chattingTableView.dataSource = self
        
        //cell 최소 높이
        chattingTableView.estimatedRowHeight = 50
        //50 이상일 때 동적 높이
        chattingTableView.rowHeight = UITableView.automaticDimension
        //테이블뷰 구분 선 없애기
        chattingTableView.separatorStyle = .none
        
        //테이블 뷰 셀 nib파일 가져오기
        self.chattingTableView.register(UINib(nibName: "ChattingTableViewMyCell", bundle: nil),  forCellReuseIdentifier: "ChattingTableViewMyCell")
        self.chattingTableView.register(UINib(nibName: "ChattingTableViewYourCell", bundle: nil),  forCellReuseIdentifier: "ChattingTableViewYourCell")
        
        
        // 뒤로가기 이미지 버튼을 클릭했을 때
        self.backImageView.isUserInteractionEnabled = true
        self.backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        
        // 채팅 설정 이미지 버튼 클릭했을 때
        self.chattingMenuImageView.isUserInteractionEnabled = true
        self.chattingMenuImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.chattingMenu)))
        
        
//        //스크롤?
//        for _ in 0...20 {
//            speechBubbleList.append("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq")
//        }
//        let indexPath = IndexPath(row: speechBubbleList.count - 1, section: 0)
//        //tableview 삽입
//        self.chattingTableView.beginUpdates()
//        self.chattingTableView.setContentOffset(self.chattingTableView.contentOffset, animated: true)
//        self.chattingTableView.insertRows(at: [indexPath], with: .bottom)
//        self.chattingTableView.endUpdates()
        
//        let indexPath = IndexPath(row: speechBubbleList.count - 1, section: 0)
//        self.chattingTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //네비게이션 바 없애기
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //채팅창 tableView 제일 아래로 내리기
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let indexPath = IndexPath(row: self.speechBubbleList.count - 1, section: 0)
            self.chattingTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
      }
    
    
    
    @objc func keyboardWillShowHandle(notification:NSNotification) {
        //키보드 높이 가져오기
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardHeight = keyboardFrame.cgRectValue.height
        print("🔊[DEBUG]: 올라온 키보드 높이 \(keyboardHeight)")
        
        // 키보드 높이 구하고
        // 키보드 높이 만큼 constraints를 변경해준다.
        
        // [weak self] 는 레퍼런스 카운트 때문에
        // 클로저 내부에서 self 사용해야 되는 경우...
        // 이거는 좀 찾아봐봐
        UIView.animate(withDuration: 0.25, delay: 0.0) { [weak self] in
            guard let self = self else { return }
            //bottomConstraints 변경
            self.bottomConstraints.constant = self.bottomConstraints.constant + keyboardHeight + (UIDevice.current.hasNotch ? -32 : 0)
        }
        self.view.layoutIfNeeded()
        
        //채팅창 가장 아래로 내리기
        let indexPath = IndexPath(row: self.speechBubbleList.count - 1, section: 0)
        self.chattingTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    @objc func keyboardWillHidenHandle() {
        //뷰 원래 위치로
        print("🔊[DEBUG]: 내려옴")
        // 내려올 때는 키보드 높이는 0이 되니까 설정해준 constraints를 0으로 변경 = 원래대로
        UIView.animate(withDuration: 0.25, delay: 0.0) { [weak self] in
            guard let self = self else { return }
            //bottomConstraints 변경
            self.bottomConstraints.constant = 0
        }
        self.view.layoutIfNeeded()
    }
    
    
    // 뒤로가기 이미지 버튼을 클릭했을 때
    @objc func viewTapped(_sender: UITapGestureRecognizer){
        self.navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    // 채팅 설정 이미지뷰 함수
    @objc func chattingMenu(_sender: UITapGestureRecognizer){
        dropdown.dataSource = dropdownList
        chattingSetDropdown()
        
        dropdown.show()
        
        dropdown.selectionAction = { [weak self] (index, item) in
            
            switch index{
            case 0:
                print("신고하기")
                guard let reportVC = self?.storyboard?.instantiateViewController(identifier: "ReportViewController") else { return }
//                reportVC.otherUserNickName = 상대 닉네임 보내줘야 함
                self?.navigationController?.pushViewController(reportVC, animated: true)
                
            case 1:
                print("채팅방 나가기")
                guard let chattingListVC = self?.storyboard?.instantiateViewController(identifier: "ChattingListViewController") else { return }
                self?.navigationController?.pushViewController(chattingListVC, animated: true)
            case 2:
                print("배달 완료")
                guard let starScoreVC = self?.storyboard?.instantiateViewController(identifier: "StarScoreViewController") else { return }
                self?.navigationController?.pushViewController(starScoreVC, animated: true)
                
                
            
            default:
                print("switch : default")
            }
        }
        
    }
    
    
    // 채팅 설정  드롭다운
    func chattingSetDropdown(){

        //anchorView를 통해 UI와 연결
        dropdown.anchorView = self.chattingMenuImageView
        dropdown.backgroundColor = .white
        
        //View를 가리지 않고 View 아래에 Item 팝업이 붙도록 설정
       dropdown.bottomOffset = CGPoint(x: -100, y: chattingMenuImageView.bounds.height)
//        dropdown.trailingAnchor.constraint(equalTo: chattingMenuImageView.bounds.width).isActive = true
//        dropdown.topAnchor.constraint(equalTo: chattingMenuImageView.bounds.height).isActive = true

    }
    
    
    
    
    // https://developer-eungb.tistory.com/34 드롭다운
//    func placeSelectionAction(){
//        dropdown.selectionAction = { [weak self] (index, item) in
//            self!.placeButton.setTitle(item, for: .normal)
//            self!.placeButton.tintColor = .black
//            self!.placeImg.image = UIImage.init(systemName: "arrowtriangle.up.fill")
//            self!.placeImg.image?.withTintColor(.black)
////            self?.placeButton.tintColor = .black
//        }
//    }
    
  
}
/*
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.message.count + 2
        return ChatViewController.message.count
        //viewModel.chatInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let chatMessage = ChatViewController.message[indexPath.row]
        if chatMessage.isPhoto == false && chatMessage.isSchedule == false {
            
            if chatMessage.userName == "본의" {
                if chatMessage.emoticon != nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MyPhotoMessageTableViewCell", for: indexPath) as! MyPhotoMessageTableViewCell
                    cell.selectionStyle = .none
                    cell.mySendImage.image = chatMessage.emoticon!
                    cell.timeLabel.text = chatMessage.sendTime
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageTableViewCell", for: indexPath) as! MyMessageTableViewCell
                    cell.myMessageLabel.text = chatMessage.message
                    cell.timeLabel.text = chatMessage.sendTime
                    cell.selectionStyle = .none
                    return cell
                }
                
                
            } else {
                
                if chatMessage.emoticon != nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyPhotoMessageTableViewCell", for: indexPath) as! FamilyPhotoMessageTableViewCell
                    cell.timeLabel.text = chatMessage.sendTime
                    cell.selectionStyle = .none
                    return cell
                } else {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyMessageTableViewCell", for: indexPath) as! FamilyMessageTableViewCell
                    cell.nameLabel.text = chatMessage.userName
                    cell.messageLabel.text = chatMessage.message
                    cell.profileImage.image = UIImage(named: chatMessage.userProfile)
                    cell.timeLabel.text = chatMessage.sendTime
                    cell.selectionStyle = .none
                    return cell
                }
            }
        } else if chatMessage.isPhoto == true && chatMessage.isSchedule == false {
            if chatMessage.userName == "본의" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyPhotoMessageTableViewCell", for: indexPath) as! MyPhotoMessageTableViewCell
                cell.selectionStyle = .none
                cell.mySendImage.image = chatMessage.photo
                cell.timeLabel.text = chatMessage.sendTime
                return cell
                
                
            } else {
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyPhotoMessageTableViewCell", for: indexPath) as! FamilyPhotoMessageTableViewCell
                cell.familySendImage.image = chatMessage.photo
                cell.timeLabel.text = chatMessage.sendTime
                cell.nameLabel.text = chatMessage.userName
                cell.profileImage.image = UIImage(named: chatMessage.userProfile)
                cell.selectionStyle = .none
                return cell
                
            }
        } else if chatMessage.isSchedule == true {
            if chatMessage.userName == "본의" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyScheduleTableViewCell", for: indexPath) as! MyScheduleTableViewCell
                cell.selectionStyle = .none
                cell.scheduleTitleLabel.text = chatMessage.scheduleTitle
                cell.startDateLabel.text = chatMessage.scheduleDate
                cell.sendTimeLabel.text = chatMessage.sendTime
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyScheduleTableViewCell", for: indexPath) as! FamilyScheduleTableViewCell
                cell.selectionStyle = .none
                return cell
            }
        }
        
        
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageTableViewCell", for: indexPath) as! MyMessageTableViewCell
            cell.myMessageLabel.text = chatMessage.message
            cell.timeLabel.text = chatMessage.sendTime
            cell.selectionStyle = .none
            return cell
        }
        
        
    }
    
    
}

*/


//tableView
extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speechBubbleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let userCell = tableView.dequeueReusableCell(withIdentifier: "ChattingTableViewYourCell", for: indexPath) as! ChattingTableViewYourCell

            userCell.speechYourDateLabel.text = "2022.12.25"
            userCell.speechYourLabel.text = speechBubbleList[indexPath.row]

            return userCell
        }
        else {
            let userCell = tableView.dequeueReusableCell(withIdentifier: "ChattingTableViewMyCell", for: indexPath) as! ChattingTableViewMyCell

            userCell.speechDateLabel.text = "2022.12.25"
            userCell.speechLabel.text = speechBubbleList[indexPath.row]

            return userCell
        }
        
        
    }
    
   
}

extension UIDevice {
  var hasNotch: Bool {
    let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    return bottom > 0
  }
}
var count = 0

extension ChattingViewController: UITextViewDelegate {
    //textView 높이 조절
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { constraint in
            //최소(40), 최대(100) 높이 지정
            if estimatedSize.height > 40 && estimatedSize.height <= 100 {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
            //다시 줄어들었을 때 높이 지정
            else if estimatedSize.height <= 40 {
                constraint.constant = 40
            }
        }

        let indexPath = IndexPath(row: self.speechBubbleList.count - 1, section: 0)
        self.chattingTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
}
