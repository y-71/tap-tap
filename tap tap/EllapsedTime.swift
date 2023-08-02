//
//  Timer.swift
//  tap tap
//
//  Created by Tawfik Boujeh on 16.07.23.
//

import SwiftUI

struct EllapsedTime: View {
    @ObservedObject var matchManager: MatchManager
    var body: some View{
        HStack{
            // Minutes
            Text(matchManager.renderMinutes()).frame(width: 50, height: 50)
            
            Text(":")
            
            // Seconds
            Text(matchManager.renderSeconds()).frame(width: 50, height: 50)
            Text(":")
            
            // CentiSeconds
            Text(matchManager.renderCentiseconds()).frame(width: 50, height: 50)
            
        }
        .font(.system(size: 40))
    }
}

struct EllapsedTime_Previews: PreviewProvider {
    static var previews: some View {
        EllapsedTime(matchManager: MatchManager())
    }
}
