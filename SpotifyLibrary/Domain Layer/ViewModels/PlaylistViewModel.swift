//
//  PlaylistViewModel.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//

import Foundation
import SwiftUI

/// ViewModel for managing playlists in the app.
class PlaylistViewModel: ObservableObject {
    @Published var playlists: [Playlist] = [] // List of playlists
    
    private let storageKey = "playlists" // Key for UserDefaults storage
    
    init() {
        loadPlaylists() // Load playlists when the ViewModel is initialized
    }
    
    /// Adds a new playlist with the provided name.
    func addPlaylist(name: String) {
        let newPlaylist = Playlist(id: UUID(), name: name, creationDate: Date(), songs: [])
        playlists.append(newPlaylist)
        savePlaylists() // Save the new playlist to persistent storage
    }
    
    /// Removes a playlist at a specific index.
    func removePlaylist(at index: Int) {
        playlists.remove(at: index)
        savePlaylists() // Save after removal
    }
    
    /// Adds a song to an existing playlist.
    func addSongToPlaylist(song: Song, playlistId: UUID) {
        if let index = playlists.firstIndex(where: { $0.id == playlistId }) {
            playlists[index].addSong(song)  // Add the song to the playlist
            savePlaylists()  // Save updated playlists
        }
    }
    
    /// Saves playlists to persistent storage (UserDefaults).
    func savePlaylists() {  // Changed from private to internal
        do {
            let data = try JSONEncoder().encode(playlists)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to save playlists: \(error.localizedDescription)")
        }
    }
    
    /// Loads playlists from persistent storage (UserDefaults).
    private func loadPlaylists() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            playlists = try JSONDecoder().decode([Playlist].self, from: data)
        } catch {
            print("Failed to load playlists: \(error.localizedDescription)")
        }
    }
}

#if DEBUG
struct PlaylistViewModel_Previews: PreviewProvider {
    static var previews: some View {
        // Use LibraryView to show the preview of the view that uses PlaylistViewModel
        LibraryView()
            .preferredColorScheme(.dark)
    }
}
#endif
