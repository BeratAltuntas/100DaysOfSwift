import UIKit
import Darwin

//String variables
var str = "Hello World"
str = "Good Bye World"

//Integer variables
var age = 20
var population = 8_000_000//göze okunabilir olması için alt çizgi var

//Multi-Line String variables
var str1 = """
    bu
    çok
    satırlı
    string
    """
//multi-line but its single line string variables
var str2 = """
    bu\
    çok\
    satırlı\
    string 2
    """

//Double variables
var pi=3.141

//Boolean variables
var awsome=true

// Stirng interpolation
var score=100
var str3="Your score was\(score)"

// Constants
let pi_nu=3.14

//Type Annotations tür açıklamaları
var str4="Tür açıklamaları iki nokta üst üste den sonra yazılır."
let name:String="Taylor Swift"
let year:Int=1989
let height:Double=1.78
let taylorRocks:Bool=true

// Arrays
let berat = "berat altuntas"
let bersis = "bersis yalcin"
let erhan = "erhan toktamis"
let kazim = "kazim karaca"

let isimler = [berat,bersis,erhan,kazim]

isimler[2]

//Boş Array oluşturma
var array1=[String]()//yol1
var array2=Array<String>()//yol2


// Sets
let colors=Set(["red","blue","orange","green","1","4","1"])
let colors2=Set(["green","red","blue","orange"])

var set2=Set<String>() //Boş Set oluşturma


//Tuples
var costumer1=(name:"Berat" ,surname:"Altuntas",age:"20",job:"Student")
costumer1.0+" "+costumer1.1+" "+costumer1.2+" "+costumer1.3
costumer1.0="Celalettin Berat"
costumer1.name+" "+costumer1.surname+" "+costumer1.age+" "+costumer1.job


//Dictionaries
let sayi_Dic=[
    1.79:"berat",
    1.87:"erhan",
    1.75:"bersis"
]

sayi_Dic[1.79]

let metin_Dic=[
    "berat":1.79,
    "erhan":1.87,
    "bersis":1.75
]
metin_Dic["bersis"]
//Boş Dictionary oluşturma
var dict1=[String:String]() //yol1
var dict2=Dictionary<String,String>()//yol2

//Enumaration

enum activity{
    case singing(volume:Int)
    case talking(topic:String)
}


var ses=activity.singing(volume: 11)


enum Planets : Int {
    case mercury=1
    case venus
    case earth
    case mars
}
let earth=Planets(rawValue: 3)

// range operators
let point = 33
switch point{
case 0...50:
    print("kaldin")
default:
    print("geçtin")
}
// for loop
let count=1...10

for number in count{
    print("Numara \(number)")
}

let meyveler=["elma","armut","kiraz","muz"]
for meyve in meyveler{
    print("meyve =\(meyve)")
}
func square(_ number:Int=3)->Int{
    return number*number
}
let result = square(5)

enum PasswordError:Error{
    case obvious
}

func checkPassword(_ password:String) throws -> Bool{
    if password=="password"
    {
        return true
    }
    else{
        throw PasswordError.obvious
    }

        
}
do{
    try checkPassword("password")
    print("password is good!")
}
catch{
   print("you can't use that password !!")
}


func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)

print(myNum)


func driving()->(String) -> Void{
    var i=1
    return{
        print("\(i). Im going to \($0)")
        i+=1
    }
}



struct denem
{
    var name:String
    var lastname:String
    mutating func changeTheName(changingName:String){
        name=changingName
    }
}
var insan1=denem.init(name: "Berat", lastname: "Altuntas")
print(insan1.name)
insan1.changeTheName(changingName: "Celal")
insan1.name="mahmut"
print(insan1.name)

var toys=["buzz","woody","lucy","dinosour"]
toys.firstIndex(of: "woody")
toys.remove(at:2)
print(toys[2])


struct Person {
    var name:String
    var age:Int
    static var count=0
    init(name:String,age:Int){
        self.age=age
        self.name=name
        Person.count+=1
    }
}
var person1=Person(name:"berat",age:12)
print(person1.name+String(person1.age))

person1.age=131
print(person1.name+String(person1.age))
let person2=Person(name: "Celal", age: 14)
print(Person.count)

struct Kisiler{
    private var id:String
    var name:String
    init(name:String,id:String){
        self.name=name
        self.id=id
    }
    func getId(pass:String)->String{
        if (pass=="123421"){return id}
        else {
            return "yanlış parola"
        }
    }
}
var kisi1=Kisiler(name:"Berat" ,id: "121231")
print(kisi1.getId(pass: "123421"))


//Creating Class ---  CLASS
 
class Dogs{
    var name:String
    var kind:String
    var heigth:Int
    init(name:String,kind:String,heigth:Int){
        self.name=name
        self.kind=kind
        self.heigth=heigth
    }
}
class Kanis:Dogs{
    init(name:String,heigth:Int){
        super.init(name: name, kind: "Kaniş",heigth: heigth)
    }
}

var kopek1=Kanis(name: "kaniş köpek",heigth:13)

print(kopek1.heigth)
 
 
//Override -- CLASS
class Dogs{
    func MakeNoise(){
        print("Wof Woff!")
    }
}

class Kanis:Dogs{
}

let kanis=Kanis()
kanis.MakeNoise()

let kangal=Dogs()
kangal.MakeNoise()



// Class Copying Classes

class Singer{
    var name="Taylor Swift"
}

let singer1=Singer()
print(singer1.name)

var singerChange=singer1

singerChange.name="Justin Bieber"

print(singer1.name)
 


// Deinitialize Class ---- Class

class Person{
    var name="Berat Altuntaş"
    init(){
        print(" \(name) doğdu")
    }
    
    func merhaba(){
        print("Merhaba Ben \(name)")
    }
    deinit{
        print("\(name) Öldü.")
    }
}

for _ in 1...4{
    let brt=Person()
    brt.merhaba()
}
 


 
class Singer{
    var name="ed Sheeran"
}
let singer=Singer()
print(singer.name)
singer.name="taylor swift"
print(singer.name)

 
 
// Extensions uzantılar
 
extension Int {
    var isEven:Bool{
        return self%2==0
    }
}

let number=3
print(number.isEven)



// Protocol Extensions protocol uzantıları

let python=["Eric","Graham","John","George","Terry"]
let beatles=Set(["John","Paul","George","Ringo"])

extension Collection{
    func summarize(){
        print("There are \(count) of us:")
        
        for name in self{
            print(name)
        }
    }
}

python.summarize()
beatles.summarize()

 

// Protocol-orianted Programing

protocol Identifiable{
    var id : String{ get set}
    func identify()
}

extension Identifiable{
    func identify(){
        print("My id is \(id)")
    }
}

struct User:Identifiable{
    var id: String
}
let twoStraws=User(id: "twostraws")
twoStraws.identify()



// Unwrapping

var name: String? = nil
if let unwarapped=name {
    print(unwarapped.count)
}
else {
    print("missing data")
}
 



// TypeCasting
class Animal{
    
}
class Fishs:Animal{
    func MakeBubble(){
        print("Blubb Blubb")
    }
}
class Dogs:Animal{
    func MakeNoise(){
        print("Woff!!")
    }
}

let pets=[Dogs(),Fishs(),Dogs(),Fishs(),Dogs(),Dogs()]

for pet in pets{
    if let dog=pet as? Dogs{
        dog.MakeNoise()
    }
    
    if let fish=pet as? Fishs{
        fish.MakeBubble()
    }
}
