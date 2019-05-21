//
//  RegisterViewController.swift
//  Project
//
//  Created by Macbook on 20/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

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
    
    @IBAction func btnRegisterUser(_ sender: Any) {
        user = Usuario()
        
        user?.DOB = txfDatePicker.text
        user?.name = txfName.text
        user?.lastName = txfAPaterno.text
        user?.secondLastName = txfAMaterno.text
        user?.email = txfEmail.text
        user?.employeNumber = txfNumEmploye.text
        user?.phone = Int(txfPhone.text ?? "")
        user?.password = txfPassword.text
    }
    
}
