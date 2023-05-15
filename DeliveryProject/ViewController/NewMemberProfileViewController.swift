//
//  NewMemberProfileViewController.swift
//  DeliveryProject
//
//  Created by mini on 2023/02/02.
//

import UIKit
import Alamofire
import MobileCoreServices

class NewMemberProfileViewController: UIViewController {
    
    @IBOutlet weak var profileSetButton: UIBarButtonItem!
    
    @IBOutlet weak var profileImageButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var introduceOneLineTextField: UITextField!
    
//    var getImage = UIImage(named: "profileImage")
//    var getNickname = ""
//    var getIntroduce = ""
    
    var newImage = UIImage(named: "profileImage")
    let picker: UIImagePickerController! = UIImagePickerController()
    //private var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nicknameUnderLine()
        introduceUnderLine()
        profileImageView.image = UIImage(named: "profileImage")
     
    }
    

    @IBAction func profileImageButtonAction(_ sender: Any) {
        self.picker.sourceType = .photoLibrary
        self.picker.delegate = self
        self.picker.mediaTypes = [kUTTypeImage as String]
        self.picker.modalPresentationStyle = .fullScreen
        
        self.present(self.picker, animated: true)
    }
    
    
    @IBAction func profileSetButtonAction(_ sender: Any) {
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        let nickname = nicknameTextField.text ?? ""
        let introduce = introduceOneLineTextField.text ?? ""
        let param = ChangeProfileRequest(userId: id, nickname: nickname, introduce: introduce)
        patchChangeProfile(param)
    }
    
    
    // 프로필 변경
    func patchChangeProfile(_ parameters: ChangeProfileRequest){
        
        let headers: HTTPHeaders = ["Content-type" : "multipart/form-data"]
        
        AF.upload(multipartFormData: { MultipartFormData in
            
            //이미지 설정
            if let image = self.newImage?.jpegData(compressionQuality: 0.5) {
                print("🔊[DEBUG] 이미지 설정")
                MultipartFormData.append(image, withName: "photoName", fileName: "test.jpeg", mimeType: "image/jpeg")
            }
            
            MultipartFormData.append(parameters.userId.data(using: .utf8)!, withName: "userId")
            MultipartFormData.append(parameters.nickname.data(using: .utf8)!, withName: "nickname")
            MultipartFormData.append(parameters.introduce.data(using: .utf8)!, withName: "introduce")

            
        }, to: "http://43.200.179.53:3000/editmypage", method: .patch, headers: headers).responseDecodable(of: ChangeProfileResponse.self) { [self] response in
            switch response.result {
            case .success(let response):
                if(response.success == true){
                    print("프로필 변경 성공")
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "NavController") else {return}
                    nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                    self.present(nextVC, animated: true)
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


extension NewMemberProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            newImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        }
        
        
        self.profileImageView.image = newImage
        //self.selectedImage = newImage
        picker.dismiss(animated: true)
        //        picker.dismiss(animated: true) {
        //            let vc = EditProfileImageViewController()
        //            vc.inputImage = self.newImage
        //            vc.modalPresentationStyle = .overFullScreen
        //            self.present(vc, animated: true)
        //        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
