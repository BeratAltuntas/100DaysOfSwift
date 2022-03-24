import UIKit


    //***************************************************************
    //                    Extension of substring
var name = "Swift"
for n in name{
    print(n)
}

let letter = name[name.index(name.startIndex,offsetBy: 3)]

extension String{
    subscript(i:Int) -> String{
        return String(self[index(self.startIndex,offsetBy: i)])
    }
}

let letter2 = name[3]



    //***************************************************************
    //          Extension of suffix and prefix

let password = "123456"
password.hasPrefix("123")
password.hasSuffix("456")

extension String{
    func deletingPrefix(_ prefix: String) -> String{
        guard self.hasPrefix(prefix) else { return self}
        return String(self.dropFirst(prefix.count))
    }
    
    func deletingSuffix(_ suffix: String) -> String{
        guard self.hasSuffix(suffix) else {return self}
        return String(self.dropLast(suffix.count))
    }
}
print(password.deletingPrefix("123"))




    //***************************************************************
    //      Extension of capitalize a first letter of word

let weather = "it's going to rain"
print(weather.capitalized)

extension String{
    var capitalizedFirst:String{
        guard let firstLetter = self.first else {return ""}
        return firstLetter.uppercased() + self.dropFirst()
    }
}
print(weather.capitalizedFirst)




    //************************************************************
    //         Extension of searchin in array or string

let input = "Swift is like Objective-C without the C"
input.contains("Swift")


let languages = ["Python","Ruby","Swift","Java"]
languages.contains("Swift")


extension String{
    func containsOfAny(of array:[String])-> Bool{
        for item in array{
            if self.contains(item){
                return true
            }
        }
        return false
    }
}

input.containsOfAny(of: languages)


    //**********************************************************
    //                    NS Attiributed

let string = "This is a test string"

let attiributes:[NSAttributedString.Key : Any] = [
    .foregroundColor : UIColor.purple,
    .backgroundColor : UIColor.blue,
    .font : UIFont.boldSystemFont(ofSize: 42)
]

let attiributedString = NSAttributedString(string: string, attributes: attiributes)


    //***********************************************************
    //                 Mutable Attiributed

let mutableAttiributedString = NSMutableAttributedString(string: string)

mutableAttiributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 4))
mutableAttiributedString.addAttribute(.backgroundColor, value: UIColor.blue, range: NSRange(location: 0, length: 4))
mutableAttiributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))

mutableAttiributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 5, length: 2))
mutableAttiributedString.addAttribute(.backgroundColor, value: UIColor.white, range: NSRange(location: 5, length: 2))
mutableAttiributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))

mutableAttiributedString.addAttribute(.foregroundColor, value: UIColor.orange, range: NSRange(location: 8, length: 1))
mutableAttiributedString.addAttribute(.backgroundColor, value: UIColor.purple, range: NSRange(location: 8, length: 1))
mutableAttiributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))

mutableAttiributedString.addAttribute(.foregroundColor, value: UIColor.brown, range: NSRange(location: 10, length: 4))
mutableAttiributedString.addAttribute(.backgroundColor, value: UIColor.cyan, range: NSRange(location: 10, length: 4))
mutableAttiributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))

mutableAttiributedString.addAttribute(.foregroundColor, value: UIColor.yellow, range: NSRange(location: 15, length: 6))
mutableAttiributedString.addAttribute(.backgroundColor, value: UIColor.black, range: NSRange(location: 15, length: 6))
mutableAttiributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))



    //**********************************************************
    //                    Project 24 challenge

let example1 = "pet"
let example2 = "carpet"

extension String{
    func withPrefix(_ addingWord: String, addingToWhere:Int)-> String{
        if self.contains(addingWord){
            return self
        }
        else{
            if addingWord.count > addingToWhere{
                var string = ""
                for i in 0..<self.count{
                    if i == addingToWhere{
                        string += addingWord + self[i]
                    }
                    else{
                        string += self[i]
                    }
                }
                return string
            }else{
                return self
            }
        }
        
    }
}

example1.withPrefix("car", addingToWhere: 0)
example2.withPrefix("car", addingToWhere: 0)

