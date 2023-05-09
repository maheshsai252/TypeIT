//
//  CustomisedTextView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/1/23.
//

import SwiftUI
import UIKit
import Combine

struct Font: Comparable, Hashable {
    static func < (lhs: Font, rhs: Font) -> Bool {
        lhs.fontFamily < rhs.fontFamily
    }
    
    var fontFamily: String
    var fontName: String
}
struct Options {
    
    static func getFonts() -> [String: [Font]] {
        var fonts: [Font] = []
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            let current_fonts = fontNames.map { name in
                Font(fontFamily: familyName, fontName: name)
            }
            fonts.append(contentsOf: current_fonts)
        })
        return Dictionary(grouping: fonts, by: \Font.fontFamily)
    }
}
extension String {
    var isNumber: Bool {
        return self.range(
            of: "^[0-9]*$", // 1
            options: .regularExpression) != nil
    }
}
struct NumericalInput: View {
    @Binding var size: Int
    @Binding var sizeString: String
    var range: ClosedRange<Int>
    var label: String
    var body: some View {
        HStack(alignment: .center){
            Text("Select \(label)").bold()
            Spacer()
            Stepper("", value: $size, in: range, step: 1)
                .onChange(of: size) { newValue in
                    sizeString = "\(size)"
                }
            TextField("", text: $sizeString)
                .frame(width: 40)
                .padding(5)
                .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.primary, lineWidth: 2)
                    )
                .onChange(of: sizeString) {[sizeString] newValue in
                        print(sizeString,newValue)
                        
                        if let i = Int(newValue), range.contains(i) {
                            size = Int(newValue) ?? 0
                            self.sizeString = newValue
                        } else if newValue.isEmpty {
                            size = range.lowerBound
                            self.sizeString = "\(range.lowerBound)"
                        }
                        else {
                            self.sizeString = sizeString
                            
                        }
                   
                    
                }
            
        }.padding()
    }
}
struct BorderStyleSelector: View {
    @Binding var color: Color
    @Binding var borderRadius: Int
    @State var borderRadiusString = ""
    @Binding var lineWidth: Int
    @State var lineWidthString = ""
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Text("Select border  Color").bold()
                ColorPicker("", selection: $color)
            }.padding()
            NumericalInput(size: $borderRadius, sizeString: $borderRadiusString, range: 0...20, label: "border radius")
            NumericalInput(size: $lineWidth, sizeString: $lineWidthString, range: 0...10, label: "border width")
        }.onAppear() {
            borderRadiusString = String(borderRadius)
            lineWidthString = String(lineWidth)
        }
    }
}
struct FontSectionView: View {
    @Binding var selectedFont: String
    @State var fontPicker: Bool = false
    @Binding var color: Color
    @Binding var bgcolor: Color
    @Binding var size : Int
    @Binding var sizeString: String
    var fontrange: ClosedRange<Int>
    var body: some View {
        HStack(alignment: .center){
            Text("Select font").bold()
            Spacer()
            Text(selectedFont)
                .onTapGesture {
                    fontPicker = true
                }
        }.padding()
            .sheet(isPresented: $fontPicker) {
                CustomisedFontPickerView(pickedFont: $selectedFont)
            }
        HStack(alignment: .center){
            Text("Select text Color").bold()
            ColorPicker("", selection: $color)
        }.padding()
        HStack(alignment: .center){
            Text("Select Background Color").bold()
            ColorPicker("", selection: $bgcolor)
        }.padding()
        NumericalInput(size: $size, sizeString: $sizeString, range: fontrange, label: "font size")
    }
}

