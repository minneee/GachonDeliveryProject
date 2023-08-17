
import UIKit
import Alamofire
import IQKeyboardManagerSwift
import DropDown
import SocketIO



class ChattingViewController: UIViewController {
    
    let dropdown = DropDown()
    
    // 메뉴 드롭다운 리스트 
    let dropdownList = ["사용자 신고하기", "채팅방 나가기", "배달 완료"]
    
    // 상대방 아이디, 닉네임
    var otherUserId : String = ""
    var otherUserNickname = ""
    
    // 배달하는 사람 아이디, 닉네임
    var deliverId : String = ""
    var deliverNickname = ""
    
    
    var myNickname : String = ""
    
    var roomId : Int = -1
    
    var articleId : Int = -1
    
    
    // Message 구조체를 저장할 배열 생성
    var speechBubbleList: [Message] = []
    
//    // 이전 대화를 저장할 배열 생성
//    var chatRecordList : [Message] = []
    
    
    // 채팅 메시지 구조체 생성
    struct Message {
        let content : String
        let roomId : Int
        let nickname : String
        var isMyMessage : Bool
        let sendTime : String
        
        init(content : String, isMyMessage : Bool, roomId : Int, nickname : String, sendTime : String){
            self.content = content
            self.isMyMessage = isMyMessage
            self.nickname = nickname
            self.roomId = roomId
            self.sendTime = sendTime
        }
        

        init?(data: [String : sendMessageStruct]){
            let msginput = data["message"]?.msginput as? String
            let roomId = data["message"]?.roomId as? Int
            let nickname = data["message"]?.nickname as? String
            let isMyMessage = data["message"]?.isMyMessage as? Bool
            let sendTime = data["message"]?.sendTime as? String
            
            
            self.content = msginput ?? ""
            self.roomId = roomId ?? -1
            self.nickname = nickname ?? ""
            self.isMyMessage = isMyMessage ?? false
            self.sendTime = sendTime ?? ""
        }
        
//        init? (data: chatRecordData){
//            let msginput = data.msg
//            let nickname = data.nickname
//
//
//            self.content = msginput
//            self.nickname = nickname
//            self.roomId = roomId
//            self.isMyMessage = false
//            self.sendTime = data.sendDay
//        }
        
        
    }
    
    
    
    // 메시지 전송 시 value 형태
    struct sendMessageStruct{
        let msginput : String
        let roomId : Int
        let nickname : String
        var isMyMessage : Bool
        let sendTime : String
    }
    
    
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
    
    @IBOutlet weak var proflieImage: UIImageView!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var introduceLabel: UILabel!
    
    @IBOutlet weak var receiveScore: UIImageView!
    
    @IBOutlet weak var deliveryScore: UIImageView!
    
    
    
//    var speechBubbleList: [String] = ["hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 "]
    
    
    

    
    
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
        
        //소켓 오픈
        ChattingSocketIOManager.shared.socket.connect()
        //메시지 표시
        receiveMessage()
        chattingTableView.reloadData()
        
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
        
        print(otherUserId)
        
        // roomId 찾기
        let id = UserDefaults().string(forKey: "id") ?? ""
        let param2 = FindChatRoomRequest(myUserId: id , otherUserId: otherUserId, deliverId: deliverId, articleId: articleId)
        postFindChatRoom(param2)
        
        // completion Handler를 이용
//        postFindChatRoom(param2){
//            // 과거 채팅 내역 불러오기
//            let param = ChatRecordRequest(roomId: roomId)
//            postChatRecord(param)
//        }
        
        // 상대 프로필 가져오기
        let param1 = ProfileRequest(userId: otherUserId)
        postGetProfileImage(param1)
        
        
        // 과거 채팅 내역 불러오기
        let param = ChatRecordRequest(roomId: roomId)
        postChatRecord(param)
        
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
    
    //메시지 보내기 버튼
    @IBAction func sendMessageButtonAction(_ sender: Any) {
//        sendMessage(msginput: chattingTextView.text ?? "", roomName: "채팅방1", nickname: "미니"))
        
        
        // 메시지를 보내는 시간을 받아서 같이 넘김
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        
        let sendTime = dateFormatter.string(from: currentDate)
        print("sendTime : ", sendTime)
        
        
        sendMessage(msginput: chattingTextView.text ?? "", roomId: roomId, nickname: myNickname, isMyMessage: true, sendTime: sendTime)
        
        
        chattingTableView.reloadData()
        chattingTextView.text = ""
        print("🌟")
        
    }
    
