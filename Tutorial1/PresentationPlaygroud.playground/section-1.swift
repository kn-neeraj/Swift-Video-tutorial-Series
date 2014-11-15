// Playground - noun: a place where people can play

import UIKit
import Foundation

// variable 
var variable1 : String = "Hello world"
println(variable1)
variable1 = "Hello world 2"
println(variable1)

// automatic type inference at compile time.
var variable2 = "Hello world 3"
println(variable2)

// compile time checking of types.
//variable2 = 123

// Other primitve types

var variable3: Int = 123
var variable4: Bool = true // or false
var variable5: Double = 12.23
println(variable4)
println(variable5)

// Constants

let variable6: String = "Constant"
//variable6 = "Hello"

//====================== END OF SLIDE 1===========================

// Operator overloading
var variable7 = variable1 + variable2 // addition of two strings
var variable8 = 1 + 2 // addition of two integers

// Our opertaor 

struct Name {
    var firstName: String
    var secondName: String
}


// operator overload with + for Name type.
func + (left: Name, right: Name) -> Name {
        return Name(firstName: (left.firstName + right.firstName), secondName: (left.secondName + right.secondName))
}

var name1 = Name(firstName: "John", secondName: "Doe")
var name2 = Name(firstName: "Jony", secondName: "Ive")
var name3 = name1 + name2 // + operator overloaded. We can use to provide operators CGRects, Colors or our own types.
println("First name : \(name3.firstName) and last name : \(name3.secondName)")

// Difference for class and struct for mutable vs immutable.
let name4 : Name = Name(firstName: "Hello", secondName: "World") // Immutable now.
//name4 = Name(firstName: "yo", secondName: "yo") //- Assign the variable to other structure.
// name4.firstName = "Hello1" //- Not allowed. - Trying to change value of a property of structure.

// Class 

class PersonName {
    var firstName: String
    var secondName: String
    init(firstName: String, secondName: String) {
        self.firstName = firstName
        self.secondName = secondName
        // IF this is not Root class then we need to call super.
        // super.init()
    }
}
let name5: PersonName = PersonName(firstName: "John", secondName: "Doe")
// name5 = PersonName(firstName: "Hello", secondName: "Wolrd") // We cannot assign anything to let.
name5.firstName = "Hello"
println(name5.firstName)

/* The idea to think of structs as value types and classes as reference types.
 * In structure if you assign a constant a structure object you cannot assign a new structure object to this constant and also you cant change its property values.
 * In Classes if you assign a constant a class object then that constant reference cant be assigned to any new class object but that objects property values could be changes.

- address- street ,house no etc, phone number (country code, actual number)-?
- Person - name,address,phonenumber should be of type class?
 */

// Automatic bridging b/w Swift and Objective C
var variable9 = "hello world".stringByAppendingString(" Yoyo") //Import foundation.

// Strings are value types like structures and Not reference type like classes.
var variable10 = "Hello world"
var variable11 = variable10 // Copied by value.DIFF from Objective C
 variable11 += " yoyo"
 variable10 += " hihi"
 println(variable11)
 println(variable10)
 
 
 // structs - are value types
let nameVar: Name = name1
name1.firstName = "Neeraj" // copied by value
println(nameVar.firstName)

// So if you pass around string or structure in method arguments it will be passed by value and if you change it inside the method original value will remain unchanged.

 // classes - are reference types.
let name6: PersonName = name5 // both references are pointing to same reference.
name5.firstName = "Mr.Neeraj"; // Find out why without space error?
println(name6.firstName)
 
 // Tuples
 // Easy and simple way constructing composite types.
 
 // Imagine that you want to return status from a method if its success then bool-true and errorType 0 and if error bool-false, correct error type.
 // Objective C- (id)abc:(id)performOperation - return type will be ID.
 
let returnType = (status: true, errorType: 0) // success scenario
let returnType1 = (status: false, errorType: 1) // failure scenario
let returnType2:(Bool, Int) = (true, 0)
println(returnType.status) // better for understanding.
println(returnType2.0)
//====================== END OF SLIDE========================

