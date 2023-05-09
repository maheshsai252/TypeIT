//
//  CaptionGenerator.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/9/23.
//

import SwiftUI

struct CaptionGenerator: View {
    @Binding var text: String
    @Binding var html: Bool
    @Binding var selectedFont: String
    @Binding var color: Color
    @Binding var bgcolor: Color
    @Binding var size: Int
    @Binding var lineWidth: Int
    @Binding var borderRadius: Int
    @Binding var borderColor: Color
    @Binding var sizeString: String
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack {
                Text("Caption")
                    .font(.headline)
                    .foregroundColor(.mint)
                Spacer()
                
            }
            VStack(alignment: .center, content: {
                TextField("caption", text: $text)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: CGFloat(10))
                            .stroke( LinearGradient(
                                colors: [.red, .blue, .green, .yellow],
                                startPoint: .leading,
                                endPoint: .trailing
                            ), style: StrokeStyle(lineWidth: CGFloat(5), dash: []))
                    )
                    .padding([.leading,.top,.trailing])
//                            .frame(height: 400)
               
            })
            
        })
        VStack(alignment: .leading, content: {
            Text("Text Style")
                .font(.headline)
                .foregroundColor(.cyan)

            FontSectionView(selectedFont: $selectedFont, color: $color, bgcolor: $bgcolor, size: $size, sizeString: $sizeString, fontrange: 0...20)
        })
        VStack(alignment: .leading, content: {
            Text("Border style")
                .font(.headline)
                .foregroundColor(.mint)

            BorderStyleSelector(color: $borderColor, borderRadius: $borderRadius, lineWidth: $lineWidth)
        })
        
    }
}

