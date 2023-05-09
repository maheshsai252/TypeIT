//
//  OutputTextView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/6/23.
//

import WebKit
import SwiftUI

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

struct OutputTextView: View {
    @Binding var text: String
    @Binding var html: Bool
    @Binding var selectedFont: String
    @Binding var color: Color
    @Binding var bgcolor: Color
    @Binding var size: Int
    @Binding var lineWidth: Int
    @Binding var borderRadius: Int
    @Binding var borderColor: Color
    @State var attributedString: AttributedString = AttributedString("")
    var body: some View {
        ZStack {
            bgcolor
            VStack {
                Spacer()
                
                Text(LocalizedStringKey(text))
                    .background(bgcolor)
                    .font(.custom(selectedFont, size: CGFloat(size)))
                    .foregroundColor(color)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                    .overlay(
                        RoundedRectangle(cornerRadius: CGFloat(borderRadius))
                            .stroke(borderColor, style: StrokeStyle(lineWidth: CGFloat(lineWidth), dash: []))
                    ).padding()
                
                Spacer()
            }
        }
        
    }
}


