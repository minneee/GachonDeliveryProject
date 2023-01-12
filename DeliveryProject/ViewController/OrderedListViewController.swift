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
    
    // bar 버튼 주문서 작성 페이지 버튼
    @IBAction func CreateOrderBtn(_ sender: UIBarButtonItem) {
        guard let createOrderVC = storyboard?.instantiateViewController(withIdentifier: "CreateOrderVC") else{return}
        navigationController?.pushViewController(createOrderVC, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderedListTable.delegate = self
        orderedListTable.dataSource = self

  
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! OrderedListTableViewCell
        
        
        
        return cell
    }

    

}
