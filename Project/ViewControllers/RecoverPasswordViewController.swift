//
//  RecoverPasswordViewController.swift
//  Project
//
//  Created by Macbook on 20/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class RecoverPasswordViewController: MasterViewController {

    var user:Usuario?
    @IBOutlet weak var txfEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRecoverEmail(_ sender: Any) {
        if validateEmail(){
            self.showAlert(titleS: "Password", messageS: "Tu password es : \(user?.password! ?? "")")
        }
    }
    
    func validateEmail()->Bool{
        if (txfEmail.text?.isEmpty)!{
            self.showAlert(titleS: "Email", messageS: "Favor de ingresar un correo")
            return false
        }
        
        if txfEmail.text != user?.email{
            self.showAlert(titleS: "Email", messageS: "El correo no esta registrado")
            return false
        }
        
        return true
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
