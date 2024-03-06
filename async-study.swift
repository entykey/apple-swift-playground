/*
import Foundation

// Define a function that performs a task asynchronously
func performTaskAsync(completion: @escaping (String) -> Void) {
    DispatchQueue.global().async {
        // Simulate a long-running task
        Thread.sleep(forTimeInterval: 2)
        
        // Once the task is done, call the completion handler with the result
        let result = "Task completed asynchronously"
        completion(result)
    }
}

// Call the asynchronous function
print("Starting task...")
performTaskAsync { result in
    print(result)
}
print("Task initiated. Waiting for completion...")
*/

/* 
Output:
This code will print:
Starting task...
Task initiated. Waiting for completion...
*/
// The reason the above code terminated too early before the task can complete is because the main thread continues executing while the asynchronous task is running in the background.



// Fix: With this modification, the main thread will not terminate immediately after initiating the asynchronous task. Instead, it will keep running until the asynchronous task completes.
/*
import Foundation

// Define a function that performs a task asynchronously
func performTaskAsync(completion: @escaping (String) -> Void) {
    DispatchQueue.global().async {
        // Simulate a long-running task
        Thread.sleep(forTimeInterval: 2)
        
        // Once the task is done, call the completion handler with the result
        let result = "Task completed asynchronously"
        completion(result)
    }
}

// Call the asynchronous function
print("Starting task...")
performTaskAsync { result in
    print(result)
}

print("Task initiated. Waiting for completion...")

// Keep the main thread alive until the asynchronous task completes
RunLoop.main.run()
*/
/* Output:
Starting task...
Task initiated. Waiting for completion...
Task completed asynchronously       <-- program did not terminate
*/



/*
// In order for the program to terminate after the asynchronous task completes, you can use a semaphore to wait for the asynchronous task to finish
// With this modification, the program will wait for the asynchronous task to complete before terminating. The semaphore ensures that the main thread waits until the asynchronous task signals that it's done. Then, the program will terminate gracefully.
import Foundation

// Define a function that performs a task asynchronously
func performTaskAsync(completion: @escaping (String) -> Void) {
    DispatchQueue.global().async {
        // Simulate a long-running task
        Thread.sleep(forTimeInterval: 2)
        
        // Once the task is done, call the completion handler with the result
        let result = "Task completed asynchronously"
        completion(result)
    }
}

// Create a semaphore
let semaphore = DispatchSemaphore(value: 0)

// Call the asynchronous function
print("Starting task...")
performTaskAsync { result in
    print(result)
    // Signal the semaphore to indicate that the task is completed
    semaphore.signal()
}

print("Task initiated. Waiting for completion...")

// Wait for the semaphore until the asynchronous task completes
semaphore.wait()

// The program will terminate after the asynchronous task completes
*/
/*
Output:
Starting task...
Task initiated. Waiting for completion...
Task completed asynchronously       -> program terminated
*/




import Foundation

func fetchImageData() async throws -> Data {
    let url = URL(string: "https://images.dog.ceo/breeds/mountain-swiss/n02107574_1387.jpg")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}

// save to Mac's temporary directory
func saveImageDataToTempDir() async throws {
    do {
        let imageData = try await fetchImageData()
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("dog_image.jpg")
        try imageData.write(to: fileURL)
        print("Image saved to: \(fileURL)")
        // eg. Image saved to: file:///var/folders/1l/5y6vf9556s70xtc92k02jsyr0000gn/T/dog_image.jpg

        exit(0) // Exit the program after saving the image
    } catch {
        print("Error saving image: \(error)")
    }
}

// Save to Documents directory "/Users/user/Documents"
func saveImageDataToDocuments() async throws {
    do {
        let imageData = try await fetchImageData()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("dog_image.jpg")
        try imageData.write(to: fileURL)
        print("Image saved to: \(fileURL)")

        exit(0) // Exit the program after saving the image
    } catch {
        print("Error saving image: \(error)")
    }
}

// Save to Downloads directory "/Users/user/Downloads"
func saveImageDataToDownloads() async throws {
    do {
        let imageData = try await fetchImageData()
        let downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        let fileURL = downloadsDirectory.appendingPathComponent("dog_image.jpg")
        try imageData.write(to: fileURL)
        print("Image saved to: \(fileURL)")

        exit(0) // Exit the program after saving the image
    } catch {
        print("Error saving image: \(error)")
    }
}

// Deprecated Usage
// WARN message: async-study.swift:162:1: warning: 'async(priority:operation:)' is deprecated: `async` was replaced by `Task.init` and will be removed shortly.
// async {
// ^

async {
    do {
        try await saveImageDataToDownloads()
    } catch {
        print("Error: \(error)")
    }
}


// New Usage
Task {
    do {
        try await saveImageDataToDownloads()
    } catch {
        print("Error: \(error)")
    }
}

// Keep the main thread alive to allow asynchronous tasks to finish
RunLoop.main.run()
