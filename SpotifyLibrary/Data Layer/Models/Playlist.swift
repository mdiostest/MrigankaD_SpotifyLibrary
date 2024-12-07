//
//  Playlist.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//


import Foundation

/// Represents a playlist in the app.
struct Playlist: Identifiable, Codable {
    let id: UUID            // Unique identifier for the playlist
    var name: String        // Name of the playlist
    let creationDate: Date  // Creation date of the playlist
    var songs: [Song] = []  // List of songs in the playlist
    
    /// Adds a song to the playlist
    mutating func addSong(_ song: Song) {
        songs.append(song)
    }
    
    /// Removes a song from the playlist
    mutating func removeSong(_ song: Song) {
        if let index = songs.firstIndex(where: { $0.id == song.id }) {
            songs.remove(at: index)
        }
    }
}
