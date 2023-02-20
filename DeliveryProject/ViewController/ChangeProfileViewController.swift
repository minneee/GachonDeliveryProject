//
//  ChangeProfileViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/07.
//

import UIKit
import Toast_Swift
import Alamofire
import MobileCoreServices

class ChangeProfileViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var profileImage: UIImageView! // 프로필 이미지 이미지뷰
    @IBOutlet weak var nicknameText: UITextField! // 닉네임 텍스트 필드
    @IBOutlet weak var introduceText: UITextField! // 한 줄 소개 텍스트 필드
    
    var getImage = UIImage(named: "profileImage")
    var getNickname = ""
    var getIntroduce = ""
    
    var newImage: UIImage? = nil
    let picker: UIImagePickerController! = UIImagePickerController()
    private var selectedImage: UIImage?
    //var jpgString = ""
    
    // 이미지 변경 버튼
    @IBAction func changeImageBtn(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            self.picker.sourceType = .photoLibrary
            self.picker.delegate = self
            self.picker.mediaTypes = [kUTTypeImage as String]
            self.picker.modalPresentationStyle = .fullScreen
            
            self.present(self.picker, animated: true)
        }
            
        
        
    }
    
    
    
    // 확인 버튼
    @IBAction func completeBtn(_ sender: UIBarButtonItem) {
        
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        let nickname = nicknameText.text ?? ""
        let introduce = introduceText.text ?? ""
        let param = ChangeProfileRequest(userId: id, nickname: nickname, introduce: introduce)
        print(param)
        
        postChangeProfile(param)
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameUnderLine()
        introduceUnderLine()
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.nicknameText.delegate = self
        self.introduceText.delegate = self
        
        profileImage.image = getImage
        nicknameText.text = getNickname
        introduceText.text = getIntroduce
        
//        let id = UserDefaults.standard.string(forKey: "id") ?? ""
//        let param = ProfileRequest(userId: id)
//        postProfile(param)
        
        
        
    }
    
    // 프로필 변경
    func postChangeProfile(_ parameters: ChangeProfileRequest){
        
        let headers: HTTPHeaders = ["Content-type" : "multipart/form-data"]
        
        AF.upload(multipartFormData: { MultipartFormData in
            
            //이미지 설정
            if let image = self.selectedImage?.jpegData(compressionQuality: 0.5) {
                MultipartFormData.append(image, withName: "photoName", fileName: "test.jpeg", mimeType: "image/jpeg")
            }
            
            
            MultipartFormData.append(parameters.userId.data(using: .utf8)!, withName: "userId")
            MultipartFormData.append(parameters.nickname.data(using: .utf8)!, withName: "nickname")
            MultipartFormData.append(parameters.introduce.data(using: .utf8)!, withName: "introduce")

            
        }, to: "http://3.37.209.65:3000/editmypage", method: .post, headers: headers).responseDecodable(of: ChangeProfileResponse.self) { [self] response in
            switch response.result {
            case .success(let response):
                if(response.success == true){
                    print("프로필 변경 성공")
                    navigationController?.popViewController(animated: true)
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
        
        
//        AF.request("http://3.37.209.65:3000/editmypage", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
//            .validate()
//            .responseDecodable(of: ChangeProfileResponse.self) { [self] response in
//                switch response.result {
//                case .success(let response):
//                    if(response.success == true){
//                        print("프로필 변경 성공")
//                    }
//
//                    else{
//                        print("프로필 변경 실패\(response.message)")
//                        //alert message
//                        let changeFailAlert = UIAlertController(title: "경고", message: response.message, preferredStyle: UIAlertController.Style.alert)
//
//                        let changeFailAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
//                        changeFailAlert.addAction(changeFailAction)
//                        self.present(changeFailAlert, animated: true, completion: nil)
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
//            }
//    }
    
    
    // 이 화면이 켜질 때 기존의 닉네임과 한 줄 소개 받아옴 - 화면 넘어갈 때 전달해줘도 될거같은디
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


extension ChangeProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            newImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        }

        self.profileImage.image = newImage
        self.selectedImage = newImage
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






import UIKit
import SnapKit
import Then
//import RxSwift

class EditProfileImageViewController: UIViewController {
  
//  @Inject private var userVM: UserViewModel
//  @Inject private var userManager: UserManager
//  private let disposeBag = DisposeBag()
//
  private var imageViewScale: CGFloat = 1.0
  private let maxScale: CGFloat = 3.0
  private let minScale: CGFloat = 1.0
  
  private var isPinch: Bool = false
  private var imageZoomScale: CGFloat = 1.0
  private var imageSize: CGSize!
    
    var inputImage: UIImage?
  
  private let snapshotAreaView = UIView().then {
    //$0.backgroundColor = .DecoColor.appWhite
      $0.backgroundColor = .white
  }
  
  private let profileImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.layer.masksToBounds = true
  }
  
  private let cancelButton = UIButton(type: .system).then {
    $0.setTitle("취소", for: .normal)
    //$0.titleLabel?.font = .Custom.S_14_m.getFont()
    $0.tintColor = .white
  }
  
  private let confirmButton = UIButton(type: .system).then {
    $0.setTitle("확인", for: .normal)
    //$0.titleLabel?.font = .Custom.S_14_m.getFont()
    //$0.tintColor = .DecoColor.appWhite
      $0.tintColor = .white
  }
  
  private lazy var buttonStackView = UIStackView(arrangedSubviews: [cancelButton, confirmButton]).then {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.setupLayout()
    self.setupGesture()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
      self.profileImageView.image = self.inputImage!
//    userVM.tempUserProfileImage
//      .compactMap{$0}
//      .observe(on: MainScheduler.instance)
//      .bind { [weak self] image in
//        guard let self = self else { return }
//        self.profileImageView.image = image
//      }.disposed(by: disposeBag)
//
//    userVM.tempUserBackgroundImage
//      .compactMap{$0}
//      .observe(on: MainScheduler.instance)
//      .bind { [weak self] inputImage in
//        guard let self = self else { return }
//        if let image = inputImage.0 { self.profileImageView.image = image }
//      }.disposed(by: disposeBag)
  }
  
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.setupProfileGuideLineLayer()
    view.bringSubviewToFront(buttonStackView)
    imageSize = profileImageView.frame.size
  }
  
  
  private func setupLayout() {
    self.view.addSubview(snapshotAreaView)
    self.snapshotAreaView.addSubview(profileImageView)
    self.view.addSubview(buttonStackView)
    
    snapshotAreaView.snp.makeConstraints { make in
      //make.horizontalEdges.equalToSuperview()
        make.leading.trailing.equalToSuperview()
      make.height.equalTo(snapshotAreaView.snp.width)
      make.centerY.equalTo(profileImageView.snp.centerY)
    }
    
    profileImageView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalTo(view.safeAreaLayoutGuide)
      //make.horizontalEdges.equalToSuperview()
        make.leading.trailing.equalToSuperview()
    }
    
    buttonStackView.snp.makeConstraints { make in
      //make.horizontalEdges.equalToSuperview().inset(16)
        make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
    }
  }
  
  private func setupProfileGuideLineLayer() {
    let size = self.view.frame.width
    let rect = CGRect(x: 0, y: snapshotAreaView.frame.minY, width: size, height: size)
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.view.bounds
    maskLayer.fillColor = UIColor.black.withAlphaComponent(0.2).cgColor
      let path = UIBezierPath(roundedRect: rect, cornerRadius: size/2.0)

    path.append(UIBezierPath(rect: view.bounds))
    maskLayer.path = path.cgPath
    maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
    view.layer.addSublayer(maskLayer)
  }
  
  
  private func setupGesture() {
    
//    profileImageView.rx.pinchGesture()
//      .when(.began, .changed, .ended)
//      .share(replay: 1)
//      .subscribe(onNext: { [weak self] recognize in
//        guard let self = self else { return }
//        switch recognize.state {
//        case .began: print("🔊[DEBUG]: Pinch Gesture start")
//        case .changed, .ended:
//          let pinchScale: CGFloat = recognize.scale
//          if self.imageViewScale * pinchScale < self.maxScale && self.imageViewScale * pinchScale > self.minScale {
//            self.imageViewScale *= pinchScale
//            self.profileImageView.transform = (self.profileImageView.transform.scaledBy(x: pinchScale, y: pinchScale))
//          }
//          recognize.scale = 1.0
//        default: break
//        }
//      }).disposed(by: disposeBag)
    
//    var imageCenterOffset: CGPoint = CGPoint(x: 0, y: 0)
//    profileImageView.rx.panGesture()
//      .when(.began, .changed, .ended)
//      .share(replay: 1)
//      .subscribe(onNext: { [weak self] recognize in
//        guard let self = self else { return }
//        switch recognize.state {
//        case .began:
//          imageCenterOffset = CGPoint(
//            x: self.profileImageView.center.x,
//            y: self.profileImageView.center.y
//          )
//        case .changed:
//          let translation = recognize.translation(in: self.profileImageView)
//          print("🔊[DEBUG]: \(translation)")
//          self.profileImageView.center = CGPoint(
//            x: imageCenterOffset.x + translation.x,
//            y: imageCenterOffset.y + translation.y
//          )
//        case .ended:
//          imageCenterOffset = CGPoint(x: 0, y: 0)
//        default: break
//        }
//
//      }).disposed(by: disposeBag)
//
//    cancelButton.rx.tap
//      .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
//      .bind { [weak self] in
//        guard let self = self else { return }
//        self.dismiss(animated: true)
//        switch self.userVM.pickerType {
//        case .PROFILE:
//          self.userVM.tempUserProfileImage.accept(nil)
//        case .BACKGROUND:
//          self.userVM.tempUserBackgroundImage.accept(nil)
//        default: break
//        }
//      }.disposed(by: disposeBag)
//
//    confirmButton.rx.tap
//      .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
//      .bind { [weak self] in
//        guard let self = self else { return }
//        let imageSize = self.view.frame.width
//
//        let snapShot = self.snapshotAreaView.snapshotView(afterScreenUpdates: true)
//        var asImage: UIImage {
//          let renderer = UIGraphicsImageRenderer(bounds: snapShot!.frame)
//          return renderer.image { rendererContext in
//            self.snapshotAreaView.layer.render(in: rendererContext.cgContext)
//          }
//        }
//
//        switch self.userVM.pickerType {
//        case .PROFILE: self.userVM.userProfileImage.accept(asImage)
//        case .BACKGROUND: self.userVM.userBackgroundImage.accept((asImage, nil))
//        default: break
//        }
//
//        self.dismiss(animated: true)
//      }.disposed(by: disposeBag)
    
  }
}
