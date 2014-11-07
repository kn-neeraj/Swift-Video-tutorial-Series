// Playground - noun: a place where people can play

import UIKit
import Foundation

// Properties.
// Stored properties - Stores a value as part of the instance.They could be variable or constant stored properties.

struct Name {
    var firstName: String
    var middleName: String
    let lastName: String
}


// Lazy stored properties - A lazy stored properties whose initial value is not calculated until used first time.
// Quote example from Apple documentation
class DataImporter {
    // Its supposed to take lot of time to initialize it.
    init() {
        println("DataImporter is initialized")
    }
}

class DataManager {
    lazy var dataManager = DataImporter()
    var data = [String]()
}

var dm:DataManager = DataManager()
dm.data.append("Hello")
println("Data manager not initialized till now")
dm.dataManager // initialized now.

// Comes in handy when initialization is heavy for an instance and you want to delay it.

// Computed properties - 

struct Name1 {
    var firstName: String
    var middleName: String
    var lastName: String
    var finalName1:String {  // readonly computed properties.
        return ("\(firstName) \(middleName) \(lastName)")
    }
    var finalName:String { // computed properties.
        get {
          return ("\(firstName) \(middleName) \(lastName)")
        }
        set {
            var arr:[String] = newValue.componentsSeparatedByString(" ") // you can set all components of a name using final name.
            firstName = arr[0]
            middleName = arr[1]
            lastName = arr[2]
        }
    }
   
}

var name:Name1 = Name1(firstName: "John", middleName: "Michael", lastName: "Doe")
println(name.finalName1)
name.finalName = "Tim Michael Cook"
println(name.finalName)

// Type properties - class properties, properties associated with a class type shared by all the instances.
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        // return an Int value here
        return 1
    }
}

class SomeClass {
    class var computedTypeProperty: Int {
        // return an Int value here
        return 1
    }
}


// Property observers - Every time a value is set.

struct Name2 {
    var firstName: String {
        willSet {
            println("WillSet the new property \(newValue)")
        }
        didSet {
            println("DidSet the new property \(firstName) and the old value was \(oldValue)")
        }
    }
    var middleName: String
    var lastName: String
    var finalName1:String {  // readonly computed properties.
        return ("\(firstName) \(middleName) \(lastName)")
    }
    var finalName:String { // computed properties.
        get {
            return ("\(firstName) \(middleName) \(lastName)")
        }
        set {
            var arr:[String] = newValue.componentsSeparatedByString(" ") // you can set all components of a name using final name.
            firstName = arr[0]
            middleName = arr[1]
            lastName = arr[2]
        }
    }
    
}

var name2:Name2 = Name2(firstName: "Rob", middleName: "Michael", lastName: "Doe")
name2.firstName = "Hello" // Setting a value.

// You can use propety observers in stored, computed properties.


//================ End of Slide properties =============================

// In objective C you would define extensions at the top of implementation files like this
/*
@interface XYZ() {
// define private properties,functions implementation of function needs to be in class implementation
}

*/


// Extensions - Add code to an existing class, structures or enumerations even if you don't have source code for it.

// Add computed properties.
struct Name4 {
    var firstName: String
    var lastName: String
    var middleName: String
}
// I have to add a finalName computed property to it. you cant add stored properties in extension.

var name4: Name4 = Name4(firstName: "John", lastName: "Miachael", middleName: "Doe")

extension Name4 {
    var finalName: String {
        return ("\(firstName) \(middleName) \(lastName)")
    }
}


// Instance and type methods.

extension Name4 {
    func printName() {
        println("My name is \(firstName) \(middleName) \(lastName)")
    }
}

name4.printName()



// New initialisers.

extension Name4 {
    init(finalName :String) {
        var arr:[String] = finalName.componentsSeparatedByString(" ") // you can set all components of a name using final name.
         self.init(firstName: arr[0], lastName: arr[2], middleName:arr[1])
        }
}

var name5: Name4 = Name4(finalName: "Hello world swift")
name5.printName()


// existing type confirm to protocol

extension Name4:Equatable {
}

// All operation overload functions are global.
func ==(lhs: Name4, rhs: Name4) -> Bool {
    if (lhs.firstName == rhs.firstName && lhs.middleName == rhs.middleName && lhs.lastName == rhs.lastName) {
        return true
    }
    return false
}

var name6: Name4 = Name4(finalName: "Hello my world")
var name7: Name4 = Name4(finalName: "Hello my world")

if (name5 == name6) {
    println (" name 5 and name6 are equal")
}
else {
    println("name 5 and name6 not equal")
}

if (name7 == name6) {
    println ("name 7 and name6 are equal")
}
else {
    println("name 7 and name6 are not equal")
}

// Define subscripts
extension Name4 {
    subscript(var index: Int)-> String {
        switch(index) {
        case 0:
            return self.firstName
        case 1:
            return self.middleName
        case 2:
            return self.lastName
        default:
            return "Invalid index" // You can chose accordingly what to return.
            }
    }
}

println(name7[0])
println(name7[1])
println(name7[2])
println(name7[3])

// See how functionality is distributed logically in different extensions. We have all had massive view controllers problem in our iOS projects but with distributing code logically on the among extensions will help a lot in those projects.

