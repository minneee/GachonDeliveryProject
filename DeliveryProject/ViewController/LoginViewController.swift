//
//  ViewController.swift
//  DeliveryProject
//
//  Created by 김민희 on 2022/12/26.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

class ViewController: UIViewController {
    
    var autoLogin = false
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var autoLoginButton: UIButton!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    let vc = IndicatorViewController()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LoginButton.layer.cornerRadius = 3
        
        //키보드 올라가면 화면 위로 밀기 (이건 전체가 올라가서 지금 사용 x)
        IQKeyboardManager.shared.enable = true
        
        //키보드 위에 Toolbar 없애기
        IQKeyboardManager.shared.enableAutoToolbar = false
        //키보드 밖 화면 터치 시 키보드 내려감
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
 
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(UserDefaults.standard.string(forKey: "id"))
        print(UserDefaults.standard.bool(forKey: "auto"))
        if(UserDefaults.standard.bool(forKey: "auto") == true){
            print("자동로그인")
            
            guard let VC = storyboard?.instantiateViewController(identifier: "NavController") else { return }
            changeRootViewController(VC)
            
        }
    }

    
    
    @IBAction func autoLoginButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        sender.isSelected ? (autoLogin = true) : (autoLogin = false)
        
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        let id = idTextField.text ?? ""
        let pw = pwTextField.text ?? ""
        
//        let param = LoginRequest(userId: id, userPw: pw)
        
        let param = LoginRequest(userId: "alsgml0221", userPw: "kmh475800!")
        
        showIndicatorView()
        postLogin(param)
        
    }
    
    
    func postLogin(_ parameters: LoginRequest) {
        AF.request("http://3.37.209.65:3000/Glogin", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { [self] response in
                self.dismissIndicatorView {
                    // dismissIndicatorView 클로져 수행
                    switch response.result {
                        
                    case .success(let response):
                        if(response.success == true){
                            print("로그인 성공")
                            
                            //기기에 아이디 저장
//                            UserDefaults.standard.set(idTextField.text, forKey: "id")
                            
                            
                            UserDefaults.standard.set("alsgml0221", forKey: "id")
                            print("\(autoLogin) + 자동")
                            //자동 로그인
                            if autoLogin == true {
                                print("자동로그인 켜짐")
                                UserDefaults.standard.set(true, forKey: "auto")
                            }
                            
                            if response.memberTrueFalse == true {
                                //이미 가입한 회원
                                print("가입")
                                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "NavController") else {return}
                                nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                                self.present(nextVC, animated: true)
                            }
                            else {
                                //가입하지 않은 회원
                                print("미가입")
                                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MemberNavController") else {return}
                                nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                                self.present(nextVC, animated: true)
                                
                            }
                            
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
    
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    func showIndicatorView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.vc.modalPresentationStyle = .overFullScreen
            self.present(self.vc, animated: false)
            
        }
    }
    
    func dismissIndicatorView(_ completion: (()->())?) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.vc.dismiss(animated: false) {
                completion?()
            }
            
        }
    }
    
}

import SnapKit
import Then

class IndicatorViewController: UIViewController {
  
  private let indicatorView = UIActivityIndicatorView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
      self.view.backgroundColor = .black.withAlphaComponent(0.3)
    self.view.addSubview(indicatorView)
    indicatorView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.startAnimating()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.stopAnimating()
  }
  
  private func startAnimating() {
    self.indicatorView.startAnimating()
  }
  
  private func stopAnimating() {
    self.indicatorView.stopAnimating()
  }
}
