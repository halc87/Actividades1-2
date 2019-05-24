//
//  ListEmployeTableViewController.swift
//  Project
//
//  Created by Macbook on 20/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit
import CoreData

class ListEmployeTableViewController: UITableViewController {

    var listEmployes:[Usuario] = []
    var userSelected:Usuario?
    
    var image:UIImage = UIImage(named: "torta-de-cumpleanos")!
    var message:String? = "Te invito a mi fiesta"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         listEmployes = []
         getDataForCoreData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listEmployes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let user = listEmployes[indexPath.row]
        
        cell.textLabel?.text = user.name ?? "" 
        
//        listEmployes![indexPath.row].getDaysForDOB()
//        
//        let cellAudioButton = UIButton(type: .custom)
//        cellAudioButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        cellAudioButton.addTarget(self, action: #selector(btnShare(sender : )), for: .touchUpInside)
//        cellAudioButton.setImage(UIImage(named: "torta-de-cumpleanos"), for: .normal)
//        cellAudioButton.contentMode = .scaleAspectFit
//        cellAudioButton.tag = indexPath.row
//        cell.accessoryView = cellAudioButton as UIView
        
        return cell
    }
    
    
    @objc func btnShare(sender : UIButton) {
        let activityController = UIActivityViewController(activityItems:[image,message ?? "Te invito a mi fiesta"], applicationActivities:nil)
        activityController.excludedActivityTypes = [ UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToVimeo]
        present(activityController,animated: true,completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userSelected = self.listEmployes[indexPath.row]
        if userSelected != nil{
            performSegue(withIdentifier: "segueToDetailUser", sender: nil)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? DetailEmployeViewController{
            destVC.user = self.userSelected
        }
    }
    
    
    func getDataForCoreData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "activo = %@", "1")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name"))
                print(data.value(forKey: "activo"))
                let user = Usuario()
                user.name = data.value(forKey: "name") as? String
                user.lastName = data.value(forKey: "lastname")  as? String
                user.secondLastName = data.value(forKey: "secondlastname") as? String
                user.DOB = data.value(forKey: "dob") as? String
                user.email = data.value(forKey: "email") as? String
                user.employeNumber = data.value(forKey: "employeNumber") as? String
                user.password = data.value(forKey: "password") as? String
                user.phone = data.value(forKey: "phone") as? String
                self.listEmployes.append(user)
            }
            tableView.reloadData()
        } catch {
            
            print("Failed")
        }
    }

}
