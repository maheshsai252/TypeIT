//
//  FontChangerAnimation.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/7/23.
//

import SwiftUI

struct FontChangerAnimation: View {
    @State var text = ""
    @State var word = "typography"
    @State var timer: Timer?

    var body: some View {
        VStack {
            LinearGradient(
                colors: [.red, .blue, .green, .yellow],
                startPoint: .leading,
                endPoint: .trailing
            )
            .mask(
                // 1
                Text(text)
                    .font(.custom("cursive", size: 20))
                    .multilineTextAlignment(.center)
            )
           
               
        }.onAppear() {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
                    updateCounting()
                })
        }
        
    }
    func updateCounting() {
        if(!self.word.isEmpty) {
            withAnimation(.interactiveSpring()) {
                self.text.append(String(word.removeFirst() ))
            }
            
        } else {
            self.timer?.invalidate()
        }
    }
}

struct FontChangerAnimation_Previews: PreviewProvider {
    static var previews: some View {
        FontChangerAnimation()
    }
}
