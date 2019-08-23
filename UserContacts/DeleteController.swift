//
//  DeleteController.swift
//  UserContacts
//
//  Created by Karthik on 22/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

class DeleteController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parser.contacts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deleteCell", for: indexPath)
        cell.textLabel?.text = parser.contacts![indexPath.row].username
        cell.textLabel?.textAlignment = .center
        return cell    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert(row: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert(row: indexPath.row)
    }
    
    func showAlert(row : Int){
        let alert = UIAlertController(title: "Alert!", message: "Delete the data", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
            self.parser.deleteData(index: row)
            self.parser.readData()
            self.DeleteTV.reloadData()

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        present(alert,animated: true,completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        DeleteTV.dataSource = self
        DeleteTV.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        parser.readData()
        DeleteTV.reloadData()

    }
    
    @IBOutlet var DeleteTV: UITableView!
    let parser = Parser()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
