//
//  PlaylistPersistence.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//


import Foundation

/// Handles saving and loading playlists to and from UserDefaults.
class PlaylistPersistence {
    
    private let playlistsKey = "playlists"
    
    /// Saves the playlists to UserDefaults.
    func savePlaylists(_ playlists: [Playlist]) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(playlists)
            UserDefaults.standard.set(encoded, forKey: playlistsKey)
            UserDefaults.standard.synchronize() // Explicitly synchronize to ensure data is saved
        } catch {
            print("Failed to encode playlists: \(error)")
        }
    }
    
    /// Loads the playlists from UserDefaults.
    func loadPlaylists() -> [Playlist] {
        if let savedPlaylistsData = UserDefaults.standard.data(forKey: playlistsKey) {
            let decoder = JSONDecoder()
            do {
                let decodedPlaylists = try decoder.decode([Playlist].self, from: savedPlaylistsData)
                return decodedPlaylists
            } catch {
                print("Failed to decode playlists: \(error)")
            }
        }
        return [] // Return an empty array if decoding fails
    }
}
