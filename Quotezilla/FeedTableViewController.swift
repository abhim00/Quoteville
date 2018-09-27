//
//  FeedTableViewController.swift
//  Quotezilla
//
//  Created by Abhishek Mahesh on 7/18/15.
//  Copyright (c) 2015 AbsTech. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    var navBar = UINavigationBar()
    let font = UIFont(name: "HelveticaNeue-Thin", size: 14)
    let usrFont = UIFont(name: "HelveticaNeue-Bold", size: 15)
    var feedData = [PFObject]()
     var buttonpressedVar:Int = 0
    static let cellID = "cell"
    
    // NOTE! See how this tag is set below
    @IBAction func likeButton(sender: UIButton) {

        let quote = feedData[sender.tag]
        if let votes = quote.objectForKey("votes") as? Int {
            quote.setObject(votes + 1, forKey: "votes")
            // UPDATE the local UI
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: sender.tag, inSection: 0)],
                withRowAnimation: .None)
            // ** TO DO ** UPDATE Parse
            quote.saveInBackground()
            
        }
        
       
    }
    
    @IBAction func loadData(sender: AnyObject?) {
        feedData.removeAll()
        PFQuery(className: "userQuotes").findObjectsInBackgroundWithBlock {
            [unowned self]
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objs = objects {
                for object in objs {
                    self.feedData.append(object as! PFObject)
                }
                self.feedData = self.feedData.reverse()
            }
            NSOperationQueue.mainQueue().addOperationWithBlock { self.tableView.reloadData() }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.loadData(nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //PFUser.logOut()
        
        self.title = "Quoteville"
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FeedTableViewController.cellID, forIndexPath: indexPath) as! QuoteTableViewCell
        cell.likeButton!.tag = indexPath.row // See how tag works with the above
        cell.contentTextView!.font = font
        cell.timeStampLabel!.font = font
        cell.publisherLabel!.font = usrFont
        
        cell.contentTextView.alpha = 0.0
        cell.timeStampLabel.alpha = 0.0
        cell.publisherLabel.alpha = 0.0
        
        let q = feedData[indexPath.row]
        if let content = q.objectForKey("content") as? String {
            cell.contentTextView.text = content
        }
        else {
            cell.contentTextView.text = "Content not found!"
        }
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, h:mm a"
        cell.timeStampLabel.text = dateFormatter.stringFromDate(q.createdAt!)
        
        let votes = (q.objectForKey("votes") as? Int) ?? 0
        cell.likesLabel?.text = "\(votes)"
        
        
        let myObject = q.objectForKey("publisher") as? PFObject
        myObject?.fetchInBackgroundWithBlock {
            [unowned self]
            (object: PFObject?, error: NSError?) in
            NSOperationQueue.mainQueue().addOperationWithBlock {
                if let foundUser = object as? PFUser {
                    cell.publisherLabel.text = foundUser.username
                    UIView.animateWithDuration(0.7) {
                        cell.contentTextView.alpha = 1.0
                        cell.timeStampLabel.alpha = 1.0
                        cell.publisherLabel.alpha = 1.0
                    }
                }
                else {
                    cell.publisherLabel.text = "Publisher not found!"
                }
            }
        }
        return cell
    }

    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    /*override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            self.tableView.beginUpdates()
            
            self.feedData.removeObjectAtIndex(indexPath.row) // also remove an array object if exists.
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
            
            self.tableView.endUpdates()
        }else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
*/

}

