//
//  DetailEmployeViewController.swift
//  Project
//
//  Created by Macbook on 20/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

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
    
    var user:EmployeeStruct?
    var image:UIImage = UIImage(named: "torta-de-cumpleanos")!
    var message:String? = "Te invito a mi fiesta"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txfName.text = user!.fullName!
        txfEmail.text = user!.email
        txfPhoto.text = user!.photo
        txfGeolocalization.text = user!.address
        txfCompany.text = user!.company
        txfArea.text = user!.area
        txfNumEmployee.text = "\(String(describing: user!.idEmployee!))"
        txfAntiquity.text = user!.seniority
        txfDateOfHire.text = user!.getDateInPayRoll()
        txfDOB.text =  user!.getDateOfBirthday()
        txfYears.text = "\(user!.getYears())"
        civilStatus.text = user!.maritalStatus
        txfCharge.text = user!.role
        txfProducts.text = user!.productsPurchased
        
    }
    
    
    @IBAction func btnShare(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems:[image,message ?? "Te invito a mi fiesta"], applicationActivities:nil)
        activityController.excludedActivityTypes = [ UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToVimeo]
        present(activityController,animated: true,completion: nil)
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
