//
//  PostsController.swift
//  e-commerce CPA
//
//  Created by yacine yakoubi on 13/07/16.
//  Copyright © 2016 TheAppGuruz-New-6. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
 


class PostsController: UITableViewController {

    private let cellId = "CellId"
    private var itemPosts = [Post]()
    private var post = Post()
    let height = [Double]()
    let font = UIFont(name: "Helvetica", size: 12.0)



    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Produits"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout" , style: .Plain, target: self ,action: #selector(handleLogout))
        tableView.registerClass(PostCell.self, forCellReuseIdentifier: cellId)

        tableView.backgroundColor = UIColor(r:205, g: 205, b:205)
        
        jsonParsingFromURL()
 
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
        
            self.performSelector(#selector(handleLogout), withObject: nil ,afterDelay: 0)

        }

    
    }
    func handleLogout() {
        
        do {
            
            try FIRAuth.auth()?.signOut()
            FBSDKAccessToken.setCurrentAccessToken(nil)
            
        }catch let logoutError {
            
            print(logoutError)
        }
        
        
        
        let loginController = LoginController()
        
        presentViewController(loginController, animated:true, completion:nil)
        
    }

    
    
    
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

                return self.itemPosts.count
    }
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // VOila
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! PostCell

           let post = itemPosts[indexPath.row]
        
        if let url = NSURL(string: post.prodSmallPic as String) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
                
                if let imageData = data {

                    cell.productImageView.image = UIImage(data: imageData)
                }
            }
        }
        


            
            
        
        
        cell.prodNameLabel.text = post.prodName
        
        post.evendorPrice.insert(" ", atIndex: post.evendorPrice.startIndex.successor().successor())

        cell.priceLabel.text = post.evendorPrice + " DZD"

        
        return cell
    }
    

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 100.0
    }
    
    
    override func tableView(tableView: UITableView , didSelectRowAtIndexPath indexPath: NSIndexPath) {

        
        
        let detailsController = DetailsController()
        detailsController.item = itemPosts[indexPath.row]
        self.navigationController?.pushViewController(detailsController, animated: true)


    }
    
    

   
    
    
    func jsonParsingFromURL () {
        let url = NSURL(string: "http://oo-emarketplace.rhcloud.com/affiliate")
        let request = NSURLRequest(URL: url!)


        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            
            if data != nil {
                self.startParsing(data!)
            }else{
                let alertController = UIAlertController(title: "Connexion Failed", message:
                    "No Connexion !", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    
    
    func startParsing(data :NSData)
    {
        let dict: NSDictionary!=(try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        
        //Voila
        
        do {
            let json = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
            
            for i in 0  ..< dict.count  {
                
                if let data = json["\(i)"] {
                    let properties = data as? Dictionary<String,AnyObject>
                    
                    if properties != nil {
                        
                        
                        var prodName1 = " "
                        var prodModel1 =  " "
                        var prodBigPic1 = " "
                        var prodSmallPic1 = " "
                        var evendorId1 = " "
                        var eVendorName1 = " "
                        var eVendorLogo1 = " "
                        var eVendorAdress1 = " "
                        var eVendorWilaya1 = " "
                        var eVendorCommune1 = " "
                        var eVendorTel1 = " "
                        var eVendorMail1 = " "
                        var eVendorPrice1 = " "
                        var eVendorStock1 = " "
                        var prodDesc1 = " "
                        var prodId1 = " "
                        var prodPromo1 = " "
                        var promoPrice1 = " "
                        var marqueId1 = " "
                        var marqueIdaff1 = " "
                        var evendor_aff1 = " "
                        var id_evendor_prod1 = " "
                        
                        if ((properties!["nom_produit"]) is NSNull) {
                        }else{
                            prodName1 = properties!["nom_produit"] as! String
                        }
                        
                       
                        if ((properties!["marque_produit"]) is NSNull){
                            
                        }else{
                            prodModel1 = properties!["marque_produit"] as! String

                        }
                        if ((properties!["grande_photo"]) is NSNull) {

                        }else{
                            prodBigPic1 = properties!["grande_photo"] as! String

                        }
                        
                       if ((properties!["petite_photo"]) is NSNull) {

                        }else{
                        prodSmallPic1 = properties!["petite_photo"] as! String

                        }
                        if ((properties!["nom_evendor"]) is NSNull) {

                        }else{
                            eVendorName1 = properties!["nom_evendor"] as! String

                        }
                        if ((properties!["logo_evendor"]) is NSNull) {

                        }else{
                            eVendorLogo1 = properties!["logo_evendor"] as! String

                        }
                        if ((properties!["adresse_evendor"]) is NSNull) {

                        }else{
                            eVendorAdress1 = properties!["adresse_evendor"] as! String

                        }
                        if ((properties!["wilaya_evendor"]) is NSNull) {

                        }else{
                            eVendorWilaya1 = properties!["wilaya_evendor"] as! String

                        }
                        
                        if ((properties!["commune_evendor"]) is NSNull) {

                        }else{
                            eVendorCommune1 = properties!["commune_evendor"] as! String
                        }
                        
                        if ((properties!["email_evendor"]) is NSNull) {

                        }else{
                            eVendorMail1 = properties!["email_evendor"] as! String

                        }
                        
                        if ((properties!["tel_evendor"]) is NSNull) {

                        }else{
                            eVendorTel1 = properties!["tel_evendor"] as! String

                        }
                        
                        if ((properties!["prix_evendor_produit"]) is NSNull) {

                        }else{
                            eVendorPrice1 = properties!["prix_evendor_produit"] as! String

                        }
                        
                        if (properties!["id_produit_affiliate"] is NSNull) {

                        }else{
                            eVendorStock1 = properties!["id_produit_affiliate"] as! String

                        }
                        
                        if (properties!["description_produit"] is NSNull) {

                        }else{
                            prodDesc1 = properties!["description_produit"] as! String

                        }
                        
                        if ((properties!["prix_promo"]) is NSNull) {

                        }else{
                            promoPrice1 = properties!["prix_promo"] as! String

                        }
                        
                        if ((properties!["promo"]) is NSNull) {

                        }else{
                            //prodPromo1 = properties!["promo"] as! String

                        }
                        
                        if ((properties!["id_produit"]) is NSNull) {

                        }else{
                            prodId1 = properties!["id_produit"] as! String

                        }
                        
                        if ((properties!["id_evendor"]) is NSNull) {
                        }else{
                            evendorId1 = properties!["id_evendor"] as! String

                        }
                        
                        if ((properties!["id_marque"]) is NSNull) {

                        }else{
                        
                            marqueId1 = properties!["id_marque"] as! String

                        }
                        
                        if ((properties!["id_evendor_affiliate"]) is NSNull) {
                            
                        }else{
                            
                            evendor_aff1 = properties!["id_evendor_affiliate"] as! String
                            
                        }
                        
                        if ((properties!["id_evendor_produit"]) is NSNull) {
                            
                        }else{
                            
                            id_evendor_prod1 = properties!["id_evendor_produit"] as! String
                            
                        }
                        
                        let p: Post
                        
                        
                            p = Post(prodName: prodName1 as String,prodModel: prodModel1 as String, prodBigPic:  prodBigPic1 as String,prodSmallPic: prodSmallPic1 as String,evendorId: evendorId1 as String,evendorName: eVendorName1 as String, evendorLogo: eVendorLogo1 as String,evendorAdress: eVendorAdress1  as String,evendorWilaya: eVendorWilaya1 as String,evendorCommune: eVendorCommune1 as String, evendorTel: eVendorTel1 as String, evendorMail:eVendorMail1 as String, evendorPrice:eVendorPrice1 as String,prodDesc:prodDesc1 as String,evendorStock: eVendorStock1 as String,prodId: prodId1 as String,prodPromo: prodPromo1 as String,promoPrice: promoPrice1 as String,marqueId: marqueId1 as String,marqueIdaff: marqueIdaff1 as String,evendor_aff: evendor_aff1 as String,id_evendor_prod: id_evendor_prod1 as String)!
                        
                        
                        
                        itemPosts.append(p)
                        
                        
                    }
                    
                    
                }
            }
            
            
        }
        
        
       tableView.reloadData();
        
    }
    
    

    
}


class PostCell: UITableViewCell {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
    override init(style: UITableViewCellStyle ,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let productImageView: UIImageView = {
        
        let im = UIImageView()
        im.contentMode = .ScaleToFill
        im.translatesAutoresizingMaskIntoConstraints = false

        return im
    }()
    
    
    let divederLineView: UIView = {
        let ve = UIView()
        ve.backgroundColor = UIColor(white: 0.5 , alpha: 0.5)
        ve.translatesAutoresizingMaskIntoConstraints = false
        return ve
    }()
    
    
    let prodNameLabel: UILabel = {
        
        let tf = UILabel()
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
        
    }()

    let priceLabel: UILabel = {
        
        let tf = UILabel()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = UIColor (r:170, g:31, b:38)
        
        return tf
        
    }()

    
     func setupViews() {
        

        
        backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(productImageView)
        self.contentView.addSubview(prodNameLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(divederLineView)

        
      //  let str:String =
    
       addConstraintsWithFormat("H:|-12-[v0(100)]", views: productImageView)
       addConstraintsWithFormat("V:|[v0]|", views: productImageView)
       addConstraintsWithFormat("H:|-114-[v0]|", views: divederLineView)
       addConstraintsWithFormat("V:[v0(0.5)]|", views: divederLineView)
       addConstraintsWithFormat("H:|-115-[v0]-5-|", views: prodNameLabel)
       addConstraintsWithFormat("V:|-10-[v0(30)]", views: prodNameLabel)
       addConstraintsWithFormat("H:[v0]-10-|", views: priceLabel)
       addConstraintsWithFormat("V:|-45-[v0(30)]", views: priceLabel)

        
        
        
    }
    
    
    
   
    
}




