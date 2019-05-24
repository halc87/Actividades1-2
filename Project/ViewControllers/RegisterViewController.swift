//
//  RegisterViewController.swift
//  Project
//
//  Created by Macbook on 20/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: MasterViewController {

    
    //MARK IBOUTLETS
    @IBOutlet weak var txfDatePicker: UITextField!
    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var txfAPaterno: UITextField!
    @IBOutlet weak var txfAMaterno: UITextField!
    @IBOutlet weak var txfNumEmploye: UITextField!
    @IBOutlet weak var txfPhone: UITextField!
    @IBOutlet weak var txfEmail: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var txfConfPassword: UITextField!
    
    var user:Usuario?
    
    //MARK private properties
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showDatePicker()
    }
    
    
    
    //MARK private func
    
   private func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        let loc = Locale(identifier: "es")
        self.datePicker.locale = loc
    
        let calendar = Calendar(identifier: .gregorian)
    
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
    
        components.year = -18
        components.month = 12
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
    
        components.year = -130
        let minDate = calendar.date(byAdding: components, to: currentDate)!
    
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate

    
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Aceptar", style: .plain, target: self, action: #selector(donedatePicker));
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txfDatePicker.inputAccessoryView = toolbar
        txfDatePicker.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txfDatePicker.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func validateFields() ->Bool{
        
        
        if (txfName.text?.isEmpty)!{
            showAlert(titleS: "Error", messageS: "Falta llenar Nombre")
            return false
        }
        
        if (txfAPaterno.text?.isEmpty)!{
            showAlert(titleS: "Error", messageS: "Falta llenar Apellido paterno")
            return false
        }
        
        
        if (txfAMaterno.text?.isEmpty)!{
            showAlert(titleS: "Error", messageS: "Falta llenar Apellido materno")
            return false
        }
        
        
        if (txfDatePicker.text?.isEmpty)!{
            showAlert(titleS: "Error", messageS: "Falta llenar fecha de nacimiento")
            return false
        }
        
        
        if (txfNumEmploye.text?.isEmpty)!{
            showAlert(titleS: "Error", messageS: "Falta llenar número de empleado")
            return false
        }
        
        if (txfPhone.text?.isEmpty)!{
            showAlert(titleS: "Error", messageS: "Falta llenar telefono")
            return false
        }
        
        if (txfEmail.text?.isEmpty)!{
            showAlert(titleS: "Error", messageS: "Falta llenar correo")
            return false
        }

       
        
        if (txfPassword.text?.isEmpty)!{
            showAlert(titleS: "Error", messageS: "Falta llenar password")
            return false
        }
        
        if (txfConfPassword.text?.isEmpty)!{
            showAlert(titleS: "Error", messageS: "Falta llenar confirmacion de password")
            return false
        }
        
        
        if txfConfPassword.text != txfPassword.text{
            showAlert(titleS: "Error", messageS: "el passwor es diferente")
            return false
        }
        
        return true
    }
    
    @IBAction func btnRegisterUser(_ sender: Any) {
        
        if validateFields(){
            user = Usuario()

            user?.DOB = txfDatePicker.text
            user?.name = txfName.text
            user?.lastName = txfAPaterno.text
            user?.secondLastName = txfAMaterno.text
            user?.email = txfEmail.text
            user?.employeNumber = txfNumEmploye.text
            user?.phone = txfPhone.text
            user?.password = txfPassword.text
            coreDataSaveUser()
        }else{
            user = Usuario()
        }
        
    }
    
    
    func coreDataSaveUser(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(txfNumEmploye.text!, forKey: "employeNumber")
        newUser.setValue(txfName.text!, forKey: "name")
        newUser.setValue(txfAPaterno.text!, forKey: "lastname")
        newUser.setValue(txfAMaterno.text!, forKey: "secondlastname")
        newUser.setValue(txfEmail.text!, forKey: "email")
        newUser.setValue(txfPhone.text!, forKey: "phone")
        newUser.setValue(txfDatePicker.text!, forKey: "dob")
        newUser.setValue(txfPassword.text!, forKey: "password")
        newUser.setValue("1", forKey: "activo")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
