//
//  LibraryView.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//

import SwiftUI

/// Main library screen where users can view and manage their playlists.
struct LibraryView: View {
    @StateObject private var viewModel = PlaylistViewModel()
    @State private var isAddingPlaylist = false
    @State private var isGridView = false
    @State private var searchQuery = "" // For search query
    @State private var searchResults: [Song] = [] // Store search results
    @State private var selectedPlaylist: Playlist? = nil // Store the selected playlist to add a song
    
    private let musicSearchService = MusicSearchService() // API service
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header: User icon, title, and plus button
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                    
                    Text("Your Library")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        isAddingPlaylist.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .padding([.horizontal, .top])
                .padding(.bottom, 10)
                
                // Search bar
                SearchBar(text: $searchQuery, onSearch: searchMusic)
                    .padding(.horizontal)
                
                // Grid/List toggle button
                HStack {
                    Spacer()
                    Button(action: {
                        isGridView.toggle()
                    }) {
                        Image(systemName: isGridView ? "square.grid.2x2.fill" : "list.bullet")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)
                }
                .padding(.bottom, 10)
                
                // Playlist Grid or List View
                if isGridView {
                    PlaylistGridView(playlists: $viewModel.playlists, onPlaylistTap:{
                        playlist in
                        selectedPlaylist = playlist
                    })
                } else {
                    PlaylistListView(playlists: $viewModel.playlists, onPlaylistTap: {
                        playlist in
                        selectedPlaylist = playlist
                    })
                }
                
                // Show search results in grid/list form
                if !searchResults.isEmpty {
                    if isGridView {
                        SongGridView(songs: searchResults, addSongAction: addSongToPlaylist)
                    } else {
                        SongListView(songs: searchResults, addSongAction: addSongToPlaylist)
                    }
                }
                
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $isAddingPlaylist) {
                AddPlaylistView { name in
                    viewModel.addPlaylist(name: name)
                }
            }
        }
    }
    
    // Function to call the search service and update the search results
    private func searchMusic(query: String) {
        musicSearchService.searchSongs(query: query) { songs in
            DispatchQueue.main.async {
                searchResults = songs
            }
        }
    }
    
    // Function to add a song to a playlist
    private func addSongToPlaylist(song: Song) {
        guard let playlist = selectedPlaylist else { return }
        
        if let index = viewModel.playlists.firstIndex(where: { $0.id == playlist.id }) {
            viewModel.playlists[index].addSong(song)
            viewModel.savePlaylists() // Save the updated playlists to UserDefaults
        }
    }
    
    // Function to set the selected playlist
    private func selectPlaylist(_ playlist: Playlist) {
        selectedPlaylist = playlist
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
            .preferredColorScheme(.dark)
    }
}
