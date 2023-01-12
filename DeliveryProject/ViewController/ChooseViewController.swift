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
  
    // 네비게이션 바 설정 버튼
    @IBAction func goToSetting(_ sender: UIButton) {
//        //스토리보드 지정
//        let storyBD = UIStoryboard(name: "Setting", bundle: nil)
//
//        //스토리보드 중에 어떤 뷰컨으로 갈지 선텍
//        let VC2 = storyBD.instantiateViewController(identifier: "SettingViewController")
//
//        //이동 함수 호출
//        changeRootViewController(VC2)
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

        //스토리보드 지정
//                let storyBD = UIStoryboard(name: "Setting", bundle: nil)
//                //스토리보드 중에 어떤 뷰컨으로 갈지 선텍
//                let VC2 = storyBD.instantiateViewController(identifier: "SettingViewController")
//                //이동 함수 호출
//                changeRootViewController(VC2)

        
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

}
