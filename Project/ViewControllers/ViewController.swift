//
//  ViewController.swift
//  Project
//
//  Created by Macbook on 20/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class ViewController: MasterViewController {

    @IBOutlet weak var txfUser: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    var user:Usuario?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        txfPassword.text = ""
        txfUser.text = ""
        
        if user == nil{
            user = Usuario(withData: true)
            self.arrayUser.append(user!)
        }
    }
    
    @IBAction func btnRecoverPassword(_ sender: Any) {
        performSegue(withIdentifier: "segueToRecoverPassword", sender: self)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
    
         if validateLogin(){
            performSegue(withIdentifier: "segueToDashboard", sender: self)
        }
    }
    
    @IBAction func btnToRegister(_ sender: Any) {
       
            performSegue(withIdentifier: "segueToRegister", sender: self)
            
       
    }
    
    private func validateLogin()->Bool{
        
        if (txfUser.text?.isEmpty)!{
            self.showAlert(titleS: "Usuario", messageS: "Favor de ingresar un usuario valido")
            return false
        }
        
        if !isValidEmail(testStr: txfUser.text!){
            self.showAlert(titleS: "Usuario", messageS: "Correo inválido ejem. correo@gmail.com")
            return false
        }
        
        if (txfPassword.text?.isEmpty)!{
            self.showAlert(titleS: "Password", messageS: "Favor de ingresar el password")
            return false
        }
        
        if txfUser.text != user?.email{
            self.showAlert(titleS: "Usuario", messageS: "El usuario no esta registrado")
            return false
        }
        
        if txfPassword.text != user?.password{
            self.showAlert(titleS: "Password", messageS: "El password es incorrecto")
            return false
        }
        
    
        
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecoverPassword"{
            if let destination = segue.destination as? RecoverPasswordViewController{
                destination.user = self.user
            }
        }
        
        if segue.identifier == "segueToDashboard"{
            if let destination = segue.destination as? DashboardViewController{
                 destination.user = self.user
                destination.arrayUser = self.arrayUser
            }
        }
        
    }
    
    @IBAction func unwindRegister(_ sender: UIStoryboardSegue){
        if let senderVC = sender.source as? RegisterViewController{
            self.user = senderVC.user
            self.arrayUser.append(senderVC.user!)
        }
    }
    
}

