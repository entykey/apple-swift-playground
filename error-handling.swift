/*
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0


    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }


        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }


        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }


        coinsDeposited -= item.price


        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem


        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."

*/




// This program try to open & read a file in macos dir "/Users/user/Documents"
import Foundation

enum FileError: Error {
    case fileNotFound
    case permissionDenied
    case unknownError
}

func openFile(fileName: String) throws {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    
    do {
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        print("File content: \(fileContents)")
    } catch let error as NSError {
        if error.code == NSFileReadNoSuchFileError {
            throw FileError.fileNotFound
        } else if error.code == NSFileReadNoPermissionError {
            throw FileError.permissionDenied
        } else {
            throw FileError.unknownError
        }
    }
}

// Example usage
do {
    try openFile(fileName: "example.txt")
} catch FileError.fileNotFound {
    print("File not found")
} catch FileError.permissionDenied {
    print("Permission denied")
} catch {
    print("An unknown error occurred")
}





// $ swiftc error-handling.swift
// $ ./error-handling