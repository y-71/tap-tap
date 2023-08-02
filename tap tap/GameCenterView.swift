import SwiftUI
import GameKit

struct GameCenterView: UIViewControllerRepresentable {
    @ObservedObject var matchManager: MatchManager

    typealias UIViewControllerType = GKGameCenterViewController

    let viewController: GKGameCenterViewController

    init(leaderboardID: String?, matchManager: MatchManager) {
        if let leaderboardID = leaderboardID {
            self.viewController = GKGameCenterViewController(leaderboardID: leaderboardID, playerScope: .global, timeScope: .allTime)
        } else {
            self.viewController = GKGameCenterViewController(state: .leaderboards)
        }
        self.viewController.navigationController?.setNavigationBarHidden(true, animated: true)
        self.matchManager = matchManager
    }

    func makeUIViewController(context: Context) -> GKGameCenterViewController {
        let gkVC = viewController
        gkVC.gameCenterDelegate = context.coordinator
        gkVC.navigationBar.isHidden = true
        return gkVC
    }
    
    func viewWillAppear(_ animated: Bool) {
            
        }
    func updateUIViewController(_ uiViewController: GKGameCenterViewController, context: Context) {
        // You can add any necessary updates here if needed.
        
    }

    func makeCoordinator() -> GKCoordinator {
        return GKCoordinator(self)
    }
}

class GKCoordinator: NSObject, GKGameCenterControllerDelegate {
    var view: GameCenterView
    private var observer: NSKeyValueObservation?
    init(_ gkView: GameCenterView) {
        self.view = gkView
        
    }

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        view.matchManager.resetGame()
    }
}
