//
//  SearchBar.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//



import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: (String) -> Void
    
    var body: some View {
        HStack {
            // TextField for search input
            TextField("Search for songs", text: $text)
                .padding(10)
                .background(Color.white.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(.white)
                .keyboardType(.webSearch) // Adds a search keyboard layout
                .autocapitalization(.none) // Prevents autocapitalization
            
            // Search button
            Button(action: {
                onSearch(text) // Trigger search on button tap
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
            }
            .padding(.leading, 8) // Optional: add spacing between button and text field
        }
        .padding()
        .background(Color.black.opacity(0.7)) // Background to match dark theme
        .cornerRadius(10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Test"), onSearch: { _ in })
            .padding()
            .background(Color.gray)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark) // Ensure preview matches dark mode
    }
}
