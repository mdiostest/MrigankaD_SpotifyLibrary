//
//  Song.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: UUID
    let title: String
    let artist: String
    let album: String? // Make album optional
    let duration: Int? // Make duration optional
    let artworkURL: URL? // Make artworkURL optional
    let previewURL: URL? // Make previewURL optional
    
    // You can add an initializer if you want to provide defaults for these properties
    init(id: UUID = UUID(), title: String, artist: String, album: String? = nil, duration: Int? = nil, artworkURL: URL? = nil, previewURL: URL? = nil) {
        self.id = id
        self.title = title
        self.artist = artist
        self.album = album
        self.duration = duration
        self.artworkURL = artworkURL
        self.previewURL = previewURL
    }
}

