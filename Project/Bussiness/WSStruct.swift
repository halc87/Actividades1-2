//
//  WSStruct.swift
//  Project
//
//  Created by Macbook on 21/05/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

class WSStruct : Decodable{
    
    var status:Bool?
    var data : [EmployeeStruct]?
    
    init?(){
        return nil
    }
}
