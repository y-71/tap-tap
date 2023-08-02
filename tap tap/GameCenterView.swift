import SwiftUI
import GameKit
public struct GameCenterView: UIViewControllerRepresentable {
    let viewController: GKGameCenterViewController
    
    public init(leaderboardID : String?) {
        
        if leaderboardID != nil {
            self.viewController = GKGameCenterViewController(leaderboardID: leaderboardID!, playerScope: GKLeaderboard.PlayerScope.global, timeScope: GKLeaderboard.TimeScope.allTime)
        }
        else{
            self.viewController = GKGameCenterViewController(state: GKGameCenterViewControllerState.leaderboards)
        }
        
    }
    
    public func makeUIViewController(context: Context) -> GKGameCenterViewController {
        let gkVC = viewController
        gkVC.gameCenterDelegate = context.coordinator
        return gkVC
    }
    
    public func updateUIViewController(_ uiViewController: GKGameCenterViewController, context: Context) {
        return
    }
    
    public func makeCoordinator() -> GKCoordinator {
        return GKCoordinator(self)
    }
}

public class GKCoordinator: NSObject, GKGameCenterControllerDelegate {
    var view: GameCenterView
    
    init(_ gkView: GameCenterView) {
        self.view = gkView
    }
    
    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