struct CustomisedtextView: View {
    @State var text = ""
    @State var fonts: [String] = []
    @State var selectedFont = "ArialMT"
    @State var color: Color = .white
    @State var bgcolor: Color = .black
    @State var size = 30
    @State var sizeString = "30"
    @State var lineWidth = 4
    @State var borderRadius = 10
    @State var borderColor: Color = .orange
    var fontsByFamily = Options.getFonts()
    @State var showGuide = false
    @State var fontPicker = false
    @State var html = false
    @State var backDegree = 0.0
       @State var frontDegree = -90.0
    @State var isFlipped = false
    @State var uiimage: UIImage?
    let durationAndDelay : CGFloat = 0.1
    @State var stop = false
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    @State var itemsToShare: [Any] = []
    @State var showSheet = false
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack {
                LinearGradient(
                    colors: [ .blue, .green],
                    startPoint: .leading,
                    endPoint: .trailing
                ).mask {
                    HStack{
                        Image(systemName: "text.bubble")
                        Text("Text Maker")
                            .padding()
                            .font(.custom("AmericanTypeWriter", size: 25))
                        
                    }
                }.frame(height: 50)
                
             
                if !text.isEmpty {
                    VStack {
                        HStack {
                            Text("OUTPUT")
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                self.restartTimer()
                                stop = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
                                    stop = true
                                    generate()
                                })
                            }, label: {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            })
                        }
                    }
                    
                    ZStack {
                        OutputTextView(text: $text, html: $html, selectedFont: $selectedFont, color: $color, bgcolor: $bgcolor, size: $size, lineWidth: $lineWidth, borderRadius: $borderRadius, borderColor: $borderColor)
                            .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0, y: 1, z: 0))
                        OutputTextView(text: $text, html: $html, selectedFont: $selectedFont, color: $color, bgcolor: $bgcolor, size: $size, lineWidth: $lineWidth, borderRadius: $borderRadius, borderColor: $borderColor)
                            .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))
                        
                    }
                }
               
                VStack(alignment: .leading, content: {
                    HStack {
                        Text("Text Editor")
                            .font(.headline)
                            .foregroundColor(.mint)
                        Spacer()
                        Button {
                            showGuide = true
                        } label: {
                            Image(systemName: "m.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                    }.sheet(isPresented: $showGuide) {
                        MarkdownGuideView()
                    }
                    VStack(alignment: .center, content: {
                        TextEditor(text: $text)
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: CGFloat(10))
                                    .stroke( LinearGradient(
                                        colors: [.red, .blue, .green, .yellow],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ), style: StrokeStyle(lineWidth: CGFloat(5), dash: []))
                            )
                            .padding([.leading,.top,.trailing])
                            .frame(height: 400)
                        Text("This editor supports markdown")
                            .font(.footnote).bold()
                            .padding(.bottom)
                    })
                    
                })
                if showSheet {
                    ActivityViewController(itemsToShare: $itemsToShare, showing: $showSheet)
                                    .frame(width: 0, height: 0)
                }
                VStack(alignment: .leading, content: {
                    Text("Text Style")
                        .font(.headline)
                        .foregroundColor(.cyan)

                    FontSectionView(selectedFont: $selectedFont, color: $color, bgcolor: $bgcolor, size: $size, sizeString: $sizeString, fontrange: 0...50)
                })
                VStack(alignment: .leading, content: {
                    Text("Border style")
                        .font(.headline)
                        .foregroundColor(.mint)

                    BorderStyleSelector(color: $borderColor, borderRadius: $borderRadius, lineWidth: $lineWidth)
                })
                
            }
        }
        .onReceive(timer, perform: { _ in
            flipCard()
            if stop {
                self.cancelTimer()
                
            }
        })
        .navigationBarTitleDisplayMode(.inline)
    }
    @MainActor func generate() {
        let view =  OutputTextView(text: .constant(text), html: .constant(true), selectedFont: .constant(selectedFont), color: .constant(color), bgcolor: .constant(bgcolor), size: .constant(size), lineWidth: .constant(lineWidth), borderRadius: .constant(borderRadius), borderColor: .constant(borderColor))
        let renderer = ImageRenderer(content: view)
        renderer.scale = 3
        if let image = renderer.uiImage {
            itemsToShare = [image]
            showSheet = true
        }
    }
    func instantiateTimer() {
           self.timer = Timer.publish(every: 1, on: .main, in: .common)
           self.connectedTimer = self.timer.connect()
           return
       }
       
       func cancelTimer() {
           self.connectedTimer?.cancel()
           return
       }
    func restartTimer() {
        
            self.cancelTimer()
            self.instantiateTimer()
            
        }
    func flipCard () {
        self.isFlipped.toggle()
        print(isFlipped)
           if isFlipped {
               withAnimation(.linear(duration: durationAndDelay)) {
                   backDegree = 90
               }
               withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                   frontDegree = 0
               }
           } else {
               withAnimation(.linear(duration: durationAndDelay)) {
                   frontDegree = 360
               }
               withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                   backDegree = 0
               }
           }
       }
}
struct CustomisedTextView_Previews: PreviewProvider {
    static var previews: some View {
        CustomisedtextView()
    }
}
