//
//  CustomisedPickerView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/4/23.
//

import SwiftUI

struct CustomisedFontPickerView: View {
    @State var fontsByFamily = Options.getFonts()
    @Binding var pickedFont: String
    @State var search = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            //            TextField("search for font", text: $search)
            //                .textFieldStyle(.roundedBorder)
            //                .padding()
            VStack(alignment: .leading) {
                
                
                Text("Selected Font - \(pickedFont)")
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.leading,.top])
                List {
                    
                    ForEach(fontsByFamily.sorted(by: {$0.key<$1.key}), id: \.key) {(family, fonts) in
                        Section(family) {
                            ForEach(search.isEmpty ? fonts : fonts.filter({$0.fontName.localizedCaseInsensitiveContains(search)}), id: \.self) {font in
                                HStack{
                                    Text(font.fontName)
                                        .onTapGesture {
                                            pickedFont = font.fontName
                                            dismiss()
                                        }
                                    Spacer()
                                    if font.fontName == pickedFont {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                        
                    }
                }
                .listStyle(.inset)
                .navigationTitle(SwiftUI.Text("Select Font"))
            }.searchable(text: $search)
                .toolbar {
                    ToolbarItem {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                                .foregroundColor(.white)
                        }

                    }
                }
        }
    }
}

