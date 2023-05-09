//
//  CaptionOutputview.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/9/23.
//

import SwiftUI
import Combine

struct GridCaption: View {
    var cols: Int
    var rows: Int
    var fulldic: [Int: UIImage]
    var body: some View {
        Grid {
            ForEach(0..<rows, id: \.self) {r in
                GridRow {
                    ForEach(0..<cols, id: \.self) {c in
//                            Text("\(r*(cols) + c+1)")
                        if let uiimage = fulldic[r*(cols) + c+1] {
                            Image(uiImage: uiimage)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
        }
    }
}

struct CaptionOutputview: View {
    var cols: Int
    var rows: Int
    var rc: Int = 0
    var fulldic: [Int: UIImage]
    @State var display: Bool = true
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    @State var connectedTimer: Cancellable? = nil
    let durationAndDelay : CGFloat = 0.1
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var stop = false
    @Binding var text: String
    @Binding var html: Bool
    @Binding var selectedFont: String
    @Binding var color: Color
    @Binding var bgcolor: Color
    @Binding var size: Int
    @Binding var lineWidth: Int
    @Binding var borderRadius: Int
    @Binding var borderColor: Color
    @State var alert = false
    @State var itemsToShare: [Any] = []
    @State var showSheet = false
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                bgcolor
                VStack{ 
                    if showSheet {
                    ActivityViewController(itemsToShare: $itemsToShare, showing: $showSheet)
                        .frame(width: 0, height: 0)
                    }
                    ZStack {
                        GridCaption(cols: cols, rows: rows, fulldic: fulldic)
                            .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0, y: 1, z: 0))
                        GridCaption(cols: cols, rows: rows, fulldic: fulldic)
                            .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))
                    }.alert("Wrong input", isPresented: $alert) {
                        Button {
                            alert = false
                        } label: {
                            Text("Ok")
                        }
                    }
                   
                    Text(LocalizedStringKey(text))
                        .background(bgcolor)
                        .font(.custom(selectedFont, size: CGFloat(size)))
                        .foregroundColor(color)
                        .padding(5)
                        .fixedSize(horizontal: false, vertical: true)
                        .overlay(
                            RoundedRectangle(cornerRadius: CGFloat(borderRadius))
                                .stroke(borderColor, style: StrokeStyle(lineWidth: CGFloat(lineWidth), dash: []))
                        ).padding(7)
                }
            }
            
//            OutputTextView(text: $text, html: $html, selectedFont: $selectedFont, color: $color, bgcolor: $bgcolor, size: $size, lineWidth: $lineWidth, borderRadius: $borderRadius, borderColor: $borderColor)
            
        }.toolbar {
            ToolbarItem {
                Button {
                    if fulldic.isEmpty {
                        alert = true
                        return
                    }
                    self.restartTimer()
                    stop = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
                        stop = true
                        generate()
                    })
                    
                } label: {
                    Image(systemName: !display ?  "" : "square.and.arrow.up" )
                }
            }
        }  .onReceive(timer, perform: { _ in
            flipCard()
            
            if stop {
                self.cancelTimer()
                
            }
        })
    }
    @MainActor func generate() {
        display = false
//        let renderer = ImageRenderer(content: self)
//        renderer.scale = 1
        let view = CaptionOutputview(cols: cols, rows: rows, rc: rc, fulldic: fulldic, display: display, backDegree: backDegree, frontDegree: frontDegree, isFlipped: isFlipped, connectedTimer: nil, timer: timer, stop: stop, text: .constant(text), html: .constant(false), selectedFont: .constant(selectedFont), color: .constant(color), bgcolor: .constant(bgcolor), size: .constant(size), lineWidth: .constant(lineWidth), borderRadius: .constant(borderRadius), borderColor: .constant(borderColor), alert: false, itemsToShare: [], showSheet: false)
        let renderer = ImageRenderer(content: view)
        renderer.scale = 2
        if let image = renderer.uiImage {
            itemsToShare = [image]
            showSheet = true
        }
        if let image = renderer.uiImage {
            let activityViewController:UIActivityViewController = UIActivityViewController(activityItems:  [image], applicationActivities: nil)
            activityViewController.excludedActivityTypes = [.postToVimeo]
            UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        }
        display = true
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
               withAnimation(.easeOut(duration: durationAndDelay)) {
                   backDegree = 90
               }
               withAnimation(.easeOut(duration: durationAndDelay).delay(durationAndDelay)){
                   frontDegree = 0
               }
           } else {
               withAnimation(.easeOut(duration: durationAndDelay)) {
                   frontDegree = 360
               }
               withAnimation(.easeOut(duration: durationAndDelay).delay(durationAndDelay)){
                   backDegree = 0
               }
           }
       }
}


