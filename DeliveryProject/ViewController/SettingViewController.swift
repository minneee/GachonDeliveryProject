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
    lazy var navigationBar : UINavigationBar = {
        let navigationBar = UINavigationBar()
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        
        let navItem = UINavigationItem(title: "설정")
//        let leftButton = UIBarButtonItem(image: UIImage(named: "chevron.backward"), style: .plain, target: SettingViewController.self, action: nil)
//        navItem.leftBarButtonItem = leftButton
        navigationBar.setItems([navItem], animated: true)
        
        return navigationBar
    }()
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        //뷰 추가
        self.view.addSubview(navigationBar)
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
        
        //오토레이아웃
        navigationBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
        }
        
        blueBoxView.snp.makeConstraints{ (make) in
            make.top.equalTo(navigationBar.snp.bottom).offset(30)
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
        
        
        //let safeArea = self.view.safeAreaLayoutGuide
        
//        navigationBar.barTintColor = .white
//        navigationBar.tintColor = .black
        
//        //오토레이아웃
//        navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
//        navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
//        navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true

        
//        let navItem = UINavigationItem(title: "설정")
//        let leftButton = UIBarButtonItem(image: UIImage(named: "chevron.backward"), style: .plain, target: self, action: nil)
//
//
//        navItem.leftBarButtonItem = leftButton
//
//        navigationBar.setItems([navItem], animated: true)
        
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
