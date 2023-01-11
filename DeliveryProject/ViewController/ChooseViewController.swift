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

//        receiveDelivery.layer.cornerRadius = receiveDelivery.frame.width/2
//        doDelivery.layer.cornerRadius = doDelivery.frame.width/2
//        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
