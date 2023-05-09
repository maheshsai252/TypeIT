//
//  ExampleSentimentView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/9/23.
//

import SwiftUI

struct ExampleSentimentView: View {
    @State var definition = "Tpeface can influence the way a message is perceived and interpreted by the reader"
    @State var text = ""
    @State var timer: Timer?
    @State var timer2: Timer?

    @State var display1 = false
    @State var display2 = false
    @State var display3 = false
    @State var it = 0
    @Binding var stage: Stage
    @Binding var completed: [Stage]

    var fontsEmoji = ["Roched" : "😑", "SF-Bold": "🤨","Anmark": "😯","newyork": "🤔"]
    @State var current  = "Roched"
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                    
                    LinearGradient(
                        colors: [.brown,.cyan],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ).mask {
                        Text("Typeface Influence")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.custom("AmericanTypeWriter", size: 25))
                    }.frame(height: 60)
//                    VStack {
//                        Text("Drinking water is good for health")
//                            .font(.custom(current, size: 30))
//                        Text(fontsEmoji[current] ?? "")
//                            .font(.custom(current, size: 50))
//                            .padding()
//                    }
                    Text(text)
                        .font(.custom("AmericanTypeWriter", size: 25))
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    
                        .padding()
                    VStack(alignment: .leading) {
                        
                        if display1 {
                            VStack(alignment: .leading) {
                                
                                LinearGradient(
                                    colors: [ .blue, .green],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ).mask {
                                    HStack{
                                        Image(systemName: "lineweight")
                                        Text("size, spacing, and color")
                                            .padding()
                                            .font(.custom("AmericanTypeWriter", size: 25))
                                            .fixedSize(horizontal: false, vertical: true)
                                        
                                        Spacer()
                                        
                                    }
                                }.frame(height: 50)
                                Text("Large, bold fonts can convey a sense of urgency,excitement or importance")
                                    .font(.custom("AmericanTypeWriter-Bold", size: 25))
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                    .padding()
                                Text("Smaller, Lighter fonts can suggest calm, subtlety or delicacy")
                                    .font(.custom("AmericanTypeWriter-CondensedLight", size: 20))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding()
                            }
                        }
                        if display2 {
                            VStack(alignment: .leading) {
                                
                                LinearGradient(
                                    colors: [ .blue, .green],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ).mask {
                                    HStack {
                                        Image(systemName: "paintpalette")
                                        Text("Font Choice")
                                            .font(.custom("AmericanTypeWriter", size: 25))
                                            .fixedSize(horizontal: false, vertical: true)
                                        
                                            .padding()
                                        Spacer()
                                    }
                                }.frame(height: 50)
                                
                                
                                
                                Text("The choice of font can impact the tone and style of a message")
                                    .font(.custom("AmericanTypeWriter", size: 25))
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                    .padding()
                                
                                
                                Spacer()
                            }
                        }
                        //                    Spacer()
                    }.foregroundColor(.primary)
                    
                    Spacer()
                    if display3 {
                        VStack(alignment: .leading) {
                            LinearGradient(
                                colors: [ .blue, .green],
                                startPoint: .leading,
                                endPoint: .trailing
                            ).mask {
                                HStack {
                                    Image(systemName: "circle.hexagongrid")
                                    Text("Example")
                                        .font(.custom("AmericanTypeWriter", size: 25))
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                        .padding()
                                    Spacer()
                                }
                            }.frame(height: 50)
                            Text("A serif font such as Times New Roman is often associated with traditional and formal communication\n\nA sans-serif font such as Arial or Helvetica is often perceived as more modern and informal")
                                .font(.custom("AmericanTypeWriter", size: 25))
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                        }
                        HStack {
                            RotatingButtonView(label: "arrow.left.circle") {
                                withAnimation {
                                    stage = .proportionalFaced
                                }
                            }
                            Spacer()
                            RotatingButtonView(label: "arrow.right.circle") {
                                withAnimation {
                                    stage = .appintro
                                }
                                
                            }
                        }.padding()
                        Spacer()
                    }
                    
                    
                    
                }
             
                Spacer()
            }
            
            .onAppear() {
                if !completed.contains(.examplesent) {
                    SpeechSynthesizer.speech(text: "Tpeface can influence the way a message is perceived and interpreted by the reader. Large and bold fonts can convey a sense of urgency,excitement or importance. Smaller and Lighter fonts can suggest calm, subtlety or delicacy")
                }
                if completed.contains(.examplesent) {
                    withAnimation(.easeIn(duration: 2)) {
                        text = definition
                        display1 = true
                        display2 = true
                        display3 = true
                    }
                } else {
                    timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true, block: { _ in
                        updateCounting()
                    })
                }
                timer2 = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
                    updateemoji()
                })
            }
        }
    }
    func updateemoji() {
        current = fontsEmoji.keys.randomElement() ?? "Roched"
    }
    func updateCounting() {
        if(!self.definition.isEmpty) {
//            withAnimation(.interactiveSpring()) {
                self.text.append(String(definition.removeFirst() ))
           
//            }
        } else if !display1 {
            withAnimation(.easeIn(duration: 2)) {
                display1 = true
            }
            
        } else if !display2 {
            withAnimation(.easeIn(duration: 4)) {
                display2 = true
            }
            
        } else if !display3 {
            withAnimation(.easeIn(duration: 6)) {
                display3 = true
            }
        } else {
            self.timer?.invalidate()
            if !completed.contains(.examplesent) {
                completed.append(.examplesent)
            }
        }
    }
}


