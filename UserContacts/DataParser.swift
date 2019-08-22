//
//  DataParser.swift
//  UserContacts
//
//  Created by Karthik on 22/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit
import CoreData

class Parser {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var contacts = [Contacts]()
    
    func insertData(user : String, pass : String, dob : String, address : String,  pin : Int) {
        let entity = Contacts(context: context)
        entity.username = user
        entity.password = pass
        entity.dob = dob
        entity.address = address
        entity.pincode = Int64(pin)
        
        do {
           try context.save()
        } catch {
            print(error)
     }
    }
        
        func readData(){
            let req : NSFetchRequest = Contacts.fetchRequest()
            do {
            contacts = try context.fetch(req)
                
            } catch {
                print(error)
            }
        }
    
    func deleteData(index : Int){
        let req : NSFetchRequest = Contacts.fetchRequest()
        do {
            let ent = try context.fetch(req)
            
            context.delete(ent[index])
        } catch {
            print(error)
        }
    }
    
    
    func updateRow(row : Int, pass : String, dob : String, address : String, pin : Int){
        let req : NSFetchRequest = Contacts.fetchRequest()
        do {
            let en = try context.fetch(req)
            en[row].setValue(pass, forKey: "password")
            en[row].setValue(dob, forKey: "dob")
            en[row].setValue(address, forKey: "address")
            en[row].setValue(pin, forKey: "pincode")
            try context.save()
            
        }
        catch {
            
        }
        
    }
}
