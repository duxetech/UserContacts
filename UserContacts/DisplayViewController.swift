//
//  DisplayViewController.swift
//  UserContacts
//
//  Created by Karthik on 22/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController, UITableViewDataSource {
    
    let parser = Parser()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parser.contacts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = parser.contacts![indexPath.row].username
        cell.textLabel?.textAlignment = .center
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tvDisplay.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        parser.readData()
        tvDisplay.reloadData()

    }
    
    
   
    @IBOutlet var tvDisplay: UITableView!
    
}
