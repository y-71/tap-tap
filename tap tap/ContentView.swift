//
//  ContentView.swift
//  poc
//
//  Created by Tawfik Boujeh on 10.07.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var matchManager = MatchManager()
    var body: some View {
        ZStack {
            if matchManager.isGameOver{
                GameOverview(matchManager: matchManager)
            } else if matchManager.inGame{
                GameView(matchManager: matchManager)
            } else {
                MenuView(matchManager: matchManager)
            }
        }.onAppear{
            matchManager.authenticateUser()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
