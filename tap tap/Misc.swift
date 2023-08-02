//
//  Misc.swift
//  poc
//
//  Created by Tawfik Boujeh on 10.07.23.
//

import Foundation

enum PlayerAuthState: String {
    case authenticating = "Logging in to Game Center..."
    case unauthenticated = "Please sign in to Game Center to play."
    case authenticated = ""
    
    case error = "There was an error logging into Game Center."
    case restricted = "You're not allowed to play multiplayer games!"
}
struct Player{
    var name: String
    var rank: Int
}

let maxTimeRemaining = 100
