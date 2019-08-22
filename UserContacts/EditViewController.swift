//
//  SecondViewController.swift
//  UserContacts
//
//  Created by Karthik on 22/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parser.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editCell", for: indexPath)
        cell.textLabel?.text = parser.contacts[indexPath.row].username
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
   
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let index = editTV.indexPathForSelectedRow else { return }

        if let vc = segue.destination as? EditDetailViewController {
            vc.input = index.row
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editDetail", sender: self)
        ind = indexPath.row
        print(ind!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTV.dataSource = self
        editTV.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        parser.readData()
        editTV.reloadData()
    }

    @IBOutlet var editTV: UITableView!
    let parser = Parser()
    var ind : Int?
    
}

