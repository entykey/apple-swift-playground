import Foundation

let fileManager = FileManager.default
let directoryURL = URL(fileURLWithPath: "/Applications")

do {
    // Change directory to /Applications
    try fileManager.changeCurrentDirectoryPath(directoryURL.path)
    
    // Get contents of the current directory
    let contents = try fileManager.contentsOfDirectory(atPath: directoryURL.path)
    
    // Print out the list of items
    print("[*] Contents of /Applications:")
    for item in contents {
        print(item)
    }
} catch {
    print("Error: \(error.localizedDescription)")
}



// $ swiftc ls-app.swift
// $ ./ls-app