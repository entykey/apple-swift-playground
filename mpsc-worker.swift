/*
import Foundation

let NUM_WORKERS: UInt8 = 4
let NUM_TASKS: UInt8 = 20

func worker(taskChannel: DispatchQueue, resultChannel: DispatchQueue, id: UInt8) {
    print("Worker \(id) is waiting for tasks.")

    while let task = taskChannel.sync(execute: { () -> Int? in
        return taskChannel.getSpecific(key: DispatchSpecificKey<Int>()) // Check if task exists
    }) {
        print("Worker \(id) is processing task: \(task)")

        // Simulate some work
        Thread.sleep(forTimeInterval: 0.2)

        // Send the result back to the result channel
        resultChannel.sync {
            print("Result of task \(task): done")
        }
    }

    print("Worker \(id) is exiting.")
}

// Define DispatchQueues for task and result channels
let taskChannel = DispatchQueue(label: "taskChannel", attributes: .concurrent)
let resultChannel = DispatchQueue(label: "resultChannel", attributes: .concurrent)

// Create worker threads
for id in 0..<NUM_WORKERS {
    DispatchQueue.global().async {
        worker(taskChannel: taskChannel, resultChannel: resultChannel, id: id)
    }
}

// Submit tasks to the worker pool
for taskId in 0..<NUM_TASKS {
    taskChannel.sync {
        taskChannel.setSpecific(key: DispatchSpecificKey<Int>(), value: Int(taskId))
    }
}

// Signal workers to exit
for _ in 0..<NUM_WORKERS {
    taskChannel.sync {
        taskChannel.setSpecific(key: DispatchSpecificKey<Int>(), value: nil)
    }
}

// Wait for all tasks to complete
resultChannel.sync(flags: .barrier) {
    print("All tasks completed")
}
*/



import Foundation

let NUM_WORKERS: UInt8 = 4
let NUM_TASKS: UInt8 = 20

func worker(taskChannel: DispatchQueue, resultChannel: DispatchQueue, id: UInt8) {
    print("Worker \(id) is waiting for tasks.")

    while let task = taskChannel.sync(flags: .barrier) { () -> Int? in
        if let task = taskChannel.getSpecific(key: DispatchSpecificKey<Int>()) {
            taskChannel.setSpecific(key: DispatchSpecificKey<Int>(), value: nil)
            return task
        }
        return nil
    } {
        print("Worker \(id) is processing task: \(task)")

        // Simulate some work
        Thread.sleep(forTimeInterval: 0.2)

        // Send the result back to the result channel
        resultChannel.sync {
            print("Result of task \(task): done")
        }
    }

    print("Worker \(id) is exiting.")
}

// Define DispatchQueues for task and result channels
let taskChannel = DispatchQueue(label: "taskChannel", attributes: .concurrent)
let resultChannel = DispatchQueue(label: "resultChannel", attributes: .concurrent)

// Create worker threads
for id in 0..<NUM_WORKERS {
    DispatchQueue.global().async {
        worker(taskChannel: taskChannel, resultChannel: resultChannel, id: id)
    }
}

// Submit tasks to the worker pool
for taskId in 0..<NUM_TASKS {
    taskChannel.sync(flags: .barrier) {
        taskChannel.setSpecific(key: DispatchSpecificKey<Int>(), value: Int(taskId))
    }
}

// Wait for all tasks to complete
Thread.sleep(forTimeInterval: 2) // Allow some time for tasks to complete
