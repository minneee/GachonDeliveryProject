//
//  NewMemberProfileViewController.swift
//  DeliveryProject
//
//  Created by mini on 2023/02/02.
//

import UIKit
import Alamofire

class NewMemberProfileViewController: UIViewController {
    
    @IBOutlet weak var profileSetButton: UIBarButtonItem!
    
    @IBOutlet weak var profileImageButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var introduceOneLineTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nicknameUnderLine()
        introduceUnderLine()
     
    }
    

    @IBAction func profileImageButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func profileSetButtonAction(_ sender: Any) {
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        let nickname = nicknameTextField.text ?? ""
        let introduce = introduceOneLineTextField.text ?? ""
        let param = ChangeProfileRequest(userId: id, nickname: nickname, introduce: introduce)
        postChangeProfile(param)
    }
    
    
    // 닉네임, 한 줄 소개 변경
    func postChangeProfile(_ parameters: ChangeProfileRequest){
        AF.request("http://3.37.209.65:3000/editmypage", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: ChangeProfileResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("프로필 설정 성공")
                        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "NavController") else {return}
                        nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        self.present(nextVC, animated: true)
                    }
                    
                    else{
                        print("프로필 설정 실패\(response.message)")
                        //alert message
                        let changeFailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        
                        let changeFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                        changeFailAlert.addAction(changeFailAction)
                        self.present(changeFailAlert, animated: true, completion: nil)
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
    
    func nicknameUnderLine(){
        let border = CALayer()
        let width = CGFloat(2.0) // 선 굵기
        border.borderColor = UIColor.systemGray4.cgColor
        
        // 닉네임 텍스트 필드 언더라인
        border.frame = CGRect(x: 0, y: nicknameTextField.frame.size.height-width, width: nicknameTextField.frame.size.width, height: nicknameTextField.frame.size.height)
        
        border.borderWidth = width
        nicknameTextField.layer.addSublayer(border)
        nicknameTextField.layer.masksToBounds = true
        
        
    }
    
    func introduceUnderLine(){
        let border = CALayer()
        let width = CGFloat(2.0) // 선 굵기
        border.borderColor = UIColor.systemGray4.cgColor
        
        // 한 줄 소개 텍스트 필드 언더라인
        border.frame = CGRect(x: 0, y: introduceOneLineTextField.frame.size.height-width, width: introduceOneLineTextField.frame.size.width, height: introduceOneLineTextField.frame.size.height)
        
        border.borderWidth = width
        introduceOneLineTextField.layer.addSublayer(border)
        introduceOneLineTextField.layer.masksToBounds = true
    }
}
