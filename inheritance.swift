//*

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        print("Default Vehicle Noise...")
    }
}

// a subclass: automatically gains all of the characteristics of Vehicle, 
class Bicycle: Vehicle {
    var hasBasket = false

    override func makeNoise() {
        print("Keng Keng")
    }
}

// Subclasses can themselves be subclassed
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

// Overriding
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

// Overriding Property Getters and Settersin page link
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

// Overriding Property Observers
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

// Preventing Overrides
// final class TrainingCar: Car {

// }

// class SubTrainingCar : TrainingCar {}
// err:
// inheritance.swift:57:7: error: inheritance from a final class 'TrainingCar'
// class SubTrainingCar : TrainingCar {}
//       ^

// create a new instance of Vehicle with initializer syntax
let someVehicle = Vehicle()
someVehicle.currentSpeed = 10
print("Vehicle: \(someVehicle.description)")
someVehicle.makeNoise()

let bicycle = Bicycle()
bicycle.hasBasket = true
// print("Bicycle: \(bicycle)") // Bicycle: inheritance.Bicycle
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
bicycle.makeNoise()


let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
tandem.makeNoise()

let train = Train()
train.makeNoise()

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")



//*/



/*
// Define an opaque return type for a vehicle
protocol VehicleProtocol {
    func description() -> String
}

// Base class
class Vehicle: VehicleProtocol {
    var currentSpeed = 0.0
    
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
    
    // Method returning opaque type
    func getVehicle() -> some VehicleProtocol {
        return self
    }
    
    func description() -> String {
        return "Vehicle: traveling at \(currentSpeed) miles per hour"
    }
}

// Subclass
class Bicycle: Vehicle {
    var hasBasket = false
    
    override func description() -> String {
        return "Bicycle: traveling at \(currentSpeed) miles per hour"
    }
}

// Another subclass
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
    
    override func description() -> String {
        return "Tandem: traveling at \(currentSpeed) miles per hour with \(currentNumberOfPassengers) passengers"
    }
}

// Create instances
let someVehicle = Vehicle()
let bicycle = Bicycle()
let tandem = Tandem()

// Set properties
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0

tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0

// Access descriptions using opaque type
let vehicles: [VehicleProtocol] = [someVehicle, bicycle, tandem]
for vehicle in vehicles {
    print(vehicle.description())
}
*/
/*
Output:
Vehicle: traveling at 0.0 miles per hour
Bicycle: traveling at 15.0 miles per hour
Tandem: traveling at 22.0 miles per hour with 2 passengers
*/





// $ swiftc inheritance.swift
// $ ./inheritance