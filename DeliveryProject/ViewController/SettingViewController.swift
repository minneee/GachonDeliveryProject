//
//  SettingViewController.swift
//  DeliveryProject
//
//  Created by mini on 2023/01/11.
//

import UIKit
import SnapKit
import Then
import Alamofire

class SettingViewController: UIViewController {

    //네비게이션 바
//    lazy var navigationBar : UINavigationBar = {
//        let navigationBar = UINavigationBar()
//
//        navigationBar.translatesAutoresizingMaskIntoConstraints = false
//        navigationBar.barTintColor = .white
//        navigationBar.tintColor = .black
//
        
//        let leftButton = UIBarButtonItem(image: UIImage(named: "chevron.backward"), style: .plain, target: SettingViewController.self, action: nil)
//        navItem.leftBarButtonItem = leftButton
//        navigationBar.setItems([navItem], animated: true)
//
//        return navigationBar
//    }()
    
    //프로필 박스
    lazy var blueBoxView = { () -> UIView in
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(red: 195/255, green: 209/255, blue: 255/255, alpha: 1).cgColor//UIColor.blue.cgColor
        view.layer.borderWidth = 2.5
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    //프로필 편집 label
    lazy var profileEditLabel = { () -> UILabel in
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(red: 99/255, green: 135/255, blue: 255/255, alpha: 1)
        //label underline 추가
        let attributedString = NSMutableAttributedString.init(string: "프로필편집")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
         label.attributedText = attributedString
        
        return label
    }()
    
    //profile image
    lazy var profileImageView = { () -> UIImageView in
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "profileImage")
        
        return imageView
    }()
    
    //닉네임
    lazy var userNameLabel = { () -> UILabel in
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.text = "닉네임"
        
        return label
    }()
    
    //한줄소개
    lazy var oneLineIntroduction = { () -> UILabel in
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.text = "한줄소개는 열다섯 글자?"
        
        return label
    }()
    
    //프로필 박스 line
    lazy var lineView = { () -> UIView in
        let view = UIView()
        
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    //주문 아이콘
    lazy var orderIconImageView = { () -> UIImageView in
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "orderIcon")
        
        return imageView
    }()
    
    //배달 아이콘
    lazy var deliveryIconImageView = { () -> UIImageView in
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "deliveryIcon")
        
