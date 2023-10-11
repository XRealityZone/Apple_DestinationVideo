/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that presents the app's user interface.
*/

import SwiftUI

// The app uses `LibraryView` as its main UI.
struct ContentView: View {
    
    /// The library's selection path.
    @State private var navigationPath = [Video]()
    /// A Boolean value that indicates whether the app is currently presenting an immersive space.
    @State private var isPresentingSpace = false
    /// The app's player model.
    @Environment(PlayerModel.self) private var player
    
    var body: some View {
        #if os(visionOS)
        switch player.presentation {
        case .fullWindow:
            // Present the player full window and begin playback.
            PlayerView()
                .onAppear {
                    player.play()
                }
        default:
            // Show the app's content library by default.
            LibraryView(path: $navigationPath, isPresentingSpace: $isPresentingSpace)
        }
        #else
        LibraryView(path: $navigationPath)
            // A custom modifier that shows the player in a fullscreen modal presentation in iOS and tvOS.
            .fullScreenCoverPlayer(player: player)
        #endif
    }
}

#Preview {
    ContentView()
        .environment(PlayerModel())
        .environment(VideoLibrary())
}
