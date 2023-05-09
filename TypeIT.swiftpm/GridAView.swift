//
//  GridAView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/7/23.
//

import SwiftUI



struct BitmapExampleView: View {

    @State var text = "Scaling fonts to different sizes while preserving their style"
    @State var timer: Timer?
    @State var timer2: Timer?
    @State var fills:[Int] = []
    @State var actual: [Int] = [21,16,11,12,13,18,23,17]
    @State var display1 = false
    @State var display2 = false
    @State var display3 = false
    @State var it = 0
    @Binding var stage: Stage
    @Binding var completed: [Stage]
    var order = ["A-small","A-Medium","A-Large", "C-small", "C-Medium","C-Large"]
    var fontsEmoji = ["A-small" : [21,16,11,12,13,18,23,17], "A-Medium" : [21,16,11,6,7,8,13,18,23,17], "A-Large" : [21,16,11,6,1,2,3,8,13,18,23,12], "C-small": [13,12,11,16,21,22,23], "C-Medium": [8,7,6,11,16,21,22,23], "C-Large": [3,2,1,6,11,16,21,22,23]]
    @State var current  = 0
    @State var filling = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Spacer()
                VStack {
                    
                    LinearGradient(
                        colors: [.brown,.cyan],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ).mask {
                        Text("Scaling characters")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.custom("AmericanTypeWriter", size: 25))
                    }.frame(height: 60)
                        .padding()
                    Spacer()
                    if let i = self.fontsEmoji.firstIndex(where: {$0.key == order[self.current]}) {
                        Text(self.fontsEmoji.keys[i])
                            .font(.largeTitle)
                    }
                    
                    Grid {
                        ForEach(0..<5, id:\.self) { r in
                            GridRow {
                                ForEach(0..<5, id:\.self) { c in
                                    if fills.contains(5*r+c) {
                                        Rectangle()
                                            .fill(Color.cyan)
                                            .border(Color.black )
                                            .frame(width: 50,height: 50)
                                    } else {
                                        Rectangle()
                                            .fill(Color.gray)
                                            .border(Color.blue)
                                            .frame(width: 50,height: 50)
                                    }
                                }
                            }
                        }
                    }
                    HStack{
                        Image(systemName: "a.magnify")
                        Text("Problem till 1980s")
                            .font(.custom("AmericanTypeWriter", size: 25))
                        Spacer()
                        
                    }
                    .foregroundColor(.red)
                    .padding()
                    
                    Text(text)
                        .font(.custom("AmericanTypeWriter", size: 25))
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                    
                    if display3 {
                        HStack {
                            RotatingButtonView(label: "arrow.left.circle") {
                                withAnimation {
                                    stage = .beforeApple
                                }
                            }
                            Spacer()
                            RotatingButtonView(label: "arrow.right.circle") {
                                withAnimation {
                                    stage = .proportionalFaced
                                }
                                
                            }
                        }.padding()
                        Spacer()
                    }
                    
                    
                    
                }
             
                Spacer()
            }
            
            .onAppear() {
                if !completed.contains(.examplebit) {
                SpeechSynthesizer.speech(text: "Scaling fonts to different sizes while preserving their style is a biggest problem till 1980")
                }
                if completed.contains(.examplebit) {
                    withAnimation(.easeIn(duration: 2)) {
                        
                        display3 = true
                    }
                }
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
                    updateCounting()
                })
                timer2 = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { _ in
                    updateemoji()
                })
                if !completed.contains(.examplebit) {
                    completed.append(.examplebit)
                }
            }
        }
    }
    func updateemoji() {
        if !filling {
            
            if self.current < self.order.count-1 {
                self.current+=1
            } else {
                self.current = 0
            }
            if let i = self.fontsEmoji.firstIndex(where: {$0.key == order[self.current]}) {
                print(self.fontsEmoji.keys)
                print(self.current)
                print(self.fontsEmoji.keys[i])
                self.actual = self.fontsEmoji[self.fontsEmoji.keys[i]] ?? [21,16,11,6,1,2,3,8,13,18,23,12]
            }
            print("updated actual")
        }
    }
    func updateCounting() {
        if(!self.actual.isEmpty) {
            self.filling = true
            self.fills.append(self.actual.removeFirst())
            
        }  else {
            self.fills = []
            self.filling = false
            display3 = true
            
        }
    }
}

