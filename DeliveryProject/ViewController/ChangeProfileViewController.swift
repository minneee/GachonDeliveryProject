//
//  ChangeProfileViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/07.
//

import UIKit

class ChangeProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView! // 프로필 이미지 이미지뷰
    @IBOutlet weak var nicknameText: UITextField! // 닉네임 텍스트 필드
    @IBOutlet weak var introduceText: UITextField! // 한 줄 소개 텍스트 필드
    
    // 이미지 변경 버튼
    @IBAction func changeImageBtn(_ sender: UIButton) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameUnderLine()
        introduceUnderLine()
        
    }
    
    
    func nicknameUnderLine(){
        let border = CALayer()
        let width = CGFloat(2.0) // 선 굵기
        border.borderColor = UIColor.systemGray4.cgColor
        
        // 닉네임 텍스트 필드 언더라인
        border.frame = CGRect(x: 0, y: nicknameText.frame.size.height-width, width: nicknameText.frame.size.width, height: nicknameText.frame.size.height)
        
        border.borderWidth = width
        nicknameText.layer.addSublayer(border)
        nicknameText.layer.masksToBounds = true
        

    }
    
    func introduceUnderLine(){
        let border = CALayer()
        let width = CGFloat(2.0) // 선 굵기
        border.borderColor = UIColor.systemGray4.cgColor
        
        // 한 줄 소개 텍스트 필드 언더라인
        border.frame = CGRect(x: 0, y: introduceText.frame.size.height-width, width: introduceText.frame.size.width, height: introduceText.frame.size.height)
        
        border.borderWidth = width
        introduceText.layer.addSublayer(border)
        introduceText.layer.masksToBounds = true
    }
}
