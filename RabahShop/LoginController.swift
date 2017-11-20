//
//  LoginController.swift
//  e-commerce CPA
//
//  Created by yacine yakoubi on 12/07/16.
//  Copyright © 2016 TheAppGuruz-New-6. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
class LoginController: UIViewController{
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // No user is signed in.
        
        //self.loginButton.readPermissions = ["public_profile","email","user_friends"]
        
        self.hideKeyboardWhenTappedAround()
        

        view.backgroundColor = UIColor(r:205, g: 205, b:205)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(logoImageView)
        view.addSubview(loginFBButton)
        view.addSubview(loginPRButton)



        loginFBButton.hidden = true
        loginPRButton.hidden = true


        setupInputsContainerView()
        setupLoginRegisterButton()
        setupLoginRegisterSegmentedControl()
        setUpLogoImageView()
        
    }
    
    
    func handleLoginFb(){
    
        
        
        let facebookLogin = FBSDKLoginManager()
        
        print("LoggedIn")
        
        facebookLogin.logInWithReadPermissions(["public_profile","email","user_friends"], fromViewController: self, handler: {(facebookResults,facebookError) -> Void in
        
            if facebookError != nil {
            
                print("facebook error login")
                return
            }else if facebookResults.isCancelled{
                
                print("facebook login is canceled")
            
            }else {
            
            print("you are i in")

                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                FIRAuth.auth()?.signInWithCredential(credential){ (user, error) in
                    
                    print("user loged in firebase")
                }
                
                self.dismissViewControllerAnimated(true, completion: nil)
                    
                }

            
        
        
        } );
    
    
    }
    
    
    
    func anonymousLogin(){
    
        FIRAuth.auth()?.signInAnonymouslyWithCompletion() { (user, error) in
            
            if (error != nil){
                print(error)
                return
            
            }

            print("user Loged anonymously with " + user!.uid )
            self.dismissViewControllerAnimated(true, completion: nil)

            
        }
    
    
    
    }
    
    
    lazy var loginPRButton:UIButton = {
        
        let button = UIButton(type: .System)
        //button.backgroundColor = UIColor.blackColor()
        button.setTitle("continuer sans s'inscrire", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor (r:170, g:31, b:38), forState: .Normal)
        //button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        //button.layer.cornerRadius = 25
        //button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(anonymousLogin) , forControlEvents: .TouchUpInside)
        return button
        
    }()
    
    
    
   
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton){
    
    print("User logged Out")
    }
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
        
    }()
 

    let logoImageView: UIImageView = {
        
        let im = UIImageView()
        //im.contentMode = .ScaleToFill
        im.image = UIImage(named: "Logo" )
        im.translatesAutoresizingMaskIntoConstraints = false
        
        return im
    }()
    
    
    
    
   lazy var loginRegisterButton:UIButton = {
    
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor (r:170, g:31, b:38)
        button.setTitle("Register", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
    
        button.addTarget(self, action: #selector(handleLoginInRegister) , forControlEvents: .TouchUpInside)
        return button
        
    }()
    
    
    
    
    lazy var loginFBButton:UIButton = {
        
        let button = UIButton(type: .System)
        let image = UIImage(named: "facebook")! as UIImage
        //button.setImage(image, forState: .Normal)
        button.setBackgroundImage(image, forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
 
        
        button.addTarget(self, action: #selector(handleLoginFb) , forControlEvents: .TouchUpInside)
        return button
        
    }()
    
    

    
    func handleLoginInRegister (){
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
        handleLogin()
            
        }else{
        handleRegister()
        }
    
    }
    
    func handleLogin(){
    
        guard let email = emailTextField.text, password = passwordTextField.text
            else {
                print("Form is not valid")
                return
        }
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: {(user, error ) in
        
            if (error != nil){
                print(error)
                return
            }
            
    
            self.dismissViewControllerAnimated(true, completion: nil)
            
            
        })
        
    }
    
    
    
    func handleRegister(){
        
        guard let email = emailTextField.text, name = nameTextField.text , password = passwordTextField.text
            else {
        print("Form is not valid")
        return
        }
        
        FIRAuth.auth()?.createUserWithEmail(email, password:password, completion:{(user: FIRUser?, error) in
            
            if(error != nil){
                print(error)
                return
            
            }
            
            //User successfuly authentified
            print("User successfuly authentified ")
            
            guard let uid = user?.uid else {
                return
            }
            
            let ref = FIRDatabase.database().referenceFromURL("https://e-commerce-cpa-57e7d.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            
            let values = ["name": name , "email": email ]
            
            usersReference.updateChildValues(values,withCompletionBlock: {(err, ref) in
                
                if (err != nil){
                    print("error occured")

                print(err)
                return
                }
            print("User succesfuly registred")
            
                
            })
            
        
        
        
        })
        self.dismissViewControllerAnimated(true, completion: nil)


    }
    
    let nameTextField: UITextField = {
    
    let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    
    }()
    
    let textFieldSeparationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r:220, g:220, b:220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let emailTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
        
    }()
    
    let emailSeparationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r:220, g:220, b:220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let passwordTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.secureTextEntry = true
        return tf
        
    }()
    
   lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        
        let sc = UISegmentedControl(items : ["Login","Register"])
    sc.layer.cornerRadius = 5

        sc.translatesAutoresizingMaskIntoConstraints = false
        //sc.tintColor = UIColor (r:170, g:31, b:38)
        sc.tintColor = UIColor.whiteColor()
        sc.backgroundColor = UIColor (r:170, g:31, b:38)

        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterControl), forControlEvents: .ValueChanged)
        return sc
        
    }()
    
    func handleLoginRegisterControl(){
    
    print(loginRegisterSegmentedControl.selectedSegmentIndex)
    

        if (loginRegisterSegmentedControl.selectedSegmentIndex == 1){
        
            loginFBButton.hidden = true
            loginPRButton.hidden = true


        }else{
            loginFBButton.hidden = false
            loginPRButton.hidden = false

        
        }
        
        let title = loginRegisterSegmentedControl.titleForSegmentAtIndex(loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, forState: .Normal)
        
        //Change the height when wt tap login 
        
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 120
        
        nameTextFieldViewHeightAnchor?.active = false
        nameTextFieldViewHeightAnchor = nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3 )
        nameTextFieldViewHeightAnchor?.active = true

        
        
        emailTextFieldViewHeightAnchor?.active = false
        emailTextFieldViewHeightAnchor = emailTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3 )
        emailTextFieldViewHeightAnchor?.active = true
        
        
        
        passwordTextFieldViewHeightAnchor?.active = false
        passwordTextFieldViewHeightAnchor = passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier:loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3 )
        passwordTextFieldViewHeightAnchor?.active = true
        
    }
    

    


    
    
    func setupLoginRegisterSegmentedControl(){
    
        loginRegisterSegmentedControl.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterSegmentedControl.topAnchor.constraintEqualToAnchor(logoImageView.bottomAnchor).active = true
        loginRegisterSegmentedControl.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, multiplier: 0.5).active = true
        loginRegisterSegmentedControl.heightAnchor.constraintEqualToConstant(30).active = true
    }
    
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldViewHeightAnchor: NSLayoutConstraint?
    var emailTextFieldViewHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldViewHeightAnchor: NSLayoutConstraint?
    
    func setupInputsContainerView () {
        
        // need x,y, width, heigth constaint
  
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -24).active = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraintEqualToConstant(120)
        inputsContainerViewHeightAnchor?.active = true
        
        
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(textFieldSeparationView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparationView)
        inputsContainerView.addSubview(passwordTextField)
        
        // need x,y, width, heigth constaint

        
        nameTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        nameTextField.topAnchor.constraintEqualToAnchor(inputsContainerView.topAnchor).active = true
        nameTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        //nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 0.33)
        nameTextFieldViewHeightAnchor = nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldViewHeightAnchor?.active = true
        // need x,y, width, heigth constaint
        
        textFieldSeparationView.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        textFieldSeparationView.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true
        textFieldSeparationView.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        textFieldSeparationView.heightAnchor.constraintEqualToConstant(1).active = true
        
        
        // need x,y, width, heigth constaint
        
        emailTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        emailTextField.topAnchor.constraintEqualToAnchor(textFieldSeparationView.bottomAnchor).active = true
        emailTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        //emailTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 0.33)
        emailTextFieldViewHeightAnchor = emailTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldViewHeightAnchor?.active = true

        // need x,y, width, heigth constaint
        
        emailSeparationView.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        emailSeparationView.topAnchor.constraintEqualToAnchor(emailTextField.bottomAnchor).active = true
        emailSeparationView.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        emailSeparationView.heightAnchor.constraintEqualToConstant(1).active = true
        
        // need x,y, width, heigth constaint
        
        passwordTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        passwordTextField.topAnchor.constraintEqualToAnchor(emailSeparationView.bottomAnchor).active = true
        passwordTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
    //    passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 0.33)
        passwordTextFieldViewHeightAnchor = passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldViewHeightAnchor?.active = true
        
        

    }
    
    func setupLoginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterButton.topAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: 12).active = true
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        loginRegisterButton.heightAnchor.constraintEqualToConstant(50).active = true

   // loginFBButton
        
        
        loginFBButton.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 10).active = true
        loginFBButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -20).active = true
        loginFBButton.widthAnchor.constraintEqualToConstant(90).active = true
        loginFBButton.heightAnchor.constraintEqualToConstant(30).active = true
        
        
        
        loginPRButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginPRButton.topAnchor.constraintEqualToAnchor(loginRegisterButton.bottomAnchor, constant: 10).active = true
        loginPRButton.widthAnchor.constraintEqualToConstant(200).active = true
        loginPRButton.heightAnchor.constraintEqualToConstant(50).active = true
    }
    

 
    
    
    func setUpLogoImageView(){
      
        logoImageView.centerXAnchor.constraintEqualToAnchor( view.centerXAnchor).active = true
        logoImageView.topAnchor.constraintEqualToAnchor(view.topAnchor , constant: 5 ).active = true
        logoImageView.heightAnchor.constraintEqualToConstant(140).active = true
        logoImageView.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        logoImageView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
    
    
    }


}


public extension UIView {
    
    func addConstraintsWithFormat(format:String , views:UIView...){
        
        var viewsDictionary = [String : UIView]()
        for (index , view) in views.enumerate(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
            
        }
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil , views : viewsDictionary ))
        
    }
    
    
}


extension UIColor {
    
    convenience init(r: CGFloat , g: CGFloat ,b: CGFloat ) {
        
        self.init(red: r/255 , green: g/255 ,blue: b/255, alpha: 1 )
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

