//
//  ProportionalFacedView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/8/23.
//

import SwiftUI
import AudioUnit
import AVFoundation
var player: AVAudioPlayer?

func playSound() {
   
    print("clm")
   
    guard let audioData = NSDataAsset(name: "beep")?.data else {
            fatalError("Unable to find asset \("beep")")
         }
    do {
        player = try AVAudioPlayer(data:  audioData)
        player?.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}

struct ProportionalFacedView: View {
    @State var definition = "In late 1980s, Apple contributed in developing TrueType fonts which is a scalable font solution"
    @State var text = ""
    @State var timer: Timer?
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
                        Text("Apple's contribution to TYPEFACE")
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
                                        Image(systemName: "text.bubble")
                                        Text("TrueType Fonts")
                                            .padding()
                                            .font(.custom("AmericanTypeWriter", size: 25))
                                            .fixedSize(horizontal: false, vertical: true)
                                        
                                        Spacer()
                                        
                                    }
                                }.frame(height: 50)
                                Text("TrueType is a font technology that enables fonts to be resized without quality loss")
                                    .font(.custom("AmericanTypeWriter", size: 25))
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                    .padding()
                                    .padding()
//                                allowing text to be displayed in any size without becoming pixelated or jagged
                                
                               
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
                                        Image(systemName: "building.fill")
                                        Text("City Names")
                                            .font(.custom("AmericanTypeWriter", size: 25))
                                            .fixedSize(horizontal: false, vertical: true)
                                            .padding()
                                        Spacer()
                                    }
                                }.frame(height: 50)
//
//
//
                                Text("The practice of naming fonts after cities is thought to have started with the release of the font \"Chicago\" by Apple in 1984")
                                    .font(.custom("AmericanTypeWriter", size: 25))
                                    .fixedSize(horizontal: false, vertical: true)

                                    .padding()
//                                Text("In 2015, Apple launched the San Francisco typeface and began using it across all of its devices")
//                                    .font(.custom("AmericanTypeWriter", size: 25))
//                                    .fixedSize(horizontal: false, vertical: true)
//                                    .padding()
//                                Spacer()
                            }
                        }
                                            Spacer()
                    }.foregroundColor(.primary)
                    Spacer()
                    if display3 {
                        HStack {
                            RotatingButtonView(label: "arrow.left.circle") {
                                withAnimation {
                                    stage = .examplebit
                                }
                            }
                            Spacer()
                            RotatingButtonView(label: "arrow.right.circle") {
                                withAnimation {
                                    stage = .examplesent
                                }
                                
                            }
                        }
                        Spacer()
                    }
                    
                    
                    
                }
              
                Spacer()
            }
            
            .onAppear() {
                if !completed.contains(.proportionalFaced) {
                    SpeechSynthesizer.speech(text: "In late 1980s, Apple contributed in developing TrueType fonts, which is a scalable font solution")
                }
                
                if completed.contains(.proportionalFaced) {
                    display1 = true
                    display2 = true
                    display3 = true
                    text = definition
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
            if !completed.contains(.proportionalFaced) {
                completed.append(.proportionalFaced)
            }
        }
    }
}

