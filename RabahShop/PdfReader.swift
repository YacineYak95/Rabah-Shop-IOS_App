//
//  PdfReader.swift
//  e-commerce CPA
//
//  Created by yacine yakoubi on 19/07/16.
//  Copyright © 2016 TheAppGuruz-New-6. All rights reserved.
//

import UIKit

class PdfReader: UIViewController {
    
    
    var commande:Commande = Commande()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r:205, g: 205, b:205)

        
        
        // the URL to save let yourURL: NSURL = NSURL(string: self.commande.link)!
        //let yourURL: NSURL = NSURL(string: self.commande.link)!
        let yourURL: NSURL = NSURL(string: "http://oo-emarketplace.rhcloud.com/Commande-Test%20-Test%20-21-07-16-07-07-13.pdf")!

        // turn it into a request and use NSData to load its content
        let request: NSURLRequest = NSURLRequest(URL: yourURL)
        let data: NSData = try! NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
        // find Documents directory and append your local filename
        var documentsURL: NSURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
        documentsURL = documentsURL.URLByAppendingPathComponent("localFile.pdf")
        // and finally save the file
        data.writeToURL(documentsURL, atomically: true)

        
        
            let webView = UIWebView(frame: CGRectMake(20,20,self.view.frame.size.width-40,self.view.frame.size.height-40))
            webView.loadData(data, MIMEType: "application/pdf", textEncodingName:"", baseURL: documentsURL)
            self.view.addSubview(webView)
        
        

    }
    
    
    let pdfContent:UIWebView = {
    
        let pdf = UIWebView()
        pdf.translatesAutoresizingMaskIntoConstraints = false
        pdf.contentMode = .ScaleToFill

        return pdf
    }()
    

}
