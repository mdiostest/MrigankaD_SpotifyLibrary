//
//  PlaylistDetailView.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//


import SwiftUI

/// A detailed view for a specific playlist.
struct PlaylistDetailView: View {
    let playlist: Playlist // The playlist being passed into the detail view
    @State private var isEditing = false // Optionally allow editing songs in the playlist
    
    var body: some View {
        VStack(spacing: 20) {
            // Playlist name header
            Text(playlist.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.top)
            
            // List of songs in the playlist
            List {
                ForEach(playlist.songs) { song in
                    HStack {
                        // Song title
                        Text(song.title)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Artist name
                        Text(song.artist)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5) // Optional: Add vertical padding for better spacing
                }
                .onDelete(perform: deleteSong) // Add delete functionality for songs
            }
            .listStyle(PlainListStyle()) // To remove the default list styling for cleaner design
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Background color to match dark theme
        .navigationTitle(playlist.name) // Set the navigation title to playlist name
        .navigationBarTitleDisplayMode(.inline) // Optional: To display the title inline
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Placeholder for adding song functionality
                    isEditing.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    // Function to delete song from playlist
    private func deleteSong(at offsets: IndexSet) {
        // Implement deletion of songs from the playlist
        // You can add code to remove the song from your ViewModel's playlist if needed.
    }
}

struct PlaylistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview with a sample playlist and songs, now using optional properties
        PlaylistDetailView(playlist: Playlist(id: UUID(), name: "My Playlist", creationDate: Date(), songs: [
            Song(id: UUID(), title: "Song 1", artist: "Artist 1"),
            Song(id: UUID(), title: "Song 2", artist: "Artist 2")
        ]))
        .preferredColorScheme(.dark)
    }
}


