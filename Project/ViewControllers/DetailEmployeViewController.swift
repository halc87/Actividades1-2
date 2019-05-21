//
//  DetailEmployeViewController.swift
//  Project
//
//  Created by Macbook on 20/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class DetailEmployeViewController: UIViewController {

    
    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var txfDOB: UITextField!
    @IBOutlet weak var txfYears: UITextField!
    @IBOutlet weak var txfRelationship: UITextField!
    @IBOutlet weak var txfGeolocalization: UITextField!
    
    var user:Usuario?
    var image:UIImage = UIImage(named: "torta-de-cumpleanos")!
    var message:String? = "Te invito a mi fiesta"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txfName.text = "\(user?.name ?? "") \(user?.lastName ?? "") \(user?.secondLastName ?? "")"
        
        txfDOB.text = user?.DOB
        txfYears.text = "\(user!.getYears())"
        txfGeolocalization.text = ""
        txfRelationship.text = ""
        
        
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
