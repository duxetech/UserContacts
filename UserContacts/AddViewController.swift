//
//  FirstViewController.swift
//  UserContacts
//
//  Created by Karthik on 22/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        tfPincode.delegate = self
        datePicker?.datePickerMode = .date
        tfDoB.inputView = datePicker
        format.dateFormat = "MM/dd/yyyy"
        datePicker?.minimumDate = format.date(from: "01/01/1990")
        datePicker?.maximumDate = Date()
        
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gest:)))
        view.addGestureRecognizer(tapGesture)
       // parser.deleteData()
    }
    
    let format = DateFormatter()
    
    var datePicker : UIDatePicker?

    let parser = Parser()

    @IBOutlet var tfUsername: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfDoB: UITextField!
    
    @IBOutlet var tfAddress: UITextField!
    
    @IBOutlet var tfPincode: UITextField!
    @IBAction func SaveButtonTapped(_ sender: Any) {
      
        let user = tfUsername.text!
        let pass = tfPassword.text!
        let address = tfAddress.text!
        let dob = tfDoB.text!
        let pin = tfPincode.text!
        
        if user == "" || pass == "" || address == "" || dob == "" || pin == "" {
            return
        }
        
        if user.count > 20 {
            return
        }
        if pass.count > 12 {
            return
        }
        if address.count > 60 {
            return
        }
        if pin.count > 6 {
            return
        }
        
        parser.insertData(user: user, pass: pass, dob: dob, address: address, pin: Int(pin)!)
        
        clear()
    }
    
    @objc func dateChanged(datePicker : UIDatePicker){
        tfDoB.text = format.string(from: datePicker.date)
        view.endEditing(true)
        
    }
    
    @objc func viewTapped(gest : UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let s = string.rangeOfCharacter(from: .decimalDigits) {
            return true
        }  else {
            return false
            
        }
    }
    
    func clear() {
        tfUsername.text = nil
        tfDoB.text = nil
        tfAddress.text = nil
        tfPassword.text = nil
        tfPincode.text = nil
    }
    
}