        return imageView
    }()
    
    //주문 별점
    lazy var orderPinwheelPointImageView = { () -> UIImageView in
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "PinwheelPoint0")
        
        return imageView
    }()
    
    //배달 별점
    lazy var deliveryPinwheelPointImageView = { () -> UIImageView in
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "PinwheelPoint0")
        
        return imageView
    }()
    
    //설정 리스트
    //공지사항 button
    lazy var noticeButton = UIButton().then {
        $0.setTitle("공지사항", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        $0.backgroundColor = .white
        $0.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
    }
    
    

    
    //line1
    lazy var line1 = UIView().then {
        $0.backgroundColor = UIColor(red: 229/255, green: 230/255, blue: 255/255, alpha: 1)
    }
    
    //이용내역 button
    lazy var usageListButton = UIButton().then {
        $0.setTitle("이용내역", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        $0.backgroundColor = .white
        $0.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
    }
    
    //line2
    lazy var line2 = UIView().then {
        $0.backgroundColor = UIColor(red: 229/255, green: 230/255, blue: 255/255, alpha: 1)
    }
    
    //문의하기 button
    lazy var inquiryButton = UIButton().then {
        $0.setTitle("문의하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        $0.backgroundColor = .white
        $0.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
    }
    
    //line3
    lazy var line3 = UIView().then {
        $0.backgroundColor = UIColor(red: 229/255, green: 230/255, blue: 255/255, alpha: 1)
    }
    
    //로그아웃 button
    lazy var logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        $0.backgroundColor = .white
        $0.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
    }
    
    //line4
    lazy var line4 = UIView().then {
        $0.backgroundColor = UIColor(red: 229/255, green: 230/255, blue: 255/255, alpha: 1)
    }
    
    //회원탈퇴 button
    lazy var withdrawalButton = UIButton().then {
        $0.setTitle("회원탈퇴", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        $0.backgroundColor = .white
        $0.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
    }
    
    //line5
    lazy var line5 = UIView().then {
        $0.backgroundColor = UIColor(red: 229/255, green: 230/255, blue: 255/255, alpha: 1)
    }
    
    

    override func viewWillAppear(_ animated: Bool) {

        //프로필 설정
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        let param = ProfileRequest(userId: id)
        postProfile(param)
        postGetProfileImage(param)
        
    
        self.view.layoutIfNeeded()
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        //뷰 추가, 오토레이아웃 설정
        self.setupLayout()
        
        self.view.backgroundColor = .white
        

        

        // 공지사항 버튼
        noticeButton.addTarget(self, action: #selector(goToNoticeVC),for: .touchUpInside)
        
        // 이용내역 버튼
        usageListButton.addTarget(self, action: #selector(goToUsageListVC),for: .touchUpInside)
        
        // 문의하기 버튼
        inquiryButton.addTarget(self, action: #selector(goToInquiryVC),for: .touchUpInside)
        
        logoutButton.addTarget(self, action: #selector(logoutAlert), for: .touchUpInside)
        
        // 프로필 편집
        let tap = UITapGestureRecognizer(target: self, action: #selector(gotToChangeProfileVC))
        profileEditLabel.isUserInteractionEnabled = true
        profileEditLabel.addGestureRecognizer(tap)
        
        //회원 탈퇴 버튼
        withdrawalButton.addTarget(self, action: #selector(withdrawalAlert), for: .touchUpInside)

    }
    
    // 공지사항으로 화면 이동
    @objc func goToNoticeVC(){
        guard let noticeVC = storyboard?.instantiateViewController(withIdentifier: "NoticeViewController") else {return}
        navigationController?.pushViewController(noticeVC, animated: true)
        noticeVC.navigationItem.title = "공지사항"
    }
    
    // 이용내역으로 화면 이동
    @objc func goToUsageListVC(){
        guard let UsageListVC = storyboard?.instantiateViewController(withIdentifier: "MyOrderedListVC") else {return}
        navigationController?.pushViewController(UsageListVC, animated: true)
        // UsageListVC.navigationItem.title = "이용내역"
    }
    
    // 문의하기로 화면 이동
    @objc func goToInquiryVC(){
        guard let inquiryVC = storyboard?.instantiateViewController(withIdentifier: "QuestionVC") else {return}
        navigationController?.pushViewController(inquiryVC, animated: true)
        // inquiryVC.navigationItem.title = "공지사항"
    }
    
    // 로그아웃 Alert
    @objc func logoutAlert() {
        let logoutAlert = UIAlertController(title: "로그아웃", message: "로그아웃하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        let logoutFalseAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        let logoutTrueAction = UIAlertAction(title: "로그아웃", style: UIAlertAction.Style.destructive) { ACTION in
            //자동로그인 해제
            UserDefaults.standard.set(false, forKey: "auto")
            UserDefaults.standard.removeObject(forKey: "id")
            
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") else {return}
            nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.present(nextVC, animated: true)
        }
        
        logoutAlert.addAction(logoutFalseAction)
        logoutAlert.addAction(logoutTrueAction)
        
        self.present(logoutAlert, animated: true, completion: nil)
    }
    
    // 프로필 편집으로 화면 이동
    @objc func gotToChangeProfileVC() {

        guard let ChangeProfileVC = storyboard?.instantiateViewController(withIdentifier: "ChangeProfileVC") as? ChangeProfileViewController else {return}
        
        ChangeProfileVC.getImage = self.profileImageView.image
        ChangeProfileVC.getNickname = self.userNameLabel.text ?? ""
        ChangeProfileVC.getIntroduce = self.oneLineIntroduction.text ?? ""
        
        navigationController?.pushViewController(ChangeProfileVC, animated: true)
    }
    
    //회원 탈퇴 Alert
    @objc func withdrawalAlert() {
        let pwCheckAlert = UIAlertController(title: "회원 탈퇴", message: "현재 비밀번호를 입력하세요", preferredStyle: UIAlertController.Style.alert)
        
        let pwCheckFalseAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        let pwCheckTrueAction = UIAlertAction(title: "비밀번호 확인", style: UIAlertAction.Style.destructive) { ACTION in
            
            let id = UserDefaults.standard.string(forKey: "id") ?? ""
            let password = pwCheckAlert.textFields?[0].text ?? ""
            
            //현재 비밀번호 확인 api 연결
            let param = WithdrawalRequest(userId: id, userPw: password)
            self.postWithdrawal(param)
        }
        
        pwCheckAlert.addAction(pwCheckFalseAction)
        pwCheckAlert.addAction(pwCheckTrueAction)
        pwCheckAlert.addTextField{ pwCheckTextField in
            pwCheckTextField.isSecureTextEntry = true
        }
        self.present(pwCheckAlert, animated: true, completion: nil)
    }
    
    //회원 탈퇴
    func postWithdrawal(_ parameters: WithdrawalRequest) {
        AF.request("http://3.37.209.65:3000/Gsecede", method: .delete, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: WithdrawalResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("회원 탈퇴 성공")
                        
                        //자동로그인 해제
                        UserDefaults.standard.set(false, forKey: "auto")
                        UserDefaults.standard.removeObject(forKey: "id")
                        
                        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") else {return}
                        nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        self.present(nextVC, animated: true)
                    }
                    
                    else{
                        print("회원 탈퇴 실패\(response.message)")
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
    
    //프로필 보기
    func postProfile(_ parameters: ProfileRequest) {
        AF.request("http://3.37.209.65:3000/mypage", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: ProfileResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("프로필 조회 성공")
                        
                        
                        userNameLabel.text = response.nickname
                        oneLineIntroduction.text = response.introduce
                        print("🔊[DEBUG] \(response.orderRate ?? 0)")
                        print("🔊[DEBUG] \(response.deliveryRate ?? 0)")
                    
                        switch response.orderRate ?? 0 {
                        case 0: orderPinwheelPointImageView.image = UIImage(named: "PinwheelPoint0")
                        case 1: orderPinwheelPointImageView.image = UIImage(named: "PinwheelPoint1")
                        case 2: orderPinwheelPointImageView.image = UIImage(named: "PinwheelPoint2")
                        case 3: orderPinwheelPointImageView.image = UIImage(named: "PinwheelPoint3")
                        case 4: orderPinwheelPointImageView.image = UIImage(named: "PinwheelPoint4")
                        case 5: orderPinwheelPointImageView.image = UIImage(named: "PinwheelPoint5")
                        default: orderPinwheelPointImageView.image = UIImage(named: "PinwheelPoint0")
                        }
                        
                        switch response.deliveryRate ?? 0 {
                        case 0: deliveryPinwheelPointImageView.image = UIImage(named: "PinwheelPoint0")
                        case 1: deliveryPinwheelPointImageView.image = UIImage(named: "PinwheelPoint1")
                        case 2: deliveryPinwheelPointImageView.image = UIImage(named: "PinwheelPoint2")
                        case 3: deliveryPinwheelPointImageView.image = UIImage(named: "PinwheelPoint3")
                        case 4: deliveryPinwheelPointImageView.image = UIImage(named: "PinwheelPoint4")
                        case 5: deliveryPinwheelPointImageView.image = UIImage(named: "PinwheelPoint5")
                        default: deliveryPinwheelPointImageView.image = UIImage(named: "PinwheelPoint0")
                        }
                      
                    }
                    
                    else{
                        print("프로필 조회 실패\(response.message)")
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
                    self.profileImageView.image = image
                    //UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                    
                }
                if self.profileImageView.image == nil {
                    self.profileImageView.image = UIImage(named: "profileImage")
                }
                print(self.profileImageView.image)
            }
                
                
//            .responseDecodable{ response in
//                switch response.result {
//                case .success(let response):
//                    if(response.success == true){
//                        print("프로필 사진 조회 성공")
//
//
//                    }
//
//                    else{
//                        print("프로필 사진 조회 실패\(response.message)")
//                        //alert message
//                        let FailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
//
//                        let FailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
//                        FailAlert.addAction(FailAction)
//                        self.present(FailAlert, animated: true, completion: nil)
//                    }
//
//
//                case .failure(let error):
//                    print(error)
//                    print("서버 통신 실패")
//                    let serverFailAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
//
//                    let serverFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
//                    serverFailAlert.addAction(serverFailAction)
//                    self.present(serverFailAlert, animated: true, completion: nil)
//                }
//
//            }
    }
    
    
    
    
//    func postGetProfileImage(_ parameters: ProfileRequest) {
//        AF.request("http://3.37.209.65:3000/give-img-url", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
//            .validate()
//            .responseDecodable(of: ProfileResponse.self) { [self] response in
//                switch response.result {
//                case .success(let response):
//                    if(response.success == true){
//                        print("프로필 사진 조회 성공")
//
//
//                    }
//
//                    else{
//                        print("프로필 사진 조회 실패\(response.message)")
//                        //alert message
//                        let FailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
//
//                        let FailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
//                        FailAlert.addAction(FailAction)
//                        self.present(FailAlert, animated: true, completion: nil)
//                    }
//
//
//                case .failure(let error):
//                    print(error)
//                    print("서버 통신 실패")
//                    let serverFailAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
//
//                    let serverFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
//                    serverFailAlert.addAction(serverFailAction)
//                    self.present(serverFailAlert, animated: true, completion: nil)
//                }
//
//            }
//    }
    
    
    
    
    
    
    
    
    
    
    func setupLayout() {
        //뷰 추가
        self.view.addSubview(blueBoxView)
        self.view.addSubview(profileEditLabel)
        self.view.addSubview(profileImageView)
        self.view.addSubview(userNameLabel)
        self.view.addSubview(oneLineIntroduction)
        self.view.addSubview(lineView)
        self.view.addSubview(orderIconImageView)
        self.view.addSubview(deliveryIconImageView)
        self.view.addSubview(orderPinwheelPointImageView)
        self.view.addSubview(deliveryPinwheelPointImageView)
        self.view.addSubview(noticeButton)
        self.view.addSubview(line1)
        self.view.addSubview(usageListButton)
        self.view.addSubview(line2)
        self.view.addSubview(inquiryButton)
        self.view.addSubview(line3)
        self.view.addSubview(logoutButton)
        self.view.addSubview(line4)
        self.view.addSubview(withdrawalButton)
        self.view.addSubview(line5)
        
        
        blueBoxView.snp.makeConstraints{ (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.bottom.equalTo(lineView.snp.bottom).offset(55)
        }
        
        profileEditLabel.snp.makeConstraints{ (make) in
            make.right.equalTo(blueBoxView.snp.right).offset(-10)
            make.top.equalTo(blueBoxView.snp.top).offset(10)
            
        }
        
        profileImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(blueBoxView.snp.top).offset(20)
            make.left.equalTo(blueBoxView.snp.left).offset(20)
            make.height.width.equalTo(60)
        }
        
        userNameLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(profileImageView.snp.top).offset(11)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
        
        oneLineIntroduction.snp.makeConstraints{ (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(3)
            make.left.equalTo(userNameLabel.snp.left).offset(0)
        }
        
        lineView.snp.makeConstraints{ (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.left.equalTo(blueBoxView.snp.left).offset(10)
            make.right.equalTo(blueBoxView.snp.right).offset(-10)
            make.height.equalTo(0.5)
        }
        
        orderIconImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(lineView.snp.bottom).offset(15)
            //make.left.equalTo(blueBoxView.snp.left).offset(30)
            make.right.equalTo(orderPinwheelPointImageView.snp.left).offset(-5)
            make.height.width.equalTo(20)
        }
        
        orderPinwheelPointImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(lineView.snp.bottom).offset(15)
            make.right.equalTo(blueBoxView.snp.centerX).offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(110)
        }
        
        deliveryIconImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(lineView.snp.bottom).offset(13)
            make.left.equalTo(blueBoxView.snp.centerX).offset(10)
            //make.width.equalTo(blueBoxView.snp.width).offset(0.05)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        deliveryPinwheelPointImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(lineView.snp.bottom).offset(15)
            make.left.equalTo(deliveryIconImageView.snp.right).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(110)
        }
        
        //설정 리스트
        noticeButton.snp.makeConstraints { make in
            make.top.equalTo(blueBoxView.snp.bottom).offset(30)
            make.left.equalTo(blueBoxView.snp.left).offset(15)
            make.right.equalTo(blueBoxView.snp.right).offset(-15)
            make.height.equalTo(25)
        }
        
        line1.snp.makeConstraints { make in
            make.top.equalTo(noticeButton.snp.bottom).offset(15)
            make.left.equalTo(blueBoxView.snp.left).offset(10)
            make.right.equalTo(blueBoxView.snp.right).offset(-10)
            make.height.equalTo(0.5)
        }
        
        usageListButton.snp.makeConstraints { make in
            make.top.equalTo(line1.snp.bottom).offset(20)
            make.left.equalTo(blueBoxView.snp.left).offset(15)
            make.right.equalTo(blueBoxView.snp.right).offset(-15)
            make.height.equalTo(25)
        }
        
        line2.snp.makeConstraints { make in
            make.top.equalTo(usageListButton.snp.bottom).offset(15)
            make.left.equalTo(blueBoxView.snp.left).offset(10)
            make.right.equalTo(blueBoxView.snp.right).offset(-10)
            make.height.equalTo(0.5)
        }
        
        inquiryButton.snp.makeConstraints { make in
            make.top.equalTo(line2.snp.bottom).offset(20)
            make.left.equalTo(blueBoxView.snp.left).offset(15)
            make.right.equalTo(blueBoxView.snp.right).offset(-15)
            make.height.equalTo(25)
        }
        
        line3.snp.makeConstraints { make in
            make.top.equalTo(inquiryButton.snp.bottom).offset(15)
            make.left.equalTo(blueBoxView.snp.left).offset(10)
            make.right.equalTo(blueBoxView.snp.right).offset(-10)
            make.height.equalTo(0.5)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(line3.snp.bottom).offset(20)
            make.left.equalTo(blueBoxView.snp.left).offset(15)
            make.right.equalTo(blueBoxView.snp.right).offset(-15)
            make.height.equalTo(25)
        }
        
        line4.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(15)
            make.left.equalTo(blueBoxView.snp.left).offset(10)
            make.right.equalTo(blueBoxView.snp.right).offset(-10)
            make.height.equalTo(0.5)
        }
        
        withdrawalButton.snp.makeConstraints { make in
            make.top.equalTo(line4.snp.bottom).offset(20)
            make.left.equalTo(blueBoxView.snp.left).offset(15)
            make.right.equalTo(blueBoxView.snp.right).offset(-15)
            make.height.equalTo(25)
        }
        
        line5.snp.makeConstraints { make in
            make.top.equalTo(withdrawalButton.snp.bottom).offset(15)
            make.left.equalTo(blueBoxView.snp.left).offset(10)
            make.right.equalTo(blueBoxView.snp.right).offset(-10)
            make.height.equalTo(0.5)
        }
    }
    
   

}

//
////미리보기
//#if DEBUG
//import SwiftUI
//struct ViewControllerRepresentable: UIViewControllerRepresentable {
//
//func updateUIViewController(_ uiView: UIViewController,context: Context) {
//        // leave this empty
//}
//@available(iOS 13.0.0, *)
//func makeUIViewController(context: Context) -> UIViewController{
//    ViewController()
//    }
//}
//@available(iOS 13.0, *)
//struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ViewControllerRepresentable()
//                .ignoresSafeArea()
//                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
//                .previewDevice(PreviewDevice(rawValue: "iPhone"))
//        }
//
//    }
//} #endif
