//
//  GameOverview.swift
//  poc
//
//  Created by Tawfik Boujeh on 10.07.23.
//

import SwiftUI
import GameKit

struct GameOverview: View{
    @State private var showGameCenter = false

    @ObservedObject var matchManager: MatchManager
    let viewController = GKGameCenterViewController(state: .achievements);
    var body: some View{
        VStack{
            VStack {
                Spacer()
                Button("See your ranking") {
                    showGameCenter = true
                }
                Spacer()
                Button("Go back to home menu") {
                    matchManager.resetGame()
                }
                Spacer()
            }
            .sheet(isPresented: $showGameCenter) {
                GameCenterView(leaderboardID: "grp.Recuria")
            }
                
        }.padding()
            .onAppear(){
            }
    }
}


struct GameOverview_Previews: PreviewProvider{
    static var previews: some View{
        GameOverview(matchManager: MatchManager())
    }
}

