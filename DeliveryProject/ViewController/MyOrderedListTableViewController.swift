//
//  MyOrderedListTableViewController.swift
//  DeliveryProject
//
//  Created by 이수현 on 2023/01/09.
//

import UIKit

class MyOrderedListTableViewController: UITableViewController {

    @IBOutlet var MyOrderedListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myOrderedList", for: indexPath) as! MyOrderedListTableViewCell

        

        return cell
    }
    


}


