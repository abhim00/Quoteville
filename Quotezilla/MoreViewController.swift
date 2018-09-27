//
//  MoreViewController.swift
//  Quotezilla
//
//  Created by Abhishek Mahesh on 7/29/15.
//  Copyright (c) 2015 AbsTech. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
var emailData = [PFObject]()
var alert = SweetAlert()
var signupAlert = UIAlertController?()
var user = PFUser.currentUser()?.objectId

    
        

    @IBAction func emailSignUp(sender: AnyObject) {
        
         signupAlert = UIAlertController(title: "Email", message: "Sign up for more info 😉", preferredStyle: UIAlertControllerStyle.Alert)//maybe spice this up a lot more
        
        
        signupAlert!.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "please enter a valid email"
            
        })
        
        
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
        }
        
        let signUp = UIAlertAction(title: "Sign Up", style: .Default, handler: {
            (action) -> Void in
            
            if let textFields = self.signupAlert?.textFields {
                let theTextFields = textFields as! [UITextField]
                let email = theTextFields[0].text
                
            }
            
            
            
        })
        signupAlert!.addAction(signUp)
        signupAlert!.addAction(cancelAction)
        
        self.presentViewController(signupAlert!, animated: true, completion: nil)

        
    }
    @IBAction func logOut(sender: AnyObject) {
        
        SweetAlert().showAlert("Are you sure?", subTitle: "You will be logged out!", style: AlertStyle.Warning, buttonTitle:"Nevermind!", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Yeah!", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                SweetAlert().showAlert("Cancelled!", subTitle: "You're still Logged In!", style: AlertStyle.Error)
            }
            else {
                SweetAlert().showAlert("All Done!", subTitle: "You have been successfully logged out!", style: AlertStyle.Success)
                PFUser.logOut()
            }
        }
       // PFUser.logOut()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            println(user);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
