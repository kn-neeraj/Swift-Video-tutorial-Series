//
//  ContactDetailsViewController.swift
//  SwiftContacts
//
//  Created by Neeraj Kumar on 05/11/14.
//  Copyright (c) 2014 Neeraj Kumar. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UITableViewController {
    
    var person:Person? // person whose details need to be shown.

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: TableViewDataSource
extension ContactDetailsViewController:UITableViewDataSource {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.data.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactDetailsCellIdentifier", forIndexPath: indexPath) as UITableViewCell
        // Configure the cell...
        if let uwPerson = self.person {
            switch(indexPath.section) {
            case 0:
                cell.textLabel.text = uwPerson.name.finalName
            case 1:
                cell.textLabel.text = uwPerson.address.description
            case 2:
                cell.textLabel.text = uwPerson.phoneNumber.description
            default:
                cell.textLabel.text = ""
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.data[section]
    }
    
}

// MARK: Sample Data.
private extension ContactDetailsViewController {
    var data: [String] {
        return [
            "Name",
            "Address",
            "Phone Number",
            ]
    }
}

