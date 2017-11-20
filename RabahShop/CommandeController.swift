//
//  CommandeController.swift
//  e-commerce CPA
//
//  Created by yacine yakoubi on 13/07/16.
//  Copyright © 2016 TheAppGuruz-New-6. All rights reserved.
//

import UIKit

class CommandeController: UIViewController {

    var itemPost:Post = Post()
    var commande:Commande = Commande()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Commande"
        view.backgroundColor = UIColor(r:205, g: 205, b:205)
        view.addSubview(nomComplet)
        view.addSubview(prenomComplet)
        view.addSubview(email)
        view.addSubview(phone)
        view.addSubview(adress)
        view.addSubview(commandeButton)
        setUpTextFields()


    }
    
    
    lazy var commandeButton:UIButton = {
        
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor (r:170, g:31, b:38)
        button.setTitle("Commander", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        
        button.addTarget(self, action: #selector(handleCommande) , forControlEvents: .TouchUpInside)
        return button
        
    }()

    
    func handleCommande(){
        
    
        //let myUrl = NSURL(string: "http://oo-emarketplace.rhcloud.com/affiliate/index/recupcommande");

        let myUrl = NSURL(string: "http://oo-emarketplace.rhcloud.com/affiliate/index/recupcommande");
        let request = NSMutableURLRequest(URL:myUrl!);
        
        request.HTTPMethod = "POST";// Compose a query string
        
       // let postString = "firstName=James & lastName=Bond";
        

        
        let postString = "caffiliate_nom=\(nomComplet.text!) & caffiliate_prenom=\(prenomComplet.text!) & caffiliate_adresse=\(adress.text!) & caffiliate_tel=\(phone.text!) & caffiliate_email=\(email.text!) & action=0 & id_produit=\(itemPost.prodId) & id_produit_affiliate=\(itemPost.evendorStock) & id_evendor=\(itemPost.evendorId) & id_evendor_affiliate=\(itemPost.evendor_aff) & id_evendor_produit=\(itemPost.id_evendor_prod)"
        
        //print(postString) \(itemPost.evendorId)
       // print(postString13)
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
            
            // Print out response body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                let myJSON =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                if let parseJSON = myJSON {
                    
                    // Now we can access value of First Name by its key
                    var pdf_name =  " "
                    var costumer_name = " "
                    var costumer_firstname = " "
                    var confirmation = " "
                    var link = " "
                    var reservation_code = " "
                    
                    if ((parseJSON["nom_pdf"]) is NSNull) {
                    }else{
                         pdf_name = (parseJSON["nom_pdf"] as? String)!

                    }
                    if ((parseJSON["nomclient"]) is NSNull) {
                    }else{
                         costumer_name = (parseJSON["nomclient"] as? String)!

                    }
                    if ((parseJSON["prenomclient"]) is NSNull) {
                    }else{
                         costumer_firstname = (parseJSON["prenomclient"] as? String)!

                    }
                    if ((parseJSON["confirmation"]) is NSNull) {
                    }else{
                         confirmation = (parseJSON["confirmation"] as? String)!

                    }
                    if ((parseJSON["lien"]) is NSNull) {
                    }else{
                         link = (parseJSON["lien"] as? String)!

                    }
                    if ((parseJSON["code_reservation"]) is NSNull) {
                    }else{
                        reservation_code = (parseJSON["code_reservation"] as? String)!

                    }
                    
                    self.commande = Commande(pdf_name: pdf_name,costumer_name: costumer_name, costumer_firstname: costumer_firstname, confirmation: confirmation, link: link, reservation_code: reservation_code)!
                    
                    
                    let commandeController = PdfReader()
                    
                    commandeController.commande = self.commande
                    
                    self.navigationController?.pushViewController(commandeController, animated: true)

                }
            } catch {
                print(error)
            }
        }
        task.resume()

        
}

    let nomComplet:UITextField = {
        
        let dl = UITextField()
        dl.placeholder = "Nom"
        dl.translatesAutoresizingMaskIntoConstraints = false
        return dl
        
    }()
    
    let prenomComplet:UITextField = {
        
        let dl = UITextField()
        dl.placeholder = "Prénom"
        dl.translatesAutoresizingMaskIntoConstraints = false
        return dl
        
    }()
    
    
    let email:UITextField = {
        
        let dl = UITextField()
        dl.placeholder = "Email"

        dl.translatesAutoresizingMaskIntoConstraints = false
        return dl
        
    }()
    
    let phone:UITextField = {
        
        let dl = UITextField()
        dl.placeholder = "Tél"

        dl.translatesAutoresizingMaskIntoConstraints = false
        return dl
        
    }()
    
    
    let adress:UITextField = {
        
        let dl = UITextField()
        dl.placeholder = "Addresse"

        dl.translatesAutoresizingMaskIntoConstraints = false
        return dl
        
    }()
    
    
   func setUpTextFields() {
    
    self.nomComplet.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    self.nomComplet.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 8).active = true
    self.nomComplet.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -16).active = true
    self.nomComplet.heightAnchor.constraintEqualToConstant(30).active = true
    self.nomComplet.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 80).active = true
    
    self.prenomComplet.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    self.prenomComplet.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 8).active = true
    self.prenomComplet.topAnchor.constraintEqualToAnchor(nomComplet.bottomAnchor, constant: 8).active = true
    self.prenomComplet.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -16).active = true
    self.prenomComplet.heightAnchor.constraintEqualToConstant(30).active = true

    self.email.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    self.email.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 8).active = true
    self.email.topAnchor.constraintEqualToAnchor(prenomComplet.bottomAnchor, constant: 8).active = true
    self.email.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -16).active = true
    self.email.heightAnchor.constraintEqualToConstant(30).active = true
    
    
    self.phone.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    self.phone.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 8).active = true
    self.phone.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -16).active = true
    self.phone.topAnchor.constraintEqualToAnchor(email.bottomAnchor, constant: 10).active = true
    self.phone.heightAnchor.constraintEqualToConstant(30).active = true
    
    
    self.adress.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    self.adress.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 8).active = true
    self.adress.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -16).active = true
    self.adress.topAnchor.constraintEqualToAnchor(phone.bottomAnchor, constant: 10).active = true
    self.adress.heightAnchor.constraintEqualToConstant(30).active = true
    

    
    self.commandeButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    self.commandeButton.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 8).active = true
    self.commandeButton.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -50).active = true
    self.commandeButton.topAnchor.constraintEqualToAnchor(adress.bottomAnchor, constant: 20).active = true
    self.commandeButton.heightAnchor.constraintEqualToConstant(30).active = true
    
    
    }
    
    

 

}

extension NSMutableURLRequest {
    func setBodyContent(contentMap: Dictionary<String, String>) {
        var firstOneAdded = false
        var contentBodyAsString = String()
        let contentKeys:Array<String> = Array(contentMap.keys)
        for contentKey in contentKeys {
            if(!firstOneAdded) {
                
                contentBodyAsString = contentBodyAsString + contentKey + "=" + contentMap[contentKey]!
                firstOneAdded = true
            }
            else {
                contentBodyAsString = contentBodyAsString + "&" + contentKey + "=" + contentMap[contentKey]!
            }
        }
        contentBodyAsString = contentBodyAsString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        self.HTTPBody = contentBodyAsString.dataUsingEncoding(NSUTF8StringEncoding)
    }
}
