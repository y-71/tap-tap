//
//  MenuView.swift
//  poc
//
//  Created by Tawfik Boujeh on 10.07.23.
//

import SwiftUI

struct MenuView: View{
    @ObservedObject var matchManager: MatchManager
    var body: some View{
        VStack{
            Spacer()
            Text("hold till infinity..").font(.largeTitle)
            Spacer()
            Button{
                matchManager.startGame()
            }label: {
                Text("Play")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .disabled(matchManager.authenticationState != .authenticated || matchManager.inGame)
            .padding(.vertical, 20)
            .padding(.horizontal, 100)
            .background(
                Capsule(style: .circular)
                    .fill(matchManager.authenticationState != .authenticated || matchManager.inGame ? Color(.gray) : Color(.blue))
            )
            Text(matchManager.authenticationState.rawValue)
                .font(.caption)
                .foregroundColor(.blue)
                .padding()
            Spacer()
        }
    }
}


struct MenuView_Previews: PreviewProvider{
    static var previews: some View{
        MenuView(matchManager: MatchManager())
    }
}
