//
//  ContentView.swift
//  tap tap
//
//  Created by Tawfik Boujeh on 08.07.23.
//

import SwiftUI

struct ContentView: View {
    @GestureState var isLongPress = false
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: Double.infinity).updating($isLongPress){newValue, state, transaction in state = newValue}
        VStack {
            Circle()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(isLongPress ? .orange: .blue)
                .scaleEffect(isLongPress ? 2: 1)
                .gesture(longPressGesture)
                .animation(.default, value: isLongPress)

                
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
