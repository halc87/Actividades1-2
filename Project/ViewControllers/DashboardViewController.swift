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
    @IBOutlet weak var btEmployee: UIButton!
    @IBOutlet weak var btCollector: UIButton!
    
    var user:Usuario?
    var wsstruct:WSStruct?
    var listUsers:[Usuario]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btEmployee.isEnabled = false
        btCollector.isEnabled = false
        
        lblWelcome.text = "Bienvenido \(user!.name ?? "") "
        getData()
        
        let usuario1 = Usuario(name: "Sergio Luna", phone: 34734767456, email: "correo1@gmail.com", DOB: "23/07/1986", rol: "Jefe de cobranza", address: "", notes: "Nota 1", personVisit: "Sergio Sepulveda", amount: "$600.00")
        let usuario2 = Usuario(name: "Ana Sanchez", phone: 34734767456, email: "correo2@gmail.com", DOB: "22/09/1987", rol: "Cobrador", address: "", notes: "Nota 1", personVisit: "Sergio Sepulveda", amount: "$1200.00")
        let usuario3 = Usuario(name: "Hugo Rosete", phone: 34734767456, email: "correo3@gmail.com", DOB: "09/07/1990", rol: "Cobrador", address: "", notes: "Nota 1", personVisit: "Sergio Sepulveda", amount: "$7000.00")
        let usuario4 = Usuario(name: "Saul Marquez", phone: 34734767456, email: "correo4@gmail.com", DOB: "23/09/1990", rol: "Jefe de cobranza", address: "", notes: "Nota 1", personVisit: "Sergio Sepulveda", amount: "$300.00")
        let usuario5 = Usuario(name: "Alejandro Navarro", phone: 34734767456, email: "correo5@gmail.com", DOB: "15/06/1987", rol: "Cobrador", address: "", notes: "Nota 1", personVisit: "Sergio Sepulveda", amount: "$400.00")
        
        listUsers = [usuario1,usuario2, usuario3, usuario4, usuario5]
        
    }
    

    @IBAction func btnListEmploye(_ sender: Any) {
        
        performSegue(withIdentifier: "segueToListEmploye", sender: self.arrayUser)
    }
    
    @IBAction func btnListCollectors(_ sender: Any) {
        
        performSegue(withIdentifier: "segueToListCollectors", sender:self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ListEmployeTableViewController{
             destVC.listEmployes = self.wsstruct?.data
        }
        
        if let destVC = segue.destination as? ListCollectorsTableViewController{
            destVC.listEmployes = self.wsstruct?.data
            destVC.listUsers = self.listUsers
        }
    }
    
    func getData(){
        let request = URLRequest(url: URL(string: "http://www.develogeeks.com/netec/capitulo4/consumoApi/Empleados/getList.php")!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print("Error :\(String(describing: error))")
            }else{
                if let resp = data{
                    do{
                        self.wsstruct = try JSONDecoder().decode(WSStruct.self, from: resp)
                        self.btEmployee.isEnabled = true
                        self.btCollector.isEnabled = true
                        
                    }catch{
                        print("Error al realizar el parseop con el decoder")
                    }
                }
            }
        }
        task.resume()
        return
    }
    
    func printDataEmployeeStruct(listEmployees:[EmployeeStruct]){
        for emp in listEmployees{
            print("Direccion \(String(describing: emp.address))")
        }
    }

}
