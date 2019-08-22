//
//  EditDetailViewController.swift
//  UserContacts
//
//  Created by Karthik on 22/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

class EditDetailViewController: UIViewController, UITextFieldDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.minimumDate = format.date(from: "01/01/1990")
        datePicker?.maximumDate = Date()
        dob.inputView = datePicker

        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        dob.delegate = self
    }
    var parser = Parser()
    var input : Int?
    var datePicker : UIDatePicker?
    let format = DateFormatter()

    override func viewWillAppear(_ animated: Bool) {
        parser.readData()
        
       
        guard  let input = input else {
            return
        }
        name.text = parser.contacts[input].username
        pass.text = parser.contacts[input].password
        dob.text = parser.contacts[input].dob
        address.text = parser.contacts[input].address
        pin.text = String(parser.contacts[input].pincode)


        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    @objc func dateChanged(datePicker : UIDatePicker){
        dob.text = format.string(from: datePicker.date)
        view.endEditing(true)
        
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Success!", message: "Successfully Updated the details!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        
        present(alert,animated: true,completion: nil)
        
    }
    
    @IBOutlet var name: UILabel!
    @IBOutlet var pass: UITextField!
    
    @IBOutlet var dob: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var pin: UITextField!
    
    @IBAction func UpdateBtnPressed(_ sender: Any) {
        
        parser.updateRow(row: input!, pass: pass.text!, dob: dob.text!, address: address.text!, pin: Int(pin.text!)!)
        showAlert()
    }
}
