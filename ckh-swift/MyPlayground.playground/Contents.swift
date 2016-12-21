import Foundation

class Resident {
    var firstName : String
    var middleName : String
    var lastname : String
    var salutation : String
    
    init(salutation : String, firstName : String, middleName : String, lastName : String) {
        self.firstName = firstName
        self.middleName = middleName
        self.lastname = lastName
        self.salutation = salutation
    }
    
    convenience init(fullName : String) {
        let names = fullName.components(separatedBy: " ")
        self.init(salutation : "", firstName : names[0], middleName : "", lastName : names[1])
    }
    
    
}

class House {
    
    //store property
    var name : String
    var residents : [Resident]?
    var address : String
    
    //compute property
    var info : String{
        var  houseInfo = "In this house resides "
        for resident in residents!{
            houseInfo += "\(resident.firstName)"
        }
        return houseInfo
    }
    
    let something = ""
    
    //init , paramaeter with default value
    init(houseName : String, houseAddress : String, residents : [Resident]? = nil) {
        name = houseName
        address = houseAddress
        self.residents = residents
    }
    
}


//category
// extend the functionality of class
extension House{
    var numberOfCars : Int{
        return residents!.count
    }
    func randomFunction(){
        
    }
}