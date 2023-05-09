//
//  BeforeAppleView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/8/23.
//

import SwiftUI



struct BeforeAppleView: View {
    @State var definition = "Monospaced and proportional fonts are two distinct styles of fonts"
    @State var text = ""
    @State var timer: Timer?
    @State var timer2: Timer?

    @State var display1 = false
    @State var display2 = false
    @State var display3 = false
    @State var it = 0
    @Binding var stage: Stage
    @Binding var completed: [Stage]

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
                        Text("Font Styles")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.custom("AmericanTypeWriter", size: 25))
                    }.frame(height: 60)
                  
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
                                        Image(systemName: "diamond.tophalf.filled")
                                        Text("Monospaced Font")
                                            .padding()
                                            .font(.custom("AmericanTypeWriter", size: 25))
                                            .fixedSize(horizontal: false, vertical: true)
                                        
                                        Spacer()
                                        
                                    }
                                }.frame(height: 50)
                                
                                
                                
                                
                                Text("In a monospaced font, each character has a fixed and uniform width.")
                                    .font(.headline.monospaced())
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
                                        Image(systemName: "fossil.shell.fill")
                                        Text("Proportional font")
                                            .font(.custom("AmericanTypeWriter", size: 25))
                                            .fixedSize(horizontal: false, vertical: true)
                                        
                                            .padding()
                                        Spacer()
                                    }
                                }.frame(height: 50)
                                
                                
                                
                                Text("Proportional fonts are typefaces in which each character can have a distinct width")
                                    .font(.custom("AmericanTypeWriter", size: 25))
                                    .padding()
                                Spacer()
                            }
                        }
                        //                    Spacer()
                    }.foregroundColor(.primary)
                    Spacer()
                    if display3 {
                        HStack {
                            RotatingButtonView(label: "arrow.left.circle") {
                                withAnimation {
                                    stage = .definition
                                }
                            }
                            Spacer()
                            RotatingButtonView(label: "arrow.right.circle") {
                                withAnimation {
                                    stage = .examplebit
                                }
                               
                            }
                        }
                        Spacer()
                    }
                    
                    
                    
                }
               
                Spacer()
            }
            
            .onAppear() {
                if !completed.contains(.beforeApple) {
                    SpeechSynthesizer.speech(text: definition)
                }
                if completed.contains(.beforeApple) {
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
//        current = fontsEmoji.keys.randomElement() ?? "Roched"
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
            if !completed.contains(.beforeApple) {
                completed.append(.beforeApple)
            }
        }
    }
}



