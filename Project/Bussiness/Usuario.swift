//
//  Usuario.swift
//  Project
//
//  Created by Macbook on 20/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

public class Usuario{
    
    public var name:String?
    public var lastName:String?
    public var secondLastName:String?
    public var phone:String?
    public var email:String?
    public var password:String?
    public var DOB:String?
    public var employeNumber:String?
    public var rol:String?
    public var address:String?
    public var notes:String?
    public var personVisit:String?
    public var amount:String?
    
    
    init(){
        self.name = nil
        self.lastName = nil
        self.secondLastName = nil
        self.phone = nil
        self.email = nil
        self.password = nil
        self.DOB = nil
        self.employeNumber = nil
        self.rol = nil
        self.address = nil
        self.notes = nil
        self.personVisit = nil
        self.amount = nil
    }
    
    init(withData:Bool){
        self.name = "Hugo"
        self.lastName = "Lechuga"
        self.secondLastName = "Canales"
        self.phone = "5528832513"
        self.email = "deshugo@gmail.com"
        self.password = "1234"
        self.DOB = "25/06/1987"
        self.employeNumber = "343259"
        self.rol = "Jefe de cobranza"
    }
    
    
    
    
    init(name:String, phone:String, email:String, DOB:String, rol:String, address:String, notes:String, personVisit:String, amount:String){
        
        self.name = name
        self.phone = phone
        self.email = email
        self.DOB = DOB
        self.rol = rol
        self.address = address
        self.notes = notes
        self.personVisit = personVisit
        self.amount = amount
    }
    
    @discardableResult
    func getYears() -> Int{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        let birthdayDate = dateFormater.date(from: self.DOB ?? "")
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
}
