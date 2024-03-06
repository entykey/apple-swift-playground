// Swift closure expression
// Closure expressions in Swift allow you to write inline closures without needing to define a separate function. They can capture and store references to any constants and variables from the surrounding context in which they are defined. 
/*
let numbers = [1, 2, 3, 4, 5]
let mappedNumbers = numbers.map({ number in
    return number * 2
})
print(mappedNumbers) // Output: [2, 4, 6, 8, 10]

// This Swift closure expression takes an array of numbers, multiplies each number by 2, and returns a new array with the transformed values.
*/

/* 
equivalent C code:
#include <stdio.h>

int main() {
    int numbers[] = {1, 2, 3, 4, 5};
    int mappedNumbers[5];

    for (int i = 0; i < 5; ++i) {
        mappedNumbers[i] = numbers[i] * 2;
    }

    for (int i = 0; i < 5; ++i) {
        printf("%d ", mappedNumbers[i]);
    }
    printf("\n"); // Output: 2 4 6 8 10

    return 0;
}


equivalent Rust code:

fn main() {
    let numbers = vec![1, 2, 3, 4, 5];
    let mapped_numbers: Vec<_> = numbers.iter().map(|&number| number * 2).collect();
    println!("{:?}", mapped_numbers); // Output: [2, 4, 6, 8, 10]
}

*/



/*
// Swift Closure Function
let addNumbers: (Int, Int) -> Int = { (a, b) in
    return a + b
}

// Usage
let result = addNumbers(3, 5)
print("Result:", result) // Output: Result: 8
*/


/*
import Foundation

func fetchData(completion: @escaping (Result<String, Error>) -> Void) {
    // Simulating asynchronous operation, such as fetching data from a network
    DispatchQueue.global().async {
        // Simulate delay
        Thread.sleep(forTimeInterval: 2)
        
        // Data fetching completed, call the completion handler
        completion(.success("Data fetched successfully"))
    }
}

// Usage
fetchData { result in
    switch result {
    case .success(let data):
        print(data)
    case .failure(let error):
        print("Error: \(error)")
    }
}
// No output
*/

// The program terminates immediately because the main thread of execution completes before the asynchronous operation inside fetchData has a chance to finish.
// To see the output, we need to keep the main thread alive until the asynchronous operation completes.
// We can achieve this by using a semaphore or by running the run loop. Here's how you can use a semaphore to keep the main thread alive:
import Foundation

func fetchData(completion: @escaping (Result<String, Error>) -> Void) {

    // Simulating asynchronous operation, such as fetching data from a network
    DispatchQueue.global().async {

        // Simulate delay
        Thread.sleep(forTimeInterval: 0.5) // Sleep for 500 milliseconds
        
        // Data fetching completed, call the completion handler
        completion(.success("Data fetched successfully"))
    }
}

// Create a semaphore to keep the main thread alive
let semaphore = DispatchSemaphore(value: 0) // semaphore: DispatchSemaphore

// Usage
fetchData { result in   // result: Result<String, Error>

    switch result {
        case .success(let data):
            print(data)
        case .failure(let error):
            print("Error: \(error)")
    }
    
    // Signal the semaphore to release the main thread
    semaphore.signal()
}

// Wait for the asynchronous operation to complete before exiting
semaphore.wait()
/*
Output: (with delay)
Data fetched successfully
*/