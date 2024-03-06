import Foundation

let validStatus = 200...299

enum QuakeError: Error {
    case networkError
}

protocol HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw QuakeError.networkError
        }
        return data
    }
}

struct Quake: Decodable {
    // Define properties of Quake
}

struct GeoJSON: Decodable {
    let quakes: [Quake]
    // Implement initializer if necessary
}

class QuakeClient {
    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!

    private let downloader: HTTPDataDownloader

    init(downloader: HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }

    // func fetchQuakes() async throws -> [Quake] {
    //     let data = try await downloader.httpData(from: feedURL)
    //     let allQuakes = try JSONDecoder().decode(GeoJSON.self, from: data)
    //     return allQuakes.quakes
    // }

    func fetchQuakes() async throws -> [Quake] {
        let data = try await downloader.httpData(from: feedURL)
        let jsonString = String(data: data, encoding: .utf8) ?? "Invalid JSON"
        print("Raw JSON data:", jsonString) // Print raw JSON data for debugging
        let allQuakes = try JSONDecoder().decode(GeoJSON.self, from: data)
        return allQuakes.quakes
    }

}

// Usage
Task {
    do {
        let client = QuakeClient()
        let quakes = try await client.fetchQuakes()
        print("Quakes fetched successfully: \(quakes)")
    } catch {
        print("Error fetching quakes: \(error)")
    }
}
RunLoop.main.run()



// swiftc network-test-client.swift
// ./network-test-client