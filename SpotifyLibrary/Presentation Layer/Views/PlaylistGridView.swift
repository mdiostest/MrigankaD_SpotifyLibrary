//
//  PlaylistGridView.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//

import SwiftUI

/// A grid-based view displaying playlists.
struct PlaylistGridView: View {
    @Binding var playlists: [Playlist] // Binding to the list of playlists

    // Define the columns of the grid (two flexible columns)
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var onPlaylistTap: (Playlist) -> Void
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                // Iterate through playlists and display each one
                ForEach(playlists) { playlist in
                    Button(action: {
                                           onPlaylistTap(playlist) // Call the callback when tapped
                    }){
                        VStack(alignment: .leading, spacing: 8) {
                            // Playlist thumbnail with music icon
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.8)) // Background color
                                    .frame(height: 150) // Fixed height for the grid item
                                    .cornerRadius(8)
                                
                                // Music note icon representing a playlist
                                Image(systemName: "music.note.list")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                            }
                            
                            // Playlist name
                            Text(playlist.name)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            // Display the number of songs in the playlist
                            Text("\(playlist.songs.count) songs")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding() // Padding around the grid
        }
    }
}

struct PlaylistGridView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview with a sample playlist
        PlaylistGridView(playlists: .constant([Playlist(id: UUID(), name: "My Playlist", creationDate: Date(), songs: [])]), onPlaylistTap: { playlist in
            print("Tapped on playlist: \(playlist.name)")
        })
            .preferredColorScheme(.dark)
    }
}
