//
//  DetailsController.swift
//  e-commerce CPA
//
//  Created by yacine yakoubi on 13/07/16.
//  Copyright © 2016 TheAppGuruz-New-6. All rights reserved.
// Voila mnt click sur un row pr voir , celui qui change de page, bain j mis ca ds l avarelegate
// mais regarde le blem 
 

import UIKit

class DetailsController: UIViewController , UIScrollViewDelegate{

    
    var item :Post = Post()
    var scrollView: UIScrollView!
    var containerView = UIView()

    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(r:205, g: 205, b:205)
        self.navigationItem.title = item.prodModel

        self.scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
      self.scrollView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.size.width, height: 700)
        containerView = UIView()
        
        
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        
        
        containerView.addSubview(prodImageDetails)
        containerView.addSubview(prodDesc)
        containerView.addSubview(prodPrice)
        containerView.addSubview(commandeButton)

        
        create()
        setUpFieldsView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)

    }
    

    
    func create(){
        
        
        if let url = NSURL(string: item.prodSmallPic as String) {
            if let data = NSData(contentsOfURL: url) {
                
                prodImageDetails.image = UIImage(data: data)
            }
            
        }
        
        
        prodDesc.text = item.prodDesc.stringByReplacingOccurrencesOfString("\r\n", withString: "")
        let font = UIFont.systemFontOfSize(14.0)
        prodDesc.font = font
        prodDesc.numberOfLines = 0;
        let text = prodDesc.text! as NSString
        let size = text.sizeWithAttributes([NSFontAttributeName:font])
        prodDesc.frame = CGRectMake(0, 0, 0, size.height)
        
        scrollView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, size.height + prodImageDetails.frame.height + prodPrice.frame.height + commandeButton.frame.height + 50)
        
        item.evendorPrice.insert(" ", atIndex: item.evendorPrice.startIndex.successor().successor())
        
        prodPrice.text = item.evendorPrice as String + " DA"
        
    
    
    }
    
    func setUpFieldsView() {
    
    
        
        // need x,y, width, heigth constaint
        prodImageDetails.centerXAnchor.constraintEqualToAnchor(containerView.centerXAnchor).active = true
        prodImageDetails.centerYAnchor.constraintEqualToAnchor(containerView.centerYAnchor).active = true
        prodImageDetails.topAnchor.constraintEqualToAnchor(containerView.topAnchor).active = true
        prodImageDetails.leftAnchor.constraintEqualToAnchor(containerView.leftAnchor,constant: 5).active = true
     //   prodImageDetails.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: 5).active = true
        prodImageDetails.widthAnchor.constraintEqualToAnchor(containerView.widthAnchor, constant: -10).active = true
        prodImageDetails.heightAnchor.constraintEqualToAnchor(containerView.heightAnchor, multiplier: 1/3).active = true
        
        // need x,y, width, heigth constaint
        
   //     let font = UIFont(name: "Helvetica", size: 16.0)
        
       // let height = heightForView(prodDesc.text!, font: font!, width:100.0)

        prodDesc.leftAnchor.constraintEqualToAnchor(containerView.leftAnchor, constant: 5).active = true
        prodDesc.topAnchor.constraintEqualToAnchor(prodImageDetails.bottomAnchor, constant: 10).active = true
       // prodDesc.heightAnchor.constraintEqualToConstant(50).active = true
        prodDesc.widthAnchor.constraintEqualToAnchor(containerView.widthAnchor, constant: -10).active = true
        
        
        // need x,y, width, heigth constaint

        prodPrice.rightAnchor.constraintEqualToAnchor(containerView.rightAnchor, constant: 10).active = true
        prodPrice.topAnchor.constraintEqualToAnchor(prodDesc.bottomAnchor, constant: 10).active = true
        prodPrice.heightAnchor.constraintEqualToConstant(30).active = true
        prodPrice.widthAnchor.constraintEqualToConstant(120).active = true
        
        // need x,y, width, heigth constaint

        
        commandeButton.centerXAnchor.constraintEqualToAnchor(containerView.centerXAnchor).active = true
        commandeButton.topAnchor.constraintEqualToAnchor(prodPrice.bottomAnchor, constant: 15).active = true
        commandeButton.widthAnchor.constraintEqualToAnchor(containerView.widthAnchor,constant: -50).active = true
        commandeButton.heightAnchor.constraintEqualToConstant(30).active = true
        
        
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
       let commandeController = CommandeController()
        commandeController.itemPost = item
        
        self.navigationController?.pushViewController(commandeController, animated: true)

        

    
    }
    
    let prodImageDetails:UIImageView = {
        
        let di = UIImageView()
        di.contentMode = .ScaleAspectFit
        di.translatesAutoresizingMaskIntoConstraints = false
        return di
    }()
    
    
    let prodDesc:UILabel = {
    
        let dl = UILabel()
        dl.translatesAutoresizingMaskIntoConstraints = false
        return dl
    
    }()
    
    
    let evendorName:UILabel = {
        
        let dl = UILabel()
        dl.translatesAutoresizingMaskIntoConstraints = false
        return dl
        
    }()
    
    
    let prodPrice:UILabel = {
        
        let dl = UILabel()
        dl.translatesAutoresizingMaskIntoConstraints = false
        dl.textColor = UIColor (r:170, g:31, b:38)
        return dl
        
    }()
    
    
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }


}


