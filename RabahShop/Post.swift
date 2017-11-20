//
//  Post.swift
//  JSONDemo
//
//  Created by yacine yakoubi on 28/06/16.
//  Copyright © 2016 TheAppGuruz-New-6. All rights reserved.
//

import UIKit



public class Post {


    
    
    var prodName  : String = " "
    var prodModel  : String = " "
    var prodBigPic  : String = " "
    var prodSmallPic  : String = " "
    var evendorId  : String = " "
    var evendorName  : String = " "
    var evendorLogo  : String = " "
    var evendorAdress  : String = " "
    var evendorWilaya  : String = " "
    var evendorCommune  : String = " "
    var evendorTel  : String = " "
    var evendorMail  : String = " "
    var evendorPrice  : String = " "
    var evendorStock  : String = " "
    var prodDesc  : String = " "
    var prodId  : String = " "
    var prodPromo  : String = " "
    var promoPrice  : String = " "
    var marqueId  : String = " "
    var marqueIdaff  : String = " "
    var evendor_aff : String = " "
    var id_evendor_prod :String = " "
    
    
    

    init? (prodName: String, prodModel: String, prodBigPic: String, prodSmallPic: String,evendorId : String ,evendorName: String,evendorLogo: String,evendorAdress: String,evendorWilaya: String,evendorCommune: String,evendorTel: String, evendorMail: String,evendorPrice: String,prodDesc: String, evendorStock: String, prodId:String, prodPromo: String, promoPrice: String,marqueId  : String,marqueIdaff  : String,evendor_aff:String ,id_evendor_prod:String )
    {
    
        self.prodName = prodName
        self.prodModel = prodModel
        self.prodBigPic = prodBigPic
        self.prodSmallPic = prodSmallPic
        self.evendorId = evendorId
        self.evendorName = evendorName
        self.evendorLogo = evendorLogo
        self.evendorAdress = evendorAdress
        self.evendorWilaya = evendorWilaya
        self.evendorCommune = evendorCommune
        self.evendorTel = evendorTel
        self.evendorMail = evendorMail
        self.evendorPrice = evendorPrice
        self.evendorStock = evendorStock
        self.prodDesc = prodDesc
        self.prodId = prodId
        self.prodPromo = prodPromo
        self.promoPrice = promoPrice
        self.marqueId = marqueId
        self.marqueIdaff = marqueIdaff
        self.evendor_aff = evendor_aff
        self.id_evendor_prod = id_evendor_prod
    
    }
    
    init () {

        
    }


}
