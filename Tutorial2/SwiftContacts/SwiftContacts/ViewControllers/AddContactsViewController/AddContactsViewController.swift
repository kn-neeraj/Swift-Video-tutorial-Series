//
//  AddContactsViewController.swift
//  SwiftContacts
//
//  Created by Neeraj Kumar on 05/11/14.
//  Copyright (c) 2014 Neeraj Kumar. All rights reserved.
//

import UIKit


// MARK: Protocol.

// Important: With inheriting from class this protocol can only be adopteb by classes and not structures and enumerations
protocol AddContactCellDelegate:class {
    func didResignNextResponder(cell:AddContactTableViewCell)
    func textFieldDidEndEditing(cell:AddContactTableViewCell)
}

// MARK: AddContactTableViewCell

class AddContactTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate:AddContactCellDelegate?
    
    override func awakeFromNib() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.textField.returnKeyType = UIReturnKeyType.Next
        self.textField.delegate = self
        super.awakeFromNib()
    }
   
    func populateCellWithData(dict:[String:String]) {
       self.label.text = dict["label"]
    }
    
    func textFieldBecomeFirstResponder() {
        self.textField.becomeFirstResponder()
    }
    
    func textFieldText() -> String {
        return self.textField.text
    }
}

extension AddContactTableViewCell:UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
       textField.resignFirstResponder()
        delegate?.didResignNextResponder(self) // optional chaining
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        delegate?.textFieldDidEndEditing(self)
    }
}


// MARK: AddContacts view controller.
class AddContactsViewController: UITableViewController {
    
    var name:Name = Name()
    var address:Address = Address()
    var phoneNumber:PhoneNumber = PhoneNumber()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Contact"
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        self.tableView.reloadData()
        let barButton:UIBarButtonItem = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("didTapSubmitButton"))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func didTapSubmitButton() {
        
        self.view.endEditing(true)
        let person:Person = Person(name: self.name, address: self.address, phoneNumber: self.phoneNumber) // person object.
        // Check if person is valid.
        if person.isValid() {
            // Notify that a person object is added.
            let userInfo:[NSObject : AnyObject] = ["object": person]
            NSNotificationCenter.defaultCenter().postNotificationName(NEW_PERSON_NOTIFICATION, object: nil, userInfo: userInfo)
            self.navigationController?.popViewControllerAnimated(true)
        }
        else {
            let alertView:UIAlertView = UIAlertView(title: "Invalid entries!!", message: "Please fill all required component", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        }
    }
    
    deinit {
        println("AddContacts view controller deinits")
    }
}

// MARK: Sample Data.
private extension AddContactsViewController {
    var data: [String:[String]] {
        return [
            "Name":[
                "First Name *",
                "Middle Name",
                "Last Name *"
            ],
            "Address":[
                "flatNo *",
                "locality *",
                "city *",
                "pincode *",
                "landmark"
            ],
            "Phone Number":[
                "diallingCode *",
                "phoneNo *"
            ],
            
            ]
    }
    
    // Extracting the values form indexPath to properties.
    func saveValueForIndexpath(indexPath:(section:Int,row:Int), cell:AddContactTableViewCell) {
        switch (indexPath) {
        case (0,0):
            self.name.firstName = cell.textFieldText()
        case (0,1):
            self.name.middleName = cell.textFieldText()
        case (0,2):
            self.name.lastName = cell.textFieldText()
        case (1,0):
            self.address.flatNo = cell.textFieldText()
        case (1,1):
            self.address.locality = cell.textFieldText()
        case (1,2):
            self.address.city = cell.textFieldText()
        case (1,3):
            self.address.pindcode = cell.textFieldText()
        case (1,4):
            self.address.landmark = cell.textFieldText()
        case (2,0):
            self.phoneNumber.diallingCode = cell.textFieldText()
        case (2,1):
            self.phoneNumber.phoneNumber = cell.textFieldText()
        default:
            assertionFailure("wrong indexPath please check.")
        }
    }
    
}


// MARK: TableViewDataSource
extension AddContactsViewController:UITableViewDataSource {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.data.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sectionName: String = "Name"
        switch(section) {
        case 0:
            sectionName = "Name"
        case 1:
            sectionName = "Address"
        case 2:
            sectionName = "Phone Number"
        default:
            sectionName = "Name"
        }
        if let sectionArr = self.data[sectionName] {
            return sectionArr.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AddContactCellReuseIdentifier", forIndexPath: indexPath) as AddContactTableViewCell
        cell.delegate = self
        var sectionName: String = "Name"
        switch(indexPath.section) {
        case 0:
            sectionName = "Name"
        case 1:
            sectionName = "Address"
        case 2:
            sectionName = "Phone Number"
        default:
            sectionName = "Name"
        }
        
        if let sectionArr = self.data[sectionName] {
            let str:String = sectionArr[indexPath.row]
            cell.populateCellWithData(["label":str])
        }
        
        return cell
    }
    
}

// MARK: TableViewDelegate
extension AddContactsViewController:UITableViewDelegate {
    
     override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName: String = "Name"
        switch(section) {
        case 0:
            sectionName = "Name"
        case 1:
            sectionName = "Address"
        case 2:
            sectionName = "Phone Number"
        default:
            sectionName = "Name"
        }
        return sectionName
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

// MARK: Protocol AddContactCellDelegate
extension AddContactsViewController:AddContactCellDelegate {
    func didResignNextResponder(cell:AddContactTableViewCell) {
        let indexPath:NSIndexPath? = self.tableView.indexPathForCell(cell)
         if let uwIndexPath = indexPath {
            self.saveValueForIndexpath((uwIndexPath.section, uwIndexPath.row), cell: cell)
           let newIndexPath:NSIndexPath = self.nextIndexPath(uwIndexPath)
            let cell:AddContactTableViewCell? = self.tableView.cellForRowAtIndexPath(newIndexPath) as? AddContactTableViewCell
            cell?.textFieldBecomeFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(cell:AddContactTableViewCell) {
        let indexPath:NSIndexPath? = self.tableView.indexPathForCell(cell)
        if let uwIndexPath = indexPath {
            self.saveValueForIndexpath((uwIndexPath.section, uwIndexPath.row), cell: cell)
        }
    }
    
    func nextIndexPath(currentIndexPath:NSIndexPath) -> NSIndexPath {
        let numRows = self.tableView.numberOfRowsInSection(currentIndexPath.section)
        if currentIndexPath.row == (numRows-1) {
            return NSIndexPath(forRow: 0, inSection: (currentIndexPath.section+1))
        }
        else {
            return NSIndexPath(forRow:(currentIndexPath.row + 1), inSection:currentIndexPath.section)
        }
    }
}

