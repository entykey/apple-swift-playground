// First note: DispatchQueue is a part of Apple's Grand Central Dispatch (GCD) framework, which provides easy-to-use APIs for managing concurrent and serial execution of tasks in multithreaded environments. It's a powerful tool for managing asynchronous operations in Swift and Objective-C.
/*
import Foundation

// Dispatch work asynchronously on the main queue
DispatchQueue.main.async {
    print("Performing UI updates on the main queue...")
    // Update UI or perform other main thread tasks
}

// Dispatch work asynchronously on a global queue with user-initiated QoS
DispatchQueue.global(qos: .userInitiated).async {
    print("Performing background task on a global queue...")
    // Simulate background task
    for i in 1...3 {
        print("Task \(i) in progress...")
        // sleep(1) // Simulate work for 1 second
    }
    print("Background task completed.")
}

// Dispatch work synchronously on a custom serial queue
let customQueue = DispatchQueue(label: "com.example.customqueue")
customQueue.sync {
    print("Performing tasks serially on a custom queue...")
    // Perform tasks serially
    for i in 1...3 {
        print("Task \(i) in progress...")
        // sleep(1) // Simulate work for 1 second
    }
    print("Serial tasks completed.")
}

*/




import Foundation

// Define a custom DispatchQueue
let customQueue = DispatchQueue(label: "com.example.serial", attributes: .concurrent)

// Define a global DispatchQueue
let globalQueue = DispatchQueue.global()

// Define a DispatchGroup
let group = DispatchGroup()

print("Performing background task on a global queue...")

// Enter the DispatchGroup for the global queue task
group.enter()
globalQueue.async {
    // Simulate some work
    Thread.sleep(forTimeInterval: 1)
    print("Background task completed.")
    group.leave()
}

print("Performing tasks serially on a custom queue...")

// Mark the start time
let startTime = DispatchTime.now()

// Enter the DispatchGroup for the serial tasks
for i in 1...3 {
    group.enter()
    customQueue.async {
        // Simulate some work
        Thread.sleep(forTimeInterval: 1)
        print("Task \(i) in progress...")
        group.leave()
    }
}

// Notify when all tasks are completed
group.notify(queue: .main) {
    // Calculate the elapsed time
    let elapsedTime = DispatchTime.now().uptimeNanoseconds - startTime.uptimeNanoseconds
    let milliseconds = Double(elapsedTime) / 1_000_000
    let microseconds = Double(elapsedTime) / 1_000
    let seconds = Double(elapsedTime) / 1_000_000_000

    print("Serial tasks completed.")
    print("Elapsed time: \(milliseconds) ms")
    print("Elapsed time: \(microseconds) µs")
    print("Elapsed time: \(seconds) s")
}




// swiftc dispatch-queue.swift
// ./dispatch-queue
