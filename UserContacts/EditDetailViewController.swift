//
//  EditDetailViewController.swift
//  UserContacts
//
//  Created by Karthik on 22/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

class EditDetailViewController: UIViewController, UITextFieldDelegate, UITabBarControllerDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.minimumDate = format.date(from: "01/01/1990")
        datePicker?.maximumDate = Date()
        dob.inputView = datePicker

        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        dob.delegate = self
        self.tabBarController?.delegate=self
    }
    var parser : Parser? = Parser()
    var input : Int?
    var datePicker : UIDatePicker?
    let format = DateFormatter()
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect EditDetailViewController: UIViewController) {
        dismiss()
    }

    func dismiss(){
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        parser!.readData()
        
       
        guard  let row = input else {
            return
        }
        guard let parser = parser?.contacts![row] else {
            return
        }
        name.text = parser.username
        pass.text = parser.password
        dob.text = parser.dob
        address.text = parser.address
        pin.text = String(parser.pincode)


        
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
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.dismiss() }))
        
        
        present(alert,animated: true,completion: nil)
        
    }
    
    @IBOutlet var name: UILabel!
    @IBOutlet var pass: UITextField!
    
    @IBOutlet var dob: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var pin: UITextField!
    
    @IBAction func UpdateBtnPressed(_ sender: Any) {
        
        parser!.updateRow(row: input!, pass: pass.text!, dob: dob.text!, address: address.text!, pin: Int(pin.text!)!)
        showAlert()
    }
}