// Closed range operator -
for i in 2...5 { // Range
    print(i)
}
println()

for i in 2..<5 {
    print("\(i)")
}
println()

for i in "123" {
    print(i)
}
println()

// Both Range and Sting implements Sequence protocol which means they are enumerable

var greeting = "Hello world"
var j = 0
while j < 5 {    println("\(j) - \(greeting)")    j++
}
// Switch

var direction = "up"switch direction {
case "down":    println("Going Down!")
case "up":    println("Going Up!")
default: // Necessary otherwise throws error    println("Going Nowhere")
}

// we can club together different cases.
switch direction {
    case "up", "down":
        println("Going somewhere")
    default:
        println("Going nowhere")
}
    

var score = 10
switch score {        case 1..<10:
            println("novice")        case 10..<100:
            println("proficient")        case 100..<1000:
            println("rock-star")        default:
            println("awesome")        }

// Use tuples as well in switch.
switch returnType {
case (true, 0):
    println("Success")
default :
    println("Oops! Some error")
}
// There is much more you can do with Switch statements in swift.You can go read it in detail from Swift book.
        
        
// ================ End of slide =========================

// Optionals
//var str: String
//println(str) // throws error because we are trying to use str without initializing it.

//var str: String = nil // nil is not string.If you have given a string type then provide a string.
//println(str)


var str1: String? // Define a optional using ?.
println("Str1:\(str1)")
//str1 = "Hello people at the Swift introduction"
println(str1)
//var str0 = str1 + "thanks people"
//var str2 = str1! + "thanks people" // forced unwrap.you know there is a value.
//println("Str2 is : \(str2)")
// What if the server sends you something and you try to force unwrap it.

if let uwStr = str1 { // If str1 optional has a valid string value it will unwrap it and assign to uwStr and go inside this if condition.Here you don't need to force unwrapt str1 again you can just use uwStr as a normal variable.
    println(uwStr)
}
else {
    println("Oops nil!!!")
}

// Implicit unwrapping.

var str3: String! = "Hello" // optional

var str4 = str3 + "Thanks people" // if you still want to check put == nil condition.
println(str3)

// optional chaining.

// Consider - Father, Son(Optional can have a son or not), Middle name (Optional can have a middle name or not)
// father.son.middleName
// one way - 
// if let uwSon = father.son {
//     if let uwMiddleName = uwSon.middleName {
//            println(uwMiddleName)
//     }
// }
// var middleName: String = father.son?.middleName?
// if let uwMiddleName = middleName {
//    println(uwMiddleName)
// }
//  else {
//      println("middleName is nil")
//  }
//=================================== END OF SLIDE========================

// Array
var array = [1, 2, 3] // Int
println(array[0])
array.append(5) // Mutable
println(array)
array.extend(7...10) // Add a range.
println(array)
array.removeLast()
println(array)
//array.append("hello")//- compiler knows that this array can contain only Integer.

var array0 = [1, "yo", 4.3] // AnyObject
array0.append(false)
println(array0)
println(array0[3])



var array1: [String] = ["String1", "String3", "String5"] // Define the type of objects/primitive in your array.
var array2: [AnyObject] = ["String1", 1, 1.0]

// Dictionary
var dict = [1: "One", 2: "Two"]
var dict1: [Int:String] = [1: "One", 2:"Two"]
dict1[1] = nil
println(dict1)
println(dict1[2]) // Optional?? because you can try to get a value against key which doesnt exist.

if let uwValue = dict1[2] {
    println(uwValue) // unwrapped value.
}
    else {
    // I have wrong key computed.
}

if let uwValue = dict1[4] {
    println(uwValue)
}
else {
    println("Key doesnt exist")
}

// Array and Dict are value types and not reference types like Objective C
// NSarray *a = [1, 2, 3]
// NSArray *b = a

var arr1:[Int] = [1, 2, 3]
var arr2:[Int] = arr1 // Copy by value similar for dictinoary.
arr1.append(4)
println(arr1)
println(arr2)// Similary for dictionaries.

    
///// The end//////
















        





