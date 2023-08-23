//
//  ViewController.swift
//  ContactsTabBar
//
//  Created by Nuradil Serik on 23.08.2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldNumber: UITextField!
    
    @IBAction func buttonAdd(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        let contactName = textFieldName.text!
        let contactNumber = textFieldNumber.text!
        
        var newContact = ContactsItem()
        newContact.name = contactName
        newContact.number = contactNumber
        
        do{
           
            if let data = defaults.data(forKey: "contactsArray"){
                var array = try JSONDecoder().decode([ContactsItem].self, from: data)
                array.append(newContact)
                
                let encodeData = try JSONEncoder().encode(array)
                defaults.set(encodeData, forKey: "contactsArray")
            } else{
                let encodeData = try JSONEncoder().encode([newContact])
                defaults.set(encodeData, forKey: "contactsArray")
            }
            
        } catch{
            print("Unable to encode \(error)")
        }
        textFieldName.text = ""
        textFieldNumber.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

