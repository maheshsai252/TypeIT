//
//  CollageMakerVIew.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/7/23.
//

import SwiftUI

struct CollageMakerVIew: View {
    @State var rows: Int = 3
    @State var rowString: String = "3"
    @State var cols: Int = 3
    @State var colsString: String = "3"
    @State var show = false
    @State var rc = 0
    @State var timer: Timer?
    
    var fontsByFamily = Options.getFonts()
    @State var fontPicker = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack{
                HStack{
                    Grid {
                        ForEach(0..<rows, id: \.self) { r in
                            GridRow {
                                ForEach(0..<cols, id: \.self) {c in
                                    Circle()
                                        .fill(rc == r+c ? Color.white : .mint)
                                        .frame(width: 5, height: 5)
                                }
                            }
                        }
                    }
                    Spacer()
                    LinearGradient(
                        colors: [.red, .blue, .green, .yellow],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .mask(
                        // 1
                        Text("Collage Maker")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                    ).frame(height: 60)
                    
                    Spacer()
                }.padding()
                Spacer()
                NumericalInput(size: $rows, sizeString: $rowString, range: 0...3, label: "number of rows")
                    .font(.headline)
                    .padding()
                NumericalInput(size: $cols, sizeString: $colsString, range: 0...3, label: "number of cols")
                    .font(.headline)
                    .padding()
                Spacer()
                Spacer()

                VStack{
                    HStack {
                        Spacer()
                        NavigationLink {
                            InputTakerView(rows: rows, cols: cols, grids: generateArray())
                        } label: {
                            Image(systemName: "arrow.right.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.mint)
                                .padding()
                        }
                    }
                   
                    
                }
                Spacer()
            }
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle(Text("Collage Maker"))
            .onAppear() {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                    if(rows*cols > 0){
                        rc = Int.random(in: 0..<rows*cols)
                    }
                })
            }
        }
        
        
    }
    func generateArray() -> [gridr] {
        var grids: [gridr] = []
        for _ in 0..<rows {
            var cos:[gridc] = []
            for _ in 0..<cols {
                cos.append(gridc())
            }
            
            grids.append(gridr(cols: cos))
        }
        return grids
    }
}

struct CollageMakerVIew_Previews: PreviewProvider {
    static var previews: some View {
        CollageMakerVIew(rows: 3, rowString: "3", cols: 3, colsString: "3")
    }
}
