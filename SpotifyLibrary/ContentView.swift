//
//  ContentView.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 06/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
         
            Text("Home")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            LibraryView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Library")
                }
          
        }
    }
}

#Preview {
    ContentView()
}
