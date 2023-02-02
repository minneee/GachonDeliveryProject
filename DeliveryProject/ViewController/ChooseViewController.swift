//
//  ChooseViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2022/12/28.
//

import UIKit

class ChooseViewController: UIViewController {
    @IBOutlet weak var receiveDelivery: UIButton!
    @IBOutlet weak var doDelivery: UIButton!
  

    let navImage = UIImage(named: "setting")


    @IBAction func goToChattingList(_ sender: Any) {
        guard let chattingListVC = storyboard?.instantiateViewController(withIdentifier: "ChattingListViewController") else {return}
        navigationController?.pushViewController(chattingListVC, animated: true)
    }
    
    
    @objc func goToSetting() {
        guard let settingVC = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") else {return}
        navigationController?.pushViewController(settingVC, animated: true)
    }

    
    // 배달할래요 버튼 동작
    @IBAction func doDelivery(_ sender: UIButton) {
        
        guard let deliveryListVC = storyboard?.instantiateViewController(withIdentifier: "DeliveryListVC") else {return}
        navigationController?.pushViewController(deliveryListVC, animated: true)
        
    }
    
    // 배달 받을래요 버튼 동작
    @IBAction func takeDelivery(_ sender: UIButton) {
        guard let myDeliveryListVC = storyboard?.instantiateViewController(withIdentifier: "MyDeliveryListVC") else{return}
        navigationController?.pushViewController(myDeliveryListVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        
        //네비게이션 바 이미지 넣기(크기 조절)
        let scaledImage = navImage?.resizeImage(size: CGSize(width: 26, height:26))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: scaledImage, style: .plain, target: self, action: #selector(goToSetting))
        
        print(UserDefaults.standard.string(forKey: "id") ?? "")
        print(UserDefaults.standard.bool(forKey: "auto") ?? "")
        
    }
    
    
    
//    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
//                if let window = UIApplication.shared.windows.first {
//                    window.rootViewController = viewControllerToPresent
//                    UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
//                } else {
//                    viewControllerToPresent.modalPresentationStyle = .overFullScreen
//                    self.present(viewControllerToPresent, animated: true, completion: nil)
//                }
//        }

}


//네비게이션 바 이미지 크기 조절
extension UIImage {
    func resizeImage(size: CGSize) -> UIImage {
        let originalSize = self.size
        let ratio: CGFloat = {
            return (originalSize.width > originalSize.height) ? (1 / (size.width / originalSize.width)) : (1 / (size.height / originalSize.height))
        }()

        return UIImage(cgImage: self.cgImage!, scale: self.scale * ratio, orientation: imageOrientation)
    }
}
