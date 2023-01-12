//
//  OrderedListViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/01.
//

import UIKit

class OrderedListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var orderedListTable: UITableView!
    
    // 수정 버튼
    @IBAction func fixBtn(_ sender: UIButton) {
    }
    
    //네비게이션 바 이미지
    let navImage = UIImage(named: "createOrder")
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("hi")
        orderedListTable.delegate = self
        orderedListTable.dataSource = self

        navigationItem.titleView?.tintColor = .black
        //네비게이션 바 이미지 넣기(크기 조절)
        let scaledImage = navImage?.resizeImage(size: CGSize(width:26, height:26))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: scaledImage, style: .plain, target: self, action: #selector(moveVC))
  
    }

    @objc func moveVC () {
        print("화면이동")
        guard let createOrderVC = storyboard?.instantiateViewController(withIdentifier: "CreateOrderVC") else{return}
        navigationController?.pushViewController(createOrderVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! OrderedListTableViewCell
        
        
        
        return cell
    }

    

}

//네비게이션 바 이미지 크기 조절
//extension UIImage {
//    func resizeImage(size: CGSize) -> UIImage {
//        let originalSize = self.size
//        let ratio: CGFloat = {
//            return (originalSize.width > originalSize.height) ? (1 / (size.width / originalSize.width)) : (1 / (size.height / originalSize.height))
//        }()
//
//        return UIImage(cgImage: self.cgImage!, scale: self.scale * ratio, orientation: imageOrientation)
//    }
//}
