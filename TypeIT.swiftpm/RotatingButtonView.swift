//
//  RotatingButtonView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/11/23.
//

import SwiftUI

struct RotatingButtonView: View {
    @State private var isAnimating = false
    var label: String
    var foreverAnimation: Animation {
        Animation.linear(duration: 4.0)
            .repeatForever(autoreverses: false)
    }
    var action: () -> ()
    var body: some View {
        Button {
            action()
            
        } label: {
                

                Image(systemName: label)
                
                    .resizable()
                    .frame(width: 45, height: 45)
                    .padding()
                    .foregroundColor(self.isAnimating ? .mint : .yellow)
                   
            }
        
            .onAppear {
                
                withAnimation(foreverAnimation) {
                    self.isAnimating = true
                }
            }
    }
    
}

struct RotatingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RotatingButtonView(label: "arrow.right.circle", action:  {
            
        })
    }
}
