//
//  ChangeProfileViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/07.
//

import UIKit
import Toast_Swift

class ChangeProfileViewController: UIViewController, UITextFieldDelegate {
    
    
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
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        self.nicknameText.delegate = self
        self.introduceText.delegate = self
        
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
    
    // 텍스트 필드 글자 수 Toast 띄우기
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        print("textfield click \(textField.text!)")
//
//        if textField.text == nicknameText.text{
//            if (nicknameText.text?.count ?? 1 >= 6) {
//                // toast with a specific duration and position
//                self.view.makeToast("❗️닉네임은 6자 이하로 입력해주세요❗️", duration: 3.0, position: .top)
//            }
//        } else if (textField.text == introduceText.text){
//            if (introduceText.text?.count ?? 1 >= 15) {
//                // toast with a specific duration and position
//                self.view.makeToast("❗️한 줄 소개는 15자 이하로 입력해주세요❗️", duration: 3.0, position: .top)
//            }
//        }
//    }
    
    // 텍스트 필드 글자 수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let nicknameTextCount = nicknameText.text?.appending(string).count ?? 0
        let introduceTextCount = introduceText.text?.appending(string).count ?? 0
        
        // 닉네임 글자 수 제한
        if textField.text == nicknameText.text{
            
            print("닉네임 글자 수 : \(nicknameTextCount)")
            
            if (nicknameTextCount >= 7){
                self.view.makeToast("❗️닉네임은 6자 이하로 입력해주세요❗️", duration: 3.0, position: .top)
                return false
            } else{
                return true
            }
        } else if (textField.text == introduceText.text){
            
            print("한 줄 소개 글자 수 : \(introduceTextCount)")
            
            // 한 줄 소개 글자 수 제한
            if (introduceTextCount >= 16){
                self.view.makeToast("❗️한 줄 소개는 15자 이하로 입력해주세요❗️", duration: 3.0, position: .top)
                return false
            } else{
                return true
            }
        }
        return true 
        
    }
    
}
