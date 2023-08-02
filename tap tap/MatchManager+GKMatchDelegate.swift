//
//  MatchManager+GKMatchDelegate.swift
//  tap tap
//
//  Created by Tawfik Boujeh on 14.07.23.
//

import Foundation
import GameKit
import PencilKit

extension MatchManager: GKMatchDelegate{
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        let content = String(decoding: data, as: UTF8.self)
        
        if content.starts(with: "strData:"){
            let message = content.replacing("strData:", with:"")
            receivedString(message: message)
        } else {
            do {
                try lastReceivedDrawing = PKDrawing(data: data)
            }catch{
                print(error)
            }
        }
    }
    func sendString(_ message: String){
        guard let encoded = "strData:\(message)".data(using: .utf8) else {return}
        sendData(encoded, mode: .reliable)
        
    }
    func sendData(_ data: Data, mode: GKMatch.SendDataMode){
        do{
            try match?.sendData(toAllPlayers: data, with: mode)
        } catch{
            print(error)
        }
    }
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        
    }
}
