//
//  GameView.swift
//  poc
//
//  Created by Tawfik Boujeh on 10.07.23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var matchManager: MatchManager
    @State private var progress = 0.0
    @State private var isDetectingLongPress = false
    
    var body: some View{
        
        VStack(spacing: 10){
            Spacer()
            timer
            Spacer()
            progressView.padding()
            Spacer()
        }.onAppear{
            //Timer
            _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){
                time in
                withAnimation{
                    if (!isDetectingLongPress){return}
                    matchManager.incrementScore()
                    progress += 0.001
                    if progress >= 0.999 {
                        progress = 0
                    }
                }
            }
        }
    }
    var progressView: some View{
        ZStack{
            //Background
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 12, dash:[1,2])).opacity(0.3)
                .foregroundColor(.gray)
            //Shadow
            Circle()
                .fill(.blue)
                .blur(radius: 250)
                .scaleEffect(isDetectingLongPress ? 1 : 0)
                .padding()
                .animation(.easeInOut.speed(1.4), value: isDetectingLongPress)
            //Overlay
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress,1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12, dash: [1,2]))
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: 270))
        }.padding()
            .onLongPressGesture(minimumDuration: .infinity) {}

            onPressingChanged: { inProgress in
                let lastLongPressState = isDetectingLongPress
                isDetectingLongPress = inProgress
                if lastLongPressState == true && inProgress == false{
                    print("longPress ended")
                    matchManager.submitScore()
                }
            }
    }
    var timer: some View{
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


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(matchManager: MatchManager())
    }
}
