//
//  ViewController.swift
//  DeliveryProject
//
//  Created by 김민희 on 2022/12/26.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var autoLogin = false
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var autoLoginButton: UIButton!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func autoLoginButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        sender.isSelected ? (autoLogin = true) : (autoLogin = false)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        let id = idTextField.text ?? ""
        let pw = pwTextField.text ?? ""
        
        let param = LoginRequest(userId: id, userPw: pw)
        postLogin(param)
    }
    
    
    func postLogin(_ parameters: LoginRequest) {
        AF.request("http://3.37.209.65:3000/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
                    if(response.success == true){
                        print("로그인 성공")
                        
                        //기기에 아이디 저장
                        UserDefaults.standard.set(idTextField.text, forKey: "id")
                        
                        //자동 로그인
                        if autoLogin == true {
                            UserDefaults.standard.set(true, forKey: "auto")
                        }
                        
                        //화면 이동
                        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "NavController") else {return}
                        nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        self.present(nextVC, animated: true)
                        
                    }
                    
                    else{
                        print("로그인 실패\(response.message)")
                        //alert message
                        let loginFailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        
                        let loginFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                        loginFailAlert.addAction(loginFailAction)
                        self.present(loginFailAlert, animated: true, completion: nil)
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    print("서버 통신 실패")
                    let loginFailAlert = UIAlertController(title: "경고", message: "서버 통신에 실패하였습니다.", preferredStyle: UIAlertController.Style.alert)
                    
                    let loginFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    loginFailAlert.addAction(loginFailAction)
                    self.present(loginFailAlert, animated: true, completion: nil)
                }
                
            }
    }
}