    //메시지 보내기
    func sendMessage(msginput: String, roomId: Int, nickname: String, isMyMessage : Bool, sendTime : String) {
        var messageInfo = sendMessageStruct(msginput: msginput, roomId: roomId, nickname: nickname, isMyMessage: isMyMessage, sendTime: sendTime)
        
        // 자신이 메시지를 보내는 것이기 때문에 isMyMessage를 true로 설정
        messageInfo.isMyMessage = true
        
        ChattingSocketIOManager.shared.socket.emit("message", messageInfo as! SocketData)
    }
    
    
    //받은 메시지 보기
    func receiveMessage() {
        ChattingSocketIOManager.shared.socket.on("message") { dataArray, ack in
            print("👀\(dataArray)")
            var chat = type(of: dataArray)
            print(chat)
//            self.speechBubbleList.append("\(dataArray[0] as! String): \(dataArray[1] as! String)")
            
            guard let messageData = dataArray[0] as? [String : sendMessageStruct],
                  var message = Message(data: messageData) else { return }
            
            // 받은 메시지이기 때문에 isMyMessage를 false로 설정
            message.isMyMessage = false
            

            self.speechBubbleList.append(message)
            self.chattingTableView.reloadData()
            
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
                guard let reportVC = self?.storyboard?.instantiateViewController(identifier: "ReportViewController") as? ReportViewController else { return }
//                reportVC.otherUserNickName = 상대 닉네임 보내줘야 함
                reportVC.otherUserNickName = self?.otherUserNickname ?? ""
                self?.navigationController?.pushViewController(reportVC, animated: true)
                
            case 1:
                print("채팅방 나가기")
                guard let chattingListVC = self?.storyboard?.instantiateViewController(identifier: "ChattingListViewController") else { return }
                self?.navigationController?.pushViewController(chattingListVC, animated: true)
            case 2:
                print("배달 완료")
                guard let starScoreVC = self?.storyboard?.instantiateViewController(identifier: "StarScoreViewController") as? StarScoreViewController else { return }
                
                let id = UserDefaults.standard.string(forKey: "id") ?? ""
                
                // 배달 완료 API
                let param3 = EndDeliveryRequest(nickname: self!.deliverNickname, articleId: self!.articleId )
                
                self?.postEndDelivery(param3)
                
                // starScoreVC에 자신의 닉네임 전달 
                starScoreVC.myNickname = self?.myNickname ?? ""
                starScoreVC.otherNickname = self?.otherUserNickname ?? ""
                
                
                // 내 아이디와 deliverId가 같다면 자신이 배달원 -> StarScoreVC의 deliverNickname에 자신의 닉네임 전달
                if( id == self?.deliverId){
                    starScoreVC.deliverNickname = self?.myNickname ?? ""
                } else{
                    starScoreVC.deliverNickname = self?.otherUserNickname ?? ""
                }
                
                self?.navigationController?.pushViewController(starScoreVC, animated: true)
                
                
            
            default:
                print("switch : default")
            }
        }
        
    }
    
    func postChatRecord(_ parameters: ChatRecordRequest) {
        AF.request("http://3.37.209.65:3000/record", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: ChatRecordResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("👀\(String(describing: response.data))")
                        
                        
                        for i in response.data! {
                            
                            // 이전 채팅 기록의 닉네임을 자신의 닉네임과 비교하여 isMyMessage를 구분
                            var isMyMessage = true
                            if(i.nickname != myNickname){
                                isMyMessage = false
                            }
                            
                            // Message 구조체 타입의 인스턴스 생성
                            let msg = Message(content: i.msg, isMyMessage: isMyMessage, roomId: roomId, nickname: i.nickname, sendTime: i.sendDay)
                            
                            // 이전 채팅 기록을 저장
                            speechBubbleList.append(msg)
                            print("😀\(i.msg)")
                        }
                        
                        
                        chattingTableView.reloadData()
                        
                
                    }
                    
                    else{
                        print("채팅 불러오기 실패\(response.message)")
                        //alert message
                        let FailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        
                        let FailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                        FailAlert.addAction(FailAction)
                        self.present(FailAlert, animated: true, completion: nil)
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    print("서버 통신 실패")
                    let FailAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
                    
                    let FailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    FailAlert.addAction(FailAction)
                    self.present(FailAlert, animated: true, completion: nil)
                }
                
                
                
            }
    }
    
    func postFindChatRoom(_ parameters: FindChatRoomRequest) {
        AF.request("http://3.37.209.65:3000/find-room", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: FindChatRoomResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        otherUserNickname = response.otherUserData?.nickname ?? ""
                        nicknameLabel.text = response.otherUserData?.nickname
                        introduceLabel.text = response.otherUserData?.introduce
                        
                        // 배달원 닉네임 설정
                        deliverNickname = response.deliverNickname
                        
                        // 내 닉네임 설정
                        myNickname = response.myData.nickname
                        
                        // articleId 설정
                        articleId = response.articleId
                        
                        switch response.otherUserData?.orderRate ?? 0 {
                        case 0: receiveScore.image = UIImage(named: "PinwheelPoint0")
                        case 1: receiveScore.image = UIImage(named: "PinwheelPoint1")
                        case 2: receiveScore.image = UIImage(named: "PinwheelPoint2")
                        case 3: receiveScore.image = UIImage(named: "PinwheelPoint3")
                        case 4: receiveScore.image = UIImage(named: "PinwheelPoint4")
                        case 5: receiveScore.image = UIImage(named: "PinwheelPoint5")
                        default: receiveScore.image = UIImage(named: "PinwheelPoint0")
                        }
                        
                        switch response.otherUserData?.deliveryRate ?? 0 {
                        case 0: deliveryScore.image = UIImage(named: "PinwheelPoint0")
                        case 1: deliveryScore.image = UIImage(named: "PinwheelPoint1")
                        case 2: deliveryScore.image = UIImage(named: "PinwheelPoint2")
                        case 3: deliveryScore.image = UIImage(named: "PinwheelPoint3")
                        case 4: deliveryScore.image = UIImage(named: "PinwheelPoint4")
                        case 5: deliveryScore.image = UIImage(named: "PinwheelPoint5")
                        default: deliveryScore.image = UIImage(named: "PinwheelPoint0")
                        }
                        
                        
                        roomId = response.roomId ?? -1
                    }
                    
                    else{
                        print("채팅방 찾기 실패\(response.message)")
                        //alert message
                        let FailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        
                        let FailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                        FailAlert.addAction(FailAction)
                        self.present(FailAlert, animated: true, completion: nil)
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    print("서버 통신 실패")
                    let FailAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
                    
                    let FailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    FailAlert.addAction(FailAction)
                    self.present(FailAlert, animated: true, completion: nil)
                }
                
                
                
            }
    }
    
    
    func postGetProfileImage(_ parameters: ProfileRequest) {
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                    .userDomainMask, true)[0]
            let documentsURL = URL(fileURLWithPath: documentsPath, isDirectory: true)
            let fileURL = documentsURL.appendingPathComponent("image.jpg")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            
        }
        
        AF.download("http://3.37.209.65:3000/give-img-url", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil, to: destination)//profileImageView.image?)
            .downloadProgress(closure: { Progress in
                //progressView
            })
            .response { response in
                print("🔊[DEBUG] profile \(response)")
                
                if response.error == nil, let imagePath = response.fileURL?.path {
                    let image = UIImage(contentsOfFile: imagePath)
                    self.proflieImage.image = image
                    //UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                    
                }
                if self.proflieImage.image == nil {
                    self.proflieImage.image = UIImage(named: "profileImage")
                }
                
                //프로필 사진 둥글게 만들기
                self.proflieImage.contentMode = .scaleAspectFill
                self.proflieImage.layer.cornerRadius = self.proflieImage.frame.width / 2
                self.proflieImage.clipsToBounds = true
                
                print(self.proflieImage.image ?? "")
            }
        
    }
    
    // 배달 완료 API
    func postEndDelivery(_ parameters: EndDeliveryRequest) {
        AF.request("http://43.200.179.53:3000/end-delivery", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: FindChatRoomResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                      
                        // 배달 완료 확인 메시지
                        print(response.message)
                    }
                    
                    else{
                        print("배달 완료 실패\(response.message)")
                        //alert message
                        let FailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        
                        let FailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                        FailAlert.addAction(FailAction)
                        self.present(FailAlert, animated: true, completion: nil)
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    print("서버 통신 실패")
                    let FailAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
                    
                    let FailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    FailAlert.addAction(FailAction)
                    self.present(FailAlert, animated: true, completion: nil)
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
        
        return  speechBubbleList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // speechBubbleList 배열의 값의 isMyMessage가 true이면 myCell, false면 yourCell
        let cellIdentifier = speechBubbleList[indexPath.row].isMyMessage ? "ChattingTableViewMyCell" : "ChattingTableViewYourCell"

        if(cellIdentifier == "ChattingTableViewMyCell"){
            let userCell = tableView.dequeueReusableCell(withIdentifier: "ChattingTableViewMyCell", for: indexPath) as! ChattingTableViewMyCell


            // label에 sendTime과 content 추가
            userCell.speechDateLabel.text = speechBubbleList[indexPath.row].sendTime
            userCell.speechLabel.text = speechBubbleList[indexPath.row].content
            return userCell
        }

        // 상대 채팅이면
        else{
            let userCell = tableView.dequeueReusableCell(withIdentifier: "ChattingTableViewYourCell", for: indexPath) as! ChattingTableViewYourCell


            // label에 sendTime과 content 추가
            userCell.speechYourDateLabel.text = speechBubbleList[indexPath.row].sendTime
            userCell.speechYourLabel.text = speechBubbleList[indexPath.row].content
            return userCell
        }
    
    }
    
    
    
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row % 2 == 0 {
//            let userCell = tableView.dequeueReusableCell(withIdentifier: "ChattingTableViewYourCell", for: indexPath) as! ChattingTableViewYourCell
//
//            userCell.speechYourDateLabel.text = "2022.12.25"
//            userCell.speechYourLabel.text = speechBubbleList[indexPath.row]
//
//            return userCell
//        }
//        else {
//            let userCell = tableView.dequeueReusableCell(withIdentifier: "ChattingTableViewMyCell", for: indexPath) as! ChattingTableViewMyCell
//
//            userCell.speechDateLabel.text = "2022.12.25"
//            userCell.speechLabel.text = speechBubbleList[indexPath.row]
//
//            return userCell
//        }
//
//
//    }
    
   
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
