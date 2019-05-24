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

    var listEmployes:[EmployeeStruct]?
    var userSelected:EmployeeStruct?
    
    var image:UIImage = UIImage(named: "torta-de-cumpleanos")!
    var message:String? = "Te invito a mi fiesta"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        getDataForCoreData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.listEmployes?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = listEmployes![indexPath.row].fullName
        
        //listEmployes![indexPath.row].getDaysForDOB()
        
        let cellAudioButton = UIButton(type: .custom)
        cellAudioButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        cellAudioButton.addTarget(self, action: #selector(btnShare(sender : )), for: .touchUpInside)
        cellAudioButton.setImage(UIImage(named: "torta-de-cumpleanos"), for: .normal)
        cellAudioButton.contentMode = .scaleAspectFit
        cellAudioButton.tag = indexPath.row
        cell.accessoryView = cellAudioButton as UIView
        
        return cell
    }
    
    
    @objc func btnShare(sender : UIButton) {
        let activityController = UIActivityViewController(activityItems:[image,message ?? "Te invito a mi fiesta"], applicationActivities:nil)
        activityController.excludedActivityTypes = [ UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToVimeo]
        present(activityController,animated: true,completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userSelected = self.listEmployes![indexPath.row]
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
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
    }

}
