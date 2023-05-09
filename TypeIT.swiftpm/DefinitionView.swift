//
//  DefinitionView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/9/23.
//

import SwiftUI

struct DefinitionView: View {
    @State var definition = "A typeface is a visual depiction of a set of characters, including letters, numbers, and symbols"
    @State var text = ""
    @State var timer: Timer?
    @State var display1 = false
    @State var display2 = false
    @State var display3 = false
    @State var it = 0
    @Binding var stage: Stage
    var animation: Namespace.ID
    @Binding var completed: [Stage]
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                
                    HeadingView(title: "Typerface", colors: [.brown,.cyan], imageName: "character.phonetic")
                            .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                            .padding()
                       
                    
                   
                    Text(text)
                        .font(.custom("AmericanTypeWriter", size: 25))
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)

                    
                    VStack(alignment: .leading) {
                        
                        if display1 {
                            VStack(alignment: .leading) {
                                HeadingView(title: "Fonts", colors: [ .gray, .red], imageName: "textformat")
                                
                                Text("Fonts come in different styles, weights, and designs, and are commonly utilized for their aesthetic appeal.")
                                    .font(.custom("AmericanTypeWriter", size: 25))
                                    .fixedSize(horizontal: false, vertical: true)

                                    .padding()
                            }
                        }
                        if display2 {
                            VStack(alignment: .leading) {
                                
                                HeadingView(title: "Difference", colors: [ .blue, .green], imageName: "square.3.layers.3d.top.filled")
                              
                                
                                Text("Helvetica is a typeface")
                                    .font(.custom("AmericanTypeWriter", size: 25))
                                    .padding()
                                Text("Helvetica Bold is a font within the Helvetica typeface family.")
                                    .font(.custom("AmericanTypeWriter-Bold", size: 25))
                                    .fixedSize(horizontal: false, vertical: true)

                                    .padding()
                                Spacer()
                            }
                        }
                        //                    Spacer()
                    }.foregroundColor(.primary)
                    Spacer()
                    if display3 {
                        HStack {
                            Spacer()
                            RotatingButtonView(label: "arrow.right.circle") {
                                withAnimation {
                                    stage = .beforeApple
                                }
                            }

                        }
                        Spacer()
                    }
                    
                    
                    
                }
               
                Spacer()
            }
            
            .onAppear() {
                if !completed.contains(.definition) {
                    SpeechSynthesizer.speech(text: definition)
                }
                if completed.contains(.definition) {
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
            }
        }
    }
    func updateCounting() {
        if(!self.definition.isEmpty) {
//            withAnimation(.interactiveSpring()) {
                self.text.append(String(definition.removeFirst() ))
            if it%3 == 0 {
//                playSound()
            }
            it+=1
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
            if !completed.contains(.definition) {
                completed.append(.definition)
            }
        }
    }
}

