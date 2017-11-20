//
//  Commande.swift
//  e-commerce CPA
//
//  Created by yacine yakoubi on 20/07/16.
//  Copyright © 2016 TheAppGuruz-New-6. All rights reserved.
//

import UIKit

public class Commande {
    
    var pdf_name = " "
    var costumer_name = " "
    var costumer_firstname = " "
    var confirmation = " "
    var link = " "
    var reservation_code = " "
    
    
    init?(pdf_name: String,costumer_name:String, costumer_firstname:String, confirmation:String, link: String, reservation_code:String){
    
        self.pdf_name = pdf_name
        self.costumer_name = costumer_name
        self.costumer_firstname = costumer_firstname
        self.confirmation = confirmation
        self.link = link
        self.reservation_code = reservation_code
        
    
    }
    
    init(){
    
    }

}
