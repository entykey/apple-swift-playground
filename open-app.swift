/*
import AppKit

let workspace = NSWorkspace.shared
let textEditPath = "/Applications/TextEdit.app"

if workspace.openFile(textEditPath) {
    print("TextEdit opened successfully")
} else {
    print("Unable to open TextEdit")
}
*/



// import AppKit

// let workspace = NSWorkspace.shared
// let textEditURL = URL(fileURLWithPath: "/Applications/TextEdit.app")

// do {
//     try workspace.open(textEditURL)
//     print("TextEdit opened successfully")
// } catch {
//     print("Unable to open TextEdit: \(error.localizedDescription)")
// }



import AppKit

let workspace = NSWorkspace.shared
let textEditURL = URL(fileURLWithPath: "/Applications/Xcode.app")

do {
    try workspace.open(textEditURL, options: .default, configuration: [:])
    print("TextEdit opened successfully")
} catch {
    print("Unable to open TextEdit: \(error.localizedDescription)")
}






// $ swiftc open-app.swift
// $ ./open-app