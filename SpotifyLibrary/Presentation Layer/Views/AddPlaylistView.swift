//
//  AddPlaylistView.swift
//  SpotifyLibrary
//
//  Created by Mriganka De on 07/12/24.
//




import SwiftUI

/// A view for adding a new playlist.
struct AddPlaylistView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var playlistName: String = ""  // State variable to track the playlist name
    var onAdd: (String) -> Void  // Closure to handle playlist addition
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Name your playlist.")
                .font(.headline)
                .foregroundColor(.white)
            
            TextField("My first playlist", text: $playlistName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                onAdd(playlistName)  // Call onAdd when Confirm button is pressed
                presentationMode.wrappedValue.dismiss()  // Dismiss the view
            }) {
                Text("Confirm")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(playlistName.isEmpty)  // Disable if playlistName is empty
            
            Spacer()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))  // Background color for the view
    }
}

struct AddPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaylistView(onAdd: { _ in })
            .preferredColorScheme(.dark)  // Preview with dark mode
    }
}
