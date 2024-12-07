//
//  PlaylistListView.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//

import SwiftUI

/// A list-based view displaying playlists.
struct PlaylistListView: View {
    @Binding var playlists: [Playlist] // Binding to the list of playlists
    var onPlaylistTap: (Playlist) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Iterate through playlists and display each one
                ForEach(playlists) { playlist in
                    Button(action: {
                                           onPlaylistTap(playlist) // Call the callback when tapped
                    }){
                        HStack(spacing: 15) {
                            // Music note icon representing a playlist
                            Image(systemName: "music.note.list")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                // Playlist name
                                Text(playlist.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                // Display the number of songs in the playlist
                                Text("\(playlist.songs.count) songs")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer() // To push everything to the left
                        }
                        .padding([.horizontal, .vertical], 10) // Padding around each playlist item
                        .background(Color.black.opacity(0.7)) // Optional: Background color for each item
                        .cornerRadius(8) // Optional: Rounded corners for each item
                        .padding(.horizontal) // External padding for the list
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.top) // Padding at the top of the list
        }
    }
}

struct PlaylistListView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview with a sample playlist
        PlaylistListView(playlists: .constant([Playlist(id: UUID(), name: "My Playlist", creationDate: Date(), songs: [])]), onPlaylistTap: { playlist in
            print("Tapped on playlist: \(playlist.name)")
        })
            .preferredColorScheme(.dark)
    }
}
