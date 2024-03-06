/*
import Foundation

// Define a struct to represent a Post
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// Function to fetch posts from the API
func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
    // URL of the mock API
    let apiUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    // Create a URLSession
    let session = URLSession.shared
    
    // Create a data task to fetch the data
    let task = session.dataTask(with: apiUrl) { (data, response, error) in
        // Check for errors
        if let error = error {
            completion(nil, error)
            return
        }
        
        // Check if data is available
        guard let responseData = data else {
            completion(nil, NSError(domain: "NoData", code: -1, userInfo: nil))
            return
        }
        
        do {
            // Decode the JSON response into an array of Post objects
            let posts = try JSONDecoder().decode([Post].self, from: responseData)
            completion(posts, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    // Start the data task
    task.resume()
}

// Fetch and print posts
fetchPosts { (posts, error) in
    if let error = error {
        print("Error fetching posts:", error)
        return
    }
    
    if let posts = posts {
        for post in posts {
            print("Post ID:", post.id)
            print("Title:", post.title)
            print("Body:", post.body)
            print("-----------")
        }
    }
}
*/


/*
import Foundation

// Define a struct to represent a Post
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// Function to fetch posts from the API asynchronously
func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
    // URL of the mock API
    let apiUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    // Create a URLSession
    let session = URLSession.shared
    
    // Create a data task to fetch the data
    let task = session.dataTask(with: apiUrl) { (data, response, error) in
        // Check for errors
        if let error = error {
            completion(nil, error)
            return
        }
        
        // Check if data is available
        guard let responseData = data else {
            completion(nil, NSError(domain: "NoData", code: -1, userInfo: nil))
            return
        }
        
        do {
            // Decode the JSON response into an array of Post objects
            let posts = try JSONDecoder().decode([Post].self, from: responseData)
            completion(posts, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    // Start the data task
    task.resume()
}

// Async function to fetch and print posts
func fetchAndPrintPosts() async {
    do {
        // Fetch posts asynchronously
        let posts = try await withCheckedThrowingContinuation { continuation in
            fetchPosts { posts, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: posts ?? [])
                }
            }
        }
        
        // Print posts
        for post in posts {
            print("Post ID:", post.id)
            print("Title:", post.title)
            print("Body:", post.body)
            print("-----------")
        }
    } catch {
        print("Error fetching or printing posts:", error)
    }
}

// Call the async function to fetch and print posts
Task {
    await fetchAndPrintPosts()
}
*/


import Foundation

// Define a struct to represent a Post
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// Function to fetch posts from the API asynchronously
func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
    // URL of the mock API
    let apiUrl: URL = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
    
    // Create a URLSession
    let session = URLSession.shared
    
    // Create a data task to fetch the data
    let task = session.dataTask(with: apiUrl) { (data, response, error) in
        // Check for errors
        if let error = error {
            completion(nil, error)
            return
        }
        
        // Check if data is available
        guard let responseData = data else {
            completion(nil, NSError(domain: "NoData", code: -1, userInfo: nil))
            return
        }
        
        do {
            // Decode the JSON response into an array of Post objects
            let posts = try JSONDecoder().decode([Post].self, from: responseData)
            completion(posts, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    // Start the data task
    task.resume()
}

// Async function to fetch and print posts
func fetchAndPrintPosts() async {
    do {
        let taskTime: DispatchTime = DispatchTime.now()

        // Fetch posts asynchronously
        let posts = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[Post], Error>) in
            fetchPosts { posts, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: posts ?? [])
                }
            }
        }
        
        // Print posts
        for post in posts {
            print("Post ID:", post.id)
            print("Title:", post.title)
            print("Body:", post.body)
            print("-----------")
        }
        // End of task
        let duration: UInt64 = DispatchTime.now().uptimeNanoseconds - taskTime.uptimeNanoseconds
        let elapsedMicro: Double = Double(duration) / 1_000
        let elapsedMs: Double = Double(duration) / 1_000_000
        let elapsedSec: Double = Double(duration) / 1_000_000_000

        print("\n⌛️ Took: \(duration) ns (\(elapsedMs) ms) (\(elapsedMicro) µs) (\(elapsedSec) s)")

        exit(0) // Exit the program after done all the works
    } catch {
        print("Error fetching or printing posts:", error)
    }
}

// Function to fetch a single post by ID from the API asynchronously
func fetchOnePostAndPrint(postId: Int) {
    // URL of the mock API
    let apiUrl = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postId)")!
    
    // Create a URLSession
    let session = URLSession.shared
    
    // Create a data task to fetch the data
    let task = session.dataTask(with: apiUrl) { (data, response, error) in
        // Check for errors
        if let error = error {
            print("Error fetching post: \(error)")
            return
        }
        
        // Check if data is available
        guard let responseData = data else {
            print("No data received")
            return
        }
        
        do {
            // Decode the JSON data into a Post object
            let post = try JSONDecoder().decode(Post.self, from: responseData)
            
            // Print the fetched post
            print("Fetched Post:")
            print("User ID: \(post.userId)")
            print("ID: \(post.id)")
            print("Title: \(post.title)")
            print("Body: \(post.body)")

            exit(0) // Exit the program after done all the works
        } catch {
            print("Error decoding post: \(error)")
        }
    }
    
    // Resume the task
    task.resume()

    // Usage: Fetch and print post with ID 1: fetchOnePostAndPrint(postId: 1)
}

// Call the async function to fetch and print posts
Task {

    // await fetchAndPrintPosts()
    await fetchOnePostAndPrint(postId: 1)

}

// Keep the main thread alive to allow asynchronous tasks to finish
RunLoop.main.run()

// swiftc fetch-api.swift
// ./fetch-api