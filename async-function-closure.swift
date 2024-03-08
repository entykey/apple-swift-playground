/*
Note:
In Swift, the "@escaping" keyword is used to indicate that a closure parameter passed to a function will be stored beyond the scope of that function. This means that the closure will outlive the function it was passed to and may be called at a later time. By marking a closure parameter as "@escaping", you are informing the compiler that the closure may escape the current scope and should be retained to prevent memory leaks. This is particularly useful when passing closures as completion handlers or callbacks that need to be executed asynchronously.
*/

// Terminate right away without any result:
/*
import Foundation

func fetchData(completion: @escaping (Result<String, Error>) -> Void) {
    DispatchQueue.global().async {
		print("fetching data...")
	
	    // sleep bot working in mobile compiler !!!
        // Simulating a network request that takes time
        sleep(1)
        
        // Assuming the data is fetched successfully
        let data = "This is the fetched data"
        
        // Call the completion handler with the result
        completion(.success(data))
    }
}

// Calling the async function
fetchData { result in
    switch result {
    case .success(let data):
        print("Data fetched successfully: \(data)")
    case .failure(let error):
        print("Error fetching data: \(error)")
    }
}
*/

// FIX: The above code terminated without any result because the main thread is likely completing execution before the asynchronous operation inside fetchData(completion:) completes. This happens because the main thread doesn't wait for the asynchronous operation to finish before continuing with the rest of the code.
// To see the result of the asynchronous operation, you need to make sure that your program continues to run until the asynchronous operation is completed. One way to achieve this is by using a semaphore to wait for the asynchronous operation to finish. However, using a semaphore for this purpose can lead to deadlocks if not used carefully.
// Alternatively, you can use a DispatchGroup to handle this scenario. Here's how you can modify the code to use a DispatchGroup:
import Foundation

func fetchData(completion: @escaping (Result<String, Error>) -> Void) {
    DispatchQueue.global().async {
        print("fetching data...")
        
        // Simulating a network request that takes time
        sleep(1)
        
        // Assuming the data is fetched successfully
        let data = "This is the fetched data"
        
        // Call the completion handler with the result
        completion(.success(data))
    }
}

// Create a dispatch group
let group = DispatchGroup()

// Enter the group
group.enter()

// Calling the async function
fetchData { result in
    switch result {
    case .success(let data):
        print("Data fetched successfully: \(data)")
    case .failure(let error):
        print("Error fetching data: \(error)")
    }
    
    // Leave the group when the async operation completes
    group.leave()
}

// Wait for the async operation to complete
group.wait()

print("Async operation completed")


// $ swiftc async-function-closure.swift
// $ ./async-function-closure