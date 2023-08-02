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
                GameCenterView(leaderboardID: "grp.Recuria", matchManager: matchManager)
                    .ignoresSafeArea()
                    
            }
        }
    }
}


struct GameOverview_Previews: PreviewProvider{
    static var previews: some View{
        GameOverview(matchManager: MatchManager())
    }
}

