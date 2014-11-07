//
//  ViewController.swift
//  SwiftContacts
//
//  Created by Neeraj Kumar on 05/11/14.
//  Copyright (c) 2014 Neeraj Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var contactsTableView: UITableView!
    
   private var contactsArray:[Person] = Array() // stored property
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("newPersonAvailable:"), name: NEW_PERSON_NOTIFICATION, object: nil) // Your selector should not be private other app will crash.
    }
    
    func newPersonAvailable(notification:NSNotification) {
        if let userInfo = notification.userInfo {
            let person:Person? = userInfo["object"] as? Person
            if let uwPerson = person {
                self.contactsArray.append(uwPerson)
            }
        }
        self.contactsTableView.reloadData()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

// MARK: TableViewDataSource and Delegate
extension ViewController:UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.contactsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactTableCellReuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        let person: Person = self.contactsArray[indexPath.row]
        cell.textLabel.text = person.name.finalName

        return cell
    }
    
}

// MARK: - Navigation
extension ViewController {
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "ContactDetailSegueIdentifier" {
            let vc:ContactDetailsViewController = segue.destinationViewController as ContactDetailsViewController
            let indexPath:NSIndexPath? = self.contactsTableView.indexPathForSelectedRow()
            if let uwIndexPath = indexPath {
                vc.person = self.contactsArray[uwIndexPath.row]
            }
        }
        
    }
}

