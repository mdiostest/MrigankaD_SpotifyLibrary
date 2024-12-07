//
//  SongListView.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//

import SwiftUI

/// A list-based view displaying songs.
struct SongListView: View {
    var songs: [Song]
    var addSongAction: (Song) -> Void  // Action to add song to playlist
    
    var body: some View {
        List(songs) { song in
            HStack {
                VStack(alignment: .leading) {
                    Text(song.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(song.artist)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Add to playlist button
                Button(action: {
                    addSongAction(song) // Pass the selected song to the action
                }) {
                    Text("Add to Playlist")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 5)
        }
        .listStyle(PlainListStyle())
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView(songs: [
            Song(id: UUID(), title: "Song 1", artist: "Artist 1", album: "Album 1", duration: 180, artworkURL: nil, previewURL: nil),
            Song(id: UUID(), title: "Song 2", artist: "Artist 2", album: "Album 2", duration: 200, artworkURL: nil, previewURL: nil)
        ], addSongAction: { song in
            // Handle add song action (for preview purposes)
            print("Adding song: \(song.title)")
        })
        .preferredColorScheme(.dark)
    }
}
