//
//  SongGridView.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//

import SwiftUI

/// A grid-based view displaying songs.
struct SongGridView: View {
    var songs: [Song]
    var addSongAction: (Song) -> Void  // Action to add song to playlist
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(songs) { song in
                    VStack(alignment: .leading, spacing: 8) {
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.8))
                                .frame(height: 150)
                                .cornerRadius(12)  // Slightly more rounded corners
                            Image(systemName: "music.note")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                        }
                        Text(song.title)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading) // Ensures text alignment
                        Text(song.artist)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading) // Ensures text alignment

                        // Add to playlist button
                        Button(action: {
                            addSongAction(song) // Pass the selected song to the action
                        }) {
                            Text("Add to Playlist")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct SongGridView_Previews: PreviewProvider {
    static var previews: some View {
        SongGridView(songs: [
            Song(id: UUID(), title: "Song 1", artist: "Artist 1", album: "Album 1", duration: 180, artworkURL: nil, previewURL: nil),
            Song(id: UUID(), title: "Song 2", artist: "Artist 2", album: "Album 2", duration: 200, artworkURL: nil, previewURL: nil)
        ], addSongAction: { song in
            // Handle add song action (for preview purposes)
            print("Adding song: \(song.title)")
        })
        .preferredColorScheme(.dark)
    }
}
