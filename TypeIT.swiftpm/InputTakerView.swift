//
//  InputTakerView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/7/23.
//

import SwiftUI

struct gridr: Identifiable,Hashable {
    var id: UUID = UUID()
    var cols: [gridc]
}

struct gridc: Identifiable,Hashable {
    var id: UUID = UUID()
}
struct ColoredLabelView: View {
    var label: String
    var body: some View {
        LinearGradient(
            colors: [.brown,.cyan],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).mask {
            Text(label)
                .fixedSize(horizontal: false, vertical: true)
                .font(.custom("AmericanTypeWriter", size: 25))
        }.frame(height: 60)
    }
}
struct InputTakerView: View {
    var rows: Int
    var cols: Int
    var grids: [gridr]
    @State var text = ""
    @State var fonts: [String] = []
    @State var selectedFont = "ArialMT"
    @State var color: Color = .white
    @State var bgcolor: Color = .black
    @State var size = 20
    @State var sizeString = "20"
    @State var lineWidth = 4
    @State var borderRadius = 10
    @State var borderColor: Color = .orange
    @State var add = false
    @State var fulldic: [Int: UIImage] = [:]
    @State var display = false
    var body: some View {
        ScrollView(showsIndicators: false) {
        VStack(alignment: .center) {

            VStack(alignment: .center) {
                    HStack {
                        Text( "Preview")
                            .font(.headline)
                            .foregroundColor(.mint).padding(5)
                        Spacer()
                        
                    }
                    CaptionOutputview(cols: cols, rows: rows, fulldic: fulldic, text: $text, html: .constant(false), selectedFont: $selectedFont, color: $color, bgcolor: $bgcolor, size: $size, lineWidth: $lineWidth, borderRadius: $borderRadius, borderColor: $borderColor)
                }
            VStack(alignment: .center) {
                HStack {
                    Text( "Input")
                        .font(.headline)
                        .foregroundColor(.cyan).padding(5)
                    Spacer()
                    
                }
                VStack {
                    Grid {
                        ForEach(0..<rows, id: \.self) {r in
                            GridRow {
                                ForEach(0..<cols, id: \.self) { c in
                                    ImageInGridView(rc: r*(cols) + c+1, fulldic: $fulldic)
                                }
                            }
                        }
                    }.padding()
                }
                CaptionGenerator(text: $text, html: .constant(false), selectedFont: $selectedFont, color: $color, bgcolor: $bgcolor, size: $size, lineWidth: $lineWidth, borderRadius: $borderRadius, borderColor: $borderColor, sizeString: $sizeString)
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(Text("Generating Input"))
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    display = false
//
//                } label: {
//                    Text("export")
//                }
//
//            }
//        }
    }
        
    }
}
extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}

struct ImageInGridView: View {
    @State var image: UIImage?
    @State var presentpicker = false
    var rc: Int
    @Binding var fulldic: [Int: UIImage]
    var body: some View {
//        NavigationView {
            VStack {
                VStack {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 100, height: 100)
                    } else {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 45, height: 45)
                    }
                }.onTapGesture {
                    presentpicker = true
                }
                .onChange(of: presentpicker) { newValue in
                    print(newValue)
                }
                .onChange(of: image) { newValue in
                    if let v = newValue {
                        fulldic[rc] = v
                }
                }
                
            }.sheet(isPresented: $presentpicker) {
                editimage(image: $image, presentpicker: $presentpicker)
                    .interactiveDismissDisabled()
            }
//        }
    }
}
struct editimage: View {
    @State var edit = false
    @Binding var image: UIImage?
    @State var present = false
    @Binding var presentpicker: Bool
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if let _ = image {
                        FullPhotoView(image: $image)
                    } else {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
                .onTapGesture {
                    present = true
                }
            }
            .sheet(isPresented: $present) {
                ImagePicker(image: $image)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentpicker = false
                    } label: {
                        Text("Done").font(.headline)
                    }
                }
            }
            
            
        }
    }
}

struct FullPhotoView: View {
    @Binding var image: UIImage?
    @GestureState var scale: CGFloat = 1
    @State var amount: CGFloat = 1

    @State var degrees: Double = 0
    @Environment(\.presentationMode) var pm
    var hide = false
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(amount)
//                    .rotationEffect(Angle(degrees: degrees))
                    .draggable()
                    .gesture(MagnificationGesture()
                                .updating($scale, body: { (value, scale, trans) in
                                    amount = value.magnitude
                                })

                    )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
            }
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    
                    image = image?.rotate(radians: -.pi/2)
                    degrees = (degrees + 90).truncatingRemainder(dividingBy: 360.0)
                } label: {
                    Image(systemName: "rotate.left")
                }
                Button {
                    image = image?.rotate(radians: .pi/2)
                    degrees = (degrees - 90).truncatingRemainder(dividingBy: 360.0)
                } label: {
                    Image(systemName: "rotate.right")
                }
            }
        }
        
    }
}
struct DraggableView: ViewModifier {
    @State var offset = CGPoint(x: 0, y: 0)
    
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let newx = self.offset.x + (value.location.x - value.startLocation.x)
                    let newy = self.offset.y + (value.location.y - value.startLocation.y)

                    if abs(newx) < UIScreen.main.bounds.width && abs(newy) < UIScreen.main.bounds.height/2 {
                        self.offset.x = newx
                        self.offset.y = newy
                    }
                    
            })
            .offset(x: offset.x, y: offset.y)
    }
}
extension View {
    func draggable() -> some View {
        return modifier(DraggableView())
    }
}
//if display {
//    HStack {
//        Text("Caption").font(.headline)
//        Spacer()
//        Button {
//            add = true
//        } label: {
//            Text("Add")
//        }
//    }.sheet(isPresented: $add) {
//        CaptionGenerator(text: $text, html: .constant(false), selectedFont: $selectedFont, color: $color, bgcolor: $bgcolor, size: $size, lineWidth: $lineWidth, borderRadius: $borderRadius, borderColor: $borderColor, sizeString: $sizeString)
//    }
//
//}
//Text(LocalizedStringKey(text))
//    .font(.custom(selectedFont, size: CGFloat(size)))
//    .foregroundColor(color)
//    .padding()
//    .fixedSize(horizontal: false, vertical: true)
//    .overlay(
//        RoundedRectangle(cornerRadius: CGFloat(borderRadius))
//            .stroke(borderColor, style: StrokeStyle(lineWidth: CGFloat(lineWidth), dash: []))
//    ).padding()
