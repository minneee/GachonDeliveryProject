//
//  StarScoreViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/09.
//

import UIKit

class StarScoreViewController: UIViewController {
    
    var receiverNickname = ""
    var deliverNickname = ""
    var rate = 0
    
    @IBOutlet weak var oneStarBtn: UIButton!
    @IBOutlet weak var twoStarBtn: UIButton!
    @IBOutlet weak var threeStarBtn: UIButton!
    @IBOutlet weak var fourStarBtn: UIButton!
    @IBOutlet weak var fiveStarBtn: UIButton!
    
    let colorImage = UIImage(named: "colorGachon")
    let WBImage = UIImage(named: "Gachon")
    
    // 1점 버튼
    @IBAction func oneStarBtn(_ sender: UIButton) {
        rate = 1
        
//        sender.setImage(image, for: .normal)
        oneStarBtn.setImage(colorImage, for: .normal)
        twoStarBtn.setImage(WBImage, for: .normal)
        threeStarBtn.setImage(WBImage, for: .normal)
        fourStarBtn.setImage(WBImage, for: .normal)
        fiveStarBtn.setImage(WBImage, for: .normal)
        
        
    }
    
    // 2점 버튼
    @IBAction func twoStarBtn(_ sender: UIButton) {
        rate = 2
        
        oneStarBtn.setImage(colorImage, for: .normal)
        twoStarBtn.setImage(colorImage, for: .normal)
        threeStarBtn.setImage(WBImage, for: .normal)
        fourStarBtn.setImage(WBImage, for: .normal)
        fiveStarBtn.setImage(WBImage, for: .normal)
    }
    
    // 3점 버튼
    @IBAction func threeStarBtn(_ sender: UIButton) {
        rate = 3
        
        oneStarBtn.setImage(colorImage, for: .normal)
        twoStarBtn.setImage(colorImage, for: .normal)
        threeStarBtn.setImage(colorImage, for: .normal)
        fourStarBtn.setImage(WBImage, for: .normal)
        fiveStarBtn.setImage(WBImage, for: .normal)
    }
    
    // 4점 버튼
    @IBAction func fourStarBtn(_ sender: UIButton) {
        rate = 4
        
        oneStarBtn.setImage(colorImage, for: .normal)
        twoStarBtn.setImage(colorImage, for: .normal)
        threeStarBtn.setImage(colorImage, for: .normal)
        fourStarBtn.setImage(colorImage, for: .normal)
        fiveStarBtn.setImage(WBImage, for: .normal)
    }
    
    // 5점 버튼 
    @IBAction func fiveStarBtn(_ sender: UIButton) {
        rate = 5
        
        oneStarBtn.setImage(colorImage, for: .normal)
        twoStarBtn.setImage(colorImage, for: .normal)
        threeStarBtn.setImage(colorImage, for: .normal)
        fourStarBtn.setImage(colorImage, for: .normal)
        fiveStarBtn.setImage(colorImage, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = ""
        
        if (receiverNickname == "" && deliverNickname != ""){
            
        }
        
        
    }
    



}
