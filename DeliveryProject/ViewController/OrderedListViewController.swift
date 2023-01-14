//
//  OrderedListViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/01.
//

import UIKit

class OrderedListViewController: UIViewController {
    
    
    
    
    
    
    // 테이블
    @IBOutlet weak var orderedListTable: UITableView!
    
    // 네이게이션 바 주문서 작성 버튼 아울렛
    @IBOutlet var createOrder: UIBarButtonItem!

    //네비게이션 바 이미지
    let navImage = UIImage(named: "createOrder")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""

        // 테이블 뷰 설정
        orderedListTable.delegate = self
        orderedListTable.dataSource = self

        // 네비게이션 바 색상 변경
        navigationItem.titleView?.tintColor = .black
        
        //네비게이션 바 주문서 작성 이미지 넣기(크기 조절)
        let scaledImage = navImage?.resizeImage(size: CGSize(width:26, height:26))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: scaledImage, style: .plain, target: self, action: #selector(goToCreateOrderVC))
  
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "주문서 목록"
    }
    // 주문서 수정 버튼
    @IBAction func fixBtn(_ sender: UIButton) {
        guard let modifyVC = storyboard?.instantiateViewController(withIdentifier: "ModifyVC") else{return}
        navigationController?.pushViewController(modifyVC, animated: true)
        
       
    }
    
    // 주문서 작성으로 이동
    @objc func goToCreateOrderVC () {
        guard let createOrderVC = storyboard?.instantiateViewController(withIdentifier: "CreateOrderVC") else{return}
        navigationController?.pushViewController(createOrderVC, animated: true)
        
    }

        
   
    
    


}


extension OrderedListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! OrderedListTableViewCell
        
        // cell이 클릭되지 않게 하기
        cell.selectionStyle = .none
        
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
