//
//  EmployeeStruct.swift
//  Project
//
//  Created by Macbook on 21/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

class EmployeeStruct : Decodable{
    var idEmployee:Int? //Numero de empleado
    var fullName:String? // Nombre completo
    var email:String? // Correo
    var photo:String? // fotografía
    var address:String? // Dirección
    var company:String? // Empresa
    var area:String? // Area
    var seniority:String? // Antigüedad
    var dateInPayroll:String? // Fecha de contratación
    var birthday:String? // Cumpleaños
    var age:String? // Edad
    var maritalStatus:String? // Estado civil
    var role:String? // Cargo
    var productsPurchased:String? // Productos adquiridos en la compañia
    
    init?(){
        return nil
    }
    
    func getDateOfBirthday()->String{
        
        if let timeinterval = Double(self.birthday!){
            let date = Date(timeIntervalSince1970: timeinterval)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd/MM/yyyy" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            return strDate
        }
        return ""
    }
    
    func getDateInPayRoll()->String{
        
        if let timeinterval = Double(self.dateInPayroll!){
            let date = Date(timeIntervalSince1970: timeinterval)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd/MM/yyyy" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            return strDate
        }
        return ""
    }
    
    func getYears() -> Int{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        let birthdayDate = dateFormater.date(from: self.getDateOfBirthday())
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate ?? Date(), to: now, options: [])
        let age = calcAge.year
        return age!
        
    }
    
    func getDaysForDOB(){
        let calendar = NSCalendar.current
         if let timeinterval = Double(self.birthday!){
            let fecha_desde = calendar.startOfDay(for: Date(timeIntervalSince1970: timeinterval))
            let fecha_hasta = calendar.startOfDay(for: Date())
            let dias = Set<Calendar.Component>([.day])
            let result = calendar.dateComponents(dias, from: fecha_desde as   Date,  to: fecha_hasta as Date)
            print("dias: \(result.day)")
        }
    }
    
}
