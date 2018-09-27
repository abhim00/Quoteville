//
//  ComposeViewController.swift
//  Quotezilla
//
//  Created by Abhishek Mahesh on 7/18/15.
//  Copyright (c) 2015 AbsTech. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var quoteTextView: UITextView! = UITextView()
    
    @IBOutlet var charRemaining: UILabel! = UILabel()
    
    @IBOutlet weak var publishButton: UIButton! = UIButton()
    
    var amountOFQuotes:Int = 0
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if quoteTextView.textColor == UIColor.lightGrayColor() {
            quoteTextView.text = nil
            quoteTextView.textColor = UIColor.blackColor()

        }
    }
    
    func processSignOut() {
        
        // // Sign out
        PFUser.logOut()
        
    }
    
    
    
    
    func logSignIn(){
        
       /* if (PFUser.currentUser()==nil) {
            var storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            var vc: SignUpInViewController = storyboard.instantiateViewControllerWithIdentifier("signUp") as! SignUpInViewController
            
            self.presentViewController(vc, animated: true, completion: nil)
        }*/
        
        if (PFUser.currentUser()==nil) {
            processSignOut()
            var loginAlert:UIAlertController = UIAlertController(title: "Please Sign up or Log In", message: "Publish your Quote Today", preferredStyle: UIAlertControllerStyle.Alert)//maybe spice this up a lot more
        
                
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "email-address"
                
            })
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "username"
                
            })
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "password"
                textfield.secureTextEntry = true
                
                
            })
            
            
            loginAlert.addAction(UIAlertAction(title: "Sign In", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                
                let textFields:NSArray = loginAlert.textFields! as NSArray
                let usernameTextField:UITextField = textFields.objectAtIndex(1) as! UITextField
                let passwordTextField:UITextField = textFields.objectAtIndex(2) as! UITextField
                let emailTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
                
                PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text){
                    (user:PFUser?, error:NSError?)->Void in
                    
                    if ((user) != nil){
                        println("LoginSuccessful")
                        SweetAlert().showAlert("Great!", subTitle: "You're logged in!", style: AlertStyle.Success)
                    }else{
                        println("loginFail")
                       // self.animateFailure()
                        self.publishButton.enabled = false
                        SweetAlert().showAlert("Oops!", subTitle: "Check your username and password!", style: AlertStyle.Error)
                    }
                    
                    
                }
                
                
            }))
            
            loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                
                let textFields:NSArray = loginAlert.textFields! as NSArray
                let usernameTextField:UITextField = textFields.objectAtIndex(1) as! UITextField
                let passwordTextField:UITextField = textFields.objectAtIndex(2) as! UITextField
                let emailTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
                
                var publisher:PFUser = PFUser ()
                publisher.username = usernameTextField.text
                publisher.password = passwordTextField.text
                publisher.email = emailTextField.text
                
                publisher.signUpInBackgroundWithBlock{
                    (success:Bool, error:NSError?)-> Void in
                    
                    if error == nil{
                        println("Sign Up successfull")
                        SweetAlert().showAlert("Awesome!", subTitle: "Welcome to Quoteville!", style: AlertStyle.Success)
                        
                    }else{
                        let errorString = error!.localizedDescription
                        self.publishButton.enabled = false
                       SweetAlert().showAlert("Sorry!", subTitle: "\(errorString)", style: AlertStyle.Error)
                    }
                    
                    
                }
                
                
            }))
            
            self.presentViewController(loginAlert, animated: true, completion: nil)
            
            
        }
        
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    override func viewDidAppear(animated: Bool) {
                self.logSignIn()
            }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        quoteTextView.layer.borderWidth = 1.0
        quoteTextView.layer.cornerRadius = 5.0
        quoteTextView.text = "'You have 140 characters to type your quote Here and give credit to the Author'  ~Author"
        quoteTextView.textColor = UIColor.lightGrayColor()

        quoteTextView.delegate = self
        
        
        //Looks for single or multiple taps.
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }

    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func publishQuote(sender: AnyObject) {
        
        var userQuote:PFObject = PFObject(className: "userQuotes")
        userQuote["content"] = quoteTextView.text
        userQuote["publisher"] = PFUser.currentUser()
        userQuote["votes"] = 0
        userQuote["emailAddress"] = "none"
        
        userQuote.saveInBackground()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        amountOFQuotes = amountOFQuotes + 1
        
    }

    func textView(textView: UITextView,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool{
            
            var newLength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
            var remainChar:Int = 140-newLength
            
            charRemaining.text = "\(remainChar)"
            
            return (newLength>=140) ? false : true
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
