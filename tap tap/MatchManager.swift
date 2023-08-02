//
//  MatchManager.swift
//  poc
//
//  Created by Tawfik Boujeh on 10.07.23.
//

import Foundation
import GameKit
import PencilKit

class MatchManager: NSObject, ObservableObject{
    @Published var authenticationState = PlayerAuthState.authenticating
    @Published var inGame = false
    @Published var isGameOver = false
    
    private var scoreInCentiseconds: UInt = 0
    let leaderboardIDs = ["grp.Recuria"]

    var localPlayer = GKLocalPlayer.local
    var playerUUIDKey = UUID().uuidString
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    func authenticateUser(){
        GKLocalPlayer.local.authenticateHandler = { [self] vc, e in
            if let viewController = vc {
                rootViewController?.present(viewController, animated: true)
                return
            }
            if let error = e {
                authenticationState = .error
                print(error.localizedDescription)
                return
            }
            if localPlayer.isAuthenticated{
                if localPlayer.isMultiplayerGamingRestricted{
                    authenticationState = .restricted
                } else {
                    authenticationState = .authenticated
                }
            } else {
                authenticationState = .unauthenticated
            }
        }
    }
    
    func renderMinutes()->String{
        return renderInDoubleDigits(number: scoreInCentiseconds/100/60/60)
    }
    
    func renderSeconds()->String{
        return renderInDoubleDigits(number: scoreInCentiseconds/100%60)
    }
    
    func renderCentiseconds()->String{
        return renderInDoubleDigits(number: scoreInCentiseconds%100)
    }
    
    func renderInDoubleDigits(number: UInt)-> String{
        return number<10 ? "0\(number)" :"\(number)"
    }
    
    func incrementScore(){
        scoreInCentiseconds+=1
    }
    
    func startGame(){
        inGame = true
    }
    func returnToStartMenu(){
        isGameOver = true
        inGame = false
    }
    func loadScores() async {
        do {
            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: self.leaderboardIDs)
            if let recuriaLeaderboard = leaderboards.first {
                let (localPlayerEntry, leaderboardEntries, _) = try await recuriaLeaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 100))
                for leaderboardEntry in leaderboardEntries {
                    let photo: UIImage = try await leaderboardEntry.player.loadPhoto(for: .small)
                }
                print(localPlayerEntry?.rank ?? "no localPlayerEntry rank")
            }
        } catch {
            print("Error loading leaderboards: \(error.localizedDescription)")
        }
    }
    func submitScore(){
        isGameOver = true
        
        GKLeaderboard.loadLeaderboards(IDs: self.leaderboardIDs) { leaderboards, error in
            if let error = error {
                // Handle the error
                print("Error loading leaderboards: \(error.localizedDescription)")
            } else if let recuriaLeaderboard = leaderboards?.first {
                // SubmitScore
                recuriaLeaderboard.submitScore(Int(self.scoreInCentiseconds), context: 0, player: self.localPlayer){ error in
                    if let error = error {
                        // Handle the error
                        print("Error submitting score: \(error.localizedDescription)")
                    } else {
                        // Score submitted successfully
                        print("Score submitted successfully!")
                    }
                }

            }
        }
    }
    func resetGame(){
        self.isGameOver = false
        self.inGame = false
        self.scoreInCentiseconds = 0
    }
    
}

