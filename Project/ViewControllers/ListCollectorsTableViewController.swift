//
//  ListCollectorsTableViewController.swift
//  Project
//
//  Created by Macbook on 23/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class ListCollectorsTableViewController: UITableViewController {

    var listUsers:[Usuario]?
    var listEmployes:[EmployeeStruct]?
    
    var userSelected:Usuario?
    var employeeSelected:EmployeeStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        userSelected = nil
//        employeeSelected = nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listUsers?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let usuario = listUsers?[indexPath.row]
        
        if usuario?.rol == "Jefe de cobranza"{
            cell.backgroundColor = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
            cell.textLabel?.textColor = UIColor.white
            cell.accessoryView = nil
        }else{
            let cellAudioButton = UIButton(type: .custom)
            cellAudioButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            //cellAudioButton.addTarget(self, action: #selector(btnRutes(sender:)), for: .touchUpInside)
            cellAudioButton.setImage(UIImage(named: "icons8-aventura-filled-50"), for: .normal)
            cellAudioButton.contentMode = .scaleAspectFit
            cellAudioButton.tag = indexPath.row
            cell.accessoryView = cellAudioButton as UIView
        }
        
        cell.textLabel?.text = usuario?.name

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuario = listUsers![indexPath.row]
        let employee = listEmployes![indexPath.row]
        
        if usuario.rol != "Jefe de cobranza"{
            self.userSelected = usuario
            self.employeeSelected = employee
            performSegue(withIdentifier: "segueToMapDetail", sender: nil )
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? MapDetailViewController{
            destVC.userSelected = userSelected
            destVC.employeeSelected = employeeSelected
        }
    }

}
