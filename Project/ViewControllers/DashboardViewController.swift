//
//  DashboardViewController.swift
//  Project
//
//  Created by Macbook on 20/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class DashboardViewController: MasterViewController {

    @IBOutlet weak var lblWelcome: UILabel!
    
    var user:Usuario?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblWelcome.text = "Bienvenido \(user!.name ?? "") "
    }
    

    @IBAction func btnListEmploye(_ sender: Any) {
        
        performSegue(withIdentifier: "segueToListEmploye", sender: self.arrayUser)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ListEmployeTableViewController{
             destVC.listEmployes = self.arrayUser
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
