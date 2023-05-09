//
//  EntranceView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/8/23.
//

import SwiftUI
enum Stage {
    case title, definition, beforeApple, examplesent, examplebit, proportionalFaced, appintro
}
struct EntranceView: View {
    @Namespace private var animation
    @State var completed: [Stage] = []
    @State var currentStage: Stage = .title
    var body: some View {
        VStack {
            switch currentStage {
            case .title:
                TittleCardView(stage: $currentStage, animation: animation)
            case .definition:
                DefinitionView(stage: $currentStage, animation: animation, completed: $completed)
            case .beforeApple:
                BeforeAppleView(stage: $currentStage, completed: $completed)
            case .examplesent:
                ExampleSentimentView(stage: $currentStage, completed: $completed)
            case .examplebit:
                BitmapExampleView(stage: $currentStage, completed: $completed)
            case .proportionalFaced:
                ProportionalFacedView(stage: $currentStage, completed: $completed)
            case .appintro:
                AppIntro(stage: $currentStage, completed: $completed)
            }
    
        } .padding()
            .overlay(
                RoundedRectangle(cornerRadius: CGFloat(10))
                    .stroke( LinearGradient(
                        colors: [.red, .blue, .green, .yellow],
                        startPoint: .leading,
                        endPoint: .trailing
                    ), style: StrokeStyle(lineWidth: CGFloat(5), dash: []))
            ).padding()
    }
}

struct TittleCardView: View {
    @Binding var stage: Stage
    @State var text = ""
    @State var word = "TypeIT"
    @State var timer: Timer?
    @State var scale = 1
    var animation: Namespace.ID

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
                    .font(.custom("AmericanTypeWriter", size: 40))
                    .multilineTextAlignment(.center)
                    .scaleEffect(CGFloat(scale), anchor: .center)
            )
            .matchedGeometryEffect(id: "AlbumTitle", in: animation)
        }.onAppear() {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
                    updateCounting()
                })
        }
    }
    func updateCounting() {
        if(!self.word.isEmpty) {
            withAnimation(.interactiveSpring(response: 0.1, dampingFraction: 0.5, blendDuration: 0.5)) {
                self.text.append(String(word.removeFirst() ))
            }
            
        } else if(scale == 1) {
            scale = 2
        } else {
            self.timer?.invalidate()
//            withAnimation(.easeOut) {
                stage = .definition
//            }
        }
    }
}
struct EntranceView_Previews: PreviewProvider {
    static var previews: some View {
        EntranceView()
    }
}
