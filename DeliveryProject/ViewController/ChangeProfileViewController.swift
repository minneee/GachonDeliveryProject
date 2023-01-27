//
//  ChangeProfileViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/07.
//

import UIKit
import Toast_Swift
import Alamofire

class ChangeProfileViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var profileImage: UIImageView! // 프로필 이미지 이미지뷰
    @IBOutlet weak var nicknameText: UITextField! // 닉네임 텍스트 필드
    @IBOutlet weak var introduceText: UITextField! // 한 줄 소개 텍스트 필드
    
    // 이미지 변경 버튼
    @IBAction func changeImageBtn(_ sender: UIButton) {
        
        
    }
    
    // 확인 버튼
    @IBAction func completeBtn(_ sender: UIBarButtonItem) {
        
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        let nickname = nicknameText.text ?? ""
        let introduce = introduceText.text ?? ""
        let param = ChangeProfileRequest(userId: id, nickname: nickname, introduce: introduce)
        postChangeProfile(param)
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameUnderLine()
        introduceUnderLine()
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        self.nicknameText.delegate = self
        self.introduceText.delegate = self
        
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        let param = ProfileRequest(userId: id)
        postProfile(param)
        
        
    }
    
    // 이 화면이 켜질 때 기존의 닉네임과 한 줄 소개 받아옴
    func postProfile(_ parameters: ProfileRequest) {
        AF.request("http://3.37.209.65:3000/mypage", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: ProfileResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("프로필 변경 페이지 조회 성공")
                        
                        nicknameText.text = response.nickname
                        introduceText.text = response.introduce
                        
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
    
    // 닉네임, 한 줄 소개 변경 
    func postChangeProfile(_ parameters: ChangeProfileRequest){
        AF.request("http://3.37.209.65:3000/editmypage", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("프로필 변경 성공")
                    }
                    
                    else{
                        print("프로필 변경 실패\(response.message)")
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
            
            let nicknameTextCount = (nicknameText.text?.appending(string).count ?? 0) - 1
            let introduceTextCount = (introduceText.text?.appending(string).count ?? 0) - 1
            
            // 닉네임 글자 수 제한
            if textField.text == nicknameText.text{
                
                print("닉네임 글자 수 : \(nicknameTextCount)")
                
                if (nicknameTextCount > 6){
                    self.view.makeToast("❗️닉네임은 6자 이하로 입력해주세요❗️", duration: 3.0, position: .top)
                    nicknameText.text?.removeLast()
                    return false
                } else{
                    return true
                }
            } else if (textField.text == introduceText.text){
                
                print("한 줄 소개 글자 수 : \(introduceTextCount)")
                
                // 한 줄 소개 글자 수 제한
                if (introduceTextCount > 15){
                    self.view.makeToast("❗️한 줄 소개는 15자 이하로 입력해주세요❗️", duration: 3.0, position: .top)
                    introduceText.text?.removeLast()
                    return false
                } else{
                    return true
                }
            }
            return true
            
        }
        
    }


