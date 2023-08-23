//
//  TableViewController.swift
//  ContactsTabBar
//
//  Created by Nuradil Serik on 23.08.2023.
//

import UIKit

class MyCell: UITableViewCell{
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var notAvailableImage: UIImageView!
}

class TableViewController: UITableViewController {
    
    @IBOutlet weak var notAvailablePhoto: UIImageView!
    var arrayContacts:[ContactsItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayContacts.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        do{
            if let data = defaults.data(forKey: "contactsArray"){
                let array = try JSONDecoder().decode([ContactsItem].self, from: data)
                
                arrayContacts = array
            }
            
        } catch{
            print("Unable to encode \(error)")
        }
        tableView.reloadData()
    }
    
    func save(){
        let defaults = UserDefaults.standard
        do{
            let encodeData = try JSONEncoder().encode(arrayContacts)
            defaults.set(encodeData, forKey: "contactsArray")
            
        } catch{
            print("Unable to encode \(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCell
//        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "Cell") as! MyCell
       
        cell.textLabel?.text = arrayContacts[indexPath.row].name
        cell.numberLabel.text = arrayContacts[indexPath.row].number

        if !arrayContacts[indexPath.row].isAvailable{
            cell.notAvailableImage.isHidden = false
        } else{
            cell.notAvailableImage.isHidden = true
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        arrayContacts[indexPath.row].isAvailable.toggle()
        
        tableView.reloadData()
        
        save()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayContacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            save()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
  

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
