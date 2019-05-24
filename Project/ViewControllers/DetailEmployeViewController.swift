//
//  DetailEmployeViewController.swift
//  Project
//
//  Created by Macbook on 20/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit
import CoreData

class DetailEmployeViewController: MasterViewController {

    
    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var txfEmail: UITextField!
    
    @IBOutlet weak var txfCompany: UITextField!
    @IBOutlet weak var txfArea: UITextField!
    @IBOutlet weak var txfNumEmployee: UITextField!
    @IBOutlet weak var txfAntiquity: UITextField!
    @IBOutlet weak var txfDateOfHire: UITextField!
    @IBOutlet weak var txfDOB: UITextField!
    @IBOutlet weak var txfYears: UITextField!
    @IBOutlet weak var txfPhoto: UITextField!
    @IBOutlet weak var civilStatus: UITextField!
    @IBOutlet weak var txfGeolocalization: UITextField!
    @IBOutlet weak var txfCharge: UITextField!
    @IBOutlet weak var txfProducts: UITextField!
    
    var user:Usuario?
    var image:UIImage = UIImage(named: "torta-de-cumpleanos")!
    var message:String? = "Te invito a mi fiesta"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txfName.delegate = self
        txfEmail.delegate = self
        txfPhoto.delegate = self
        txfGeolocalization.delegate = self
        txfCompany.delegate = self
        txfArea.delegate = self
        txfNumEmployee.delegate = self
        txfAntiquity.delegate = self
        txfDateOfHire.delegate = self
        txfDOB.delegate = self
        txfYears.delegate = self
        civilStatus.delegate = self
        txfCharge.delegate = self
        txfProducts.delegate = self
        
        
        
        txfName.text = user!.name
        txfEmail.text = user!.email
        txfPhoto.text = user!.lastName
        txfGeolocalization.text = user!.secondLastName
        txfCompany.text = ""
        txfArea.text = ""
        txfNumEmployee.text = "\(String(describing: user!.employeNumber!))"
        txfAntiquity.text = ""
        txfDateOfHire.text = ""
        txfDOB.text =  user!.DOB
        txfYears.text = ""
        civilStatus.text = ""
        txfCharge.text = user!.phone
        txfProducts.text = user!.password
        
    }
    
    
    @IBAction func btnShare(_ sender: Any) {
//        let activityController = UIActivityViewController(activityItems:[image,message ?? "Te invito a mi fiesta"], applicationActivities:nil)
//        activityController.excludedActivityTypes = [ UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToVimeo]
//        present(activityController,animated: true,completion: nil)
        self.coreDataSaveUser()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func coreDataSaveUser(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let idEmpleado = user?.employeNumber!
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "employeNumber = %@", idEmpleado!)
                do {
                    
                    let record = try context.fetch(request)
                    
                    let recordToUpdate = record[0] as! NSManagedObject
                    
                    print(recordToUpdate.value(forKey: "name"))
                    
                    recordToUpdate.setValue(txfName.text!, forKey: "name")
                    recordToUpdate.setValue(txfPhoto.text!, forKey: "lastname")
                    recordToUpdate.setValue(txfGeolocalization.text!, forKey: "secondlastname")
                    recordToUpdate.setValue(txfEmail.text!, forKey: "email")
                    recordToUpdate.setValue(txfCharge.text!, forKey: "phone")
                    recordToUpdate.setValue(txfDOB.text!, forKey: "dob")
                    recordToUpdate.setValue(txfProducts.text!, forKey: "password")
                    do{
                    try context.save()
                        let alert = UIAlertController(title: "Actualizar", message: "Tu registro se ha actiualizado", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler:{ action in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        
                        self.present(alert, animated: true)
                    }catch{
                        self.showAlert(titleS: "No Actualizado", messageS: "Registro no actualizado")
                        print("Failed saving")
                    }
                    
                } catch {
                    self.showAlert(titleS: "No Actualizado", messageS: "Registro no actualizado")
                    print("Failed saving")
                }
            }
   

    @IBAction func btnElikminar(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let idEmpleado = user?.employeNumber!
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "employeNumber = %@", idEmpleado!)
        do {
            
            let record = try context.fetch(request)
            
            let recordToUpdate = record[0] as! NSManagedObject
            
            recordToUpdate.setValue("0", forKey: "activo")
  
            do{
                try context.save()
                let alert = UIAlertController(title: "Eliminar", message: "Tu registro se ha eliminado", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler:{ action in
                    self.navigationController?.popViewController(animated: true)
                }))
                
                self.present(alert, animated: true)
            }catch{
                self.showAlert(titleS: "No Actualizado", messageS: "Registro no eliminado")
                print("Failed saving")
            }
            
        } catch {
            self.showAlert(titleS: "No Actualizado", messageS: "Registro no actualizado")
            print("Failed saving")
        }
    }
    
}


extension DetailEmployeViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
