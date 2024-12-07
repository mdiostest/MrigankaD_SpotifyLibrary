//
//  MusicSearchService.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//


import Foundation

/// A service for searching songs using iTunes API.
class MusicSearchService {
    func searchSongs(query: String, completion: @escaping ([Song]) -> Void) {
        // Ensure the query is URL-encoded
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion([])  // If encoding fails, return empty array
            return
        }
        
        let urlString = "https://itunes.apple.com/search?term=\(encodedQuery)&entity=song"
        guard let url = URL(string: urlString) else {
            completion([])  // If URL is invalid, return empty array
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error with the request: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion([])  // Return empty array on error
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion([])  // Return empty array if no data
                }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(iTunesResponse.self, from: data)
                let songs = results.results.map {
                    Song(
                        id: UUID(), // Generate a new unique identifier for the song
                        title: $0.trackName,
                        artist: $0.artistName,
                        album: $0.collectionName,
                        duration: Int(TimeInterval($0.trackTimeMillis ?? 0)) / 1000, // Convert milliseconds to seconds
                        artworkURL: URL(string: $0.artworkUrl100),
                        previewURL: URL(string: $0.previewUrl)
                    )
                }
                DispatchQueue.main.async {
                    completion(songs)  // Return the results on the main thread
                }
            } catch {
                print("Error decoding the response: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion([])  // Return empty array on decoding failure
                }
            }
        }.resume()
    }
}

/// iTunes API Response.
struct iTunesResponse: Codable {
    let results: [iTunesSong]
}

/// Represents a song retrieved from the iTunes API.
struct iTunesSong: Codable {
    let trackName: String
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let previewUrl: String
    let trackTimeMillis: Int? // Duration of the track in milliseconds
}
