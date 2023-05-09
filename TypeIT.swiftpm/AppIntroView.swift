//
//  AppIntroView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/9/23.
//

import SwiftUI

struct AppIntro: View {
    @State var definition = "While sharing text using social media applications, the text editors doesn't support different fonts, color and size.\n\nWrong typeface can lead to poor readability and lack of impact"
    @State var text = ""
    @State var timer: Timer?
    @State var display1 = false
    @State var display2 = false
    @State var display3 = false
    @Binding var stage: Stage
    @Binding var completed: [Stage]

    @State var it = 0
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack(alignment: .leading) {
                LinearGradient(
                    colors: [.brown,.cyan],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).mask {
                    Text("Sharing Text")
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
                            HStack{
                                LinearGradient(
                                    colors: [ .blue, .green],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ).mask {
                                    HStack {
                                        Image(systemName: "text.bubble")
                                        Text("Text Maker")
                                            .padding()
                                            .font(.custom("AmericanTypeWriter", size: 25))
                                        Spacer()
                                    }
                                    
                                   
                                    
                                    
                                }.frame(height: 50)
                                NavigationLink {
                                    CustomisedtextView()
                                } label: {
                                    Text("Open")
                                        .font(.headline)
                                        .foregroundColor(.mint)
                                        .padding(7)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: CGFloat(10))
                                                .stroke(Color.mint, style: StrokeStyle(lineWidth: CGFloat(2), dash: []))
                                        ).padding()                               
                                    
                                }
                            }
                            Text("write text in variety of fonts and share as a image")
                                .font(.custom("AmericanTypeWriter", size: 25))
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                        }
                    }
                    if display2 {
                        VStack(alignment: .leading) {
                            HStack{
                                LinearGradient(
                                    colors: [ .blue, .green],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ).mask {
                                    HStack {
                                        Image(systemName: "text.below.photo")
                                        Text("Caption Maker")
                                            .font(.custom("AmericanTypeWriter", size: 25))
                                            .padding()
                                        Spacer()
                                    }
                                }.frame(height: 50)
                                NavigationLink {
                                    CollageMakerVIew()
                                } label: {
                                    Text("Open")
                                        .font(.headline)
                                        .foregroundColor(.mint)
                                        .padding(7)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: CGFloat(10))
                                                .stroke(Color.mint, style: StrokeStyle(lineWidth: CGFloat(2), dash: []))
                                        ).padding()                               
                                    
                                }
                            }
                           
                            Text("Make a collage of images and write a caption. Share your work as a image.")
                                .font(.custom("AmericanTypeWriter", size: 25))
                                .fixedSize(horizontal: false, vertical: true)

                                .padding()
                            Spacer()
                        }
                    }
                    if display3 {
                        HStack {
                            RotatingButtonView(label: "arrow.left.circle", action: {
                                withAnimation {
                                    stage = .proportionalFaced
                                }
                            })
                            Spacer()
                            
                        }.padding()
                        Spacer()
                    }
//                    Spacer()
                }.foregroundColor(.primary)
            }
           Spacer()
        }
        
        .onAppear() {
            SpeechSynthesizer.speech(text: definition)
            if completed.contains(.appintro) {
                display1 = true
                display2 = true
                display3 = true
            } else {
                timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true, block: { _ in
                    updateCounting()
                })
            }
        }
    }
    func updateCounting() {
        if(!self.definition.isEmpty) {
                self.text.append(String(definition.removeFirst() ))
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
            if !completed.contains(.appintro) {
                completed.append(.appintro)
            }
        }
    }
}
