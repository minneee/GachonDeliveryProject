
import UIKit
import Alamofire
import IQKeyboardManagerSwift


class ChattingViewController: UIViewController {
    
    
    @IBOutlet weak var announcementView: UIView!
    
    @IBOutlet weak var chattingTableView: UITableView!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var chattingBarView: UIView!
    
    @IBOutlet weak var bottomConstraints: NSLayoutConstraint!
    
    
    
    var speechBubbleList: [String] = ["hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 ", "hi", "지이이이인짜 긴 글이 들어가면 자동으로 크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로크기가 이쁘게 될까>지이이이인짜 지이이이인짜지이이이인짜 긴 글이 들어가면 자동으로"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //채팅창 공지 뷰 모서리 둥글게하기
        announcementView.layer.cornerRadius = 8
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidenHandle), name: UIResponder.keyboardWillHideNotification, object: nil)

        //키보드 올라가면 화면 위로 밀기 (이건 전체가 올라가서 지금 사용 x)
//        IQKeyboardManager.shared.enable = true
        
        //키보드 위에 Toolbar 없애기
        IQKeyboardManager.shared.enableAutoToolbar = false
        //키보드 밖 화면 터치 시 키보드 내려감
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
       
        chattingTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //네비게이션 바 없애기
        //navigationController?.setNavigationBarHidden(false, animated: true)
        
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
        //self.chattingTableView.register(UINib(nibName: "ChattingTableViewYourCell", bundle: nil),  forCellReuseIdentifier: "ChattingTableViewYourCell")
        
        
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
    
    
    
    
  
}


//tableView
extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speechBubbleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: "ChattingTableViewMyCell", for: indexPath) as! ChattingTableViewMyCell
        
        userCell.speechDateLabel.text = "2022.12.25"
        userCell.speechLabel.text = speechBubbleList[indexPath.row]
        
        return userCell
    }
    
   
}

extension UIDevice {
  var hasNotch: Bool {
    let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    return bottom > 0
  }
}
