//
//  MarkdownGuideView.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/6/23.
//

import SwiftUI
extension AttributedString {
    init(styledMarkdown markdownString: String) throws {
        var output = try AttributedString(
            markdown: markdownString,
            options: .init(
                allowsExtendedAttributes: true,
                interpretedSyntax: .full,
                failurePolicy: .returnPartiallyParsedIfPossible
            ),
            baseURL: nil
        )

        for (intentBlock, intentRange) in output.runs[AttributeScopes.FoundationAttributes.PresentationIntentAttribute.self].reversed() {
            guard let intentBlock = intentBlock else { continue }
            for intent in intentBlock.components {
                switch intent.kind {
                case .header(level: let level):
                    switch level {
                    case 1:
                        output[intentRange].font = .system(.title).bold()
                    case 2:
                        output[intentRange].font = .system(.title2).bold()
                    case 3:
                        output[intentRange].font = .system(.title3).bold()
                    default:
                        break
                    }
                default:
                    break
                }
            }
            
            if intentRange.lowerBound != output.startIndex {
                output.characters.insert(contentsOf: "\n", at: intentRange.lowerBound)
            }
        }

        self = output
    }
}
struct MarkdownGuideView: View {
    var body: some View {
        NavigationView {
            
            
            ScrollView {
                VStack(alignment: .leading) {
                    MarkdownSection(heading: "Line Breaks" , content: "To create a line break or new line (<br>), end a line with two or more spaces, and then type return.", example: """
                    The hfh
                    kfk
                    """)
                    MarkdownSection(heading: "Bold" , content: "To bold text, add two asterisks or underscores before and after a word or phrase. To bold the middle of a word for emphasis, add two asterisks without spaces around the letters.", example: "I just love **bold text**.")
                    MarkdownSection(heading: "Italic" , content: "To italicize text, add one asterisk or underscore before and after a word or phrase. To italicize the middle of a word for emphasis, add one asterisk without spaces around the letters.", example: "Italicized text is the _cat's meow_")
                    MarkdownSection(heading: "Blockquotes" , content: "To create a blockquote, add a > in front of a paragraph.", example: "> Dorothy followed her through many of the beautiful rooms in her castle.")
                    
                    MarkdownSection(heading: "Ordered Lists" , content: "To create an ordered list, add line items with numbers followed by periods. The numbers don’t have to be in numerical order, but the list should start with the number one.", example: """
1. First item
2. Second item
3. Third item
4. Fourth item
""")
                    MarkdownSection(heading: "UnOrdered Lists" , content: "To create an unordered list, add dashes (-), asterisks (*), or plus signs (+) in front of line items. Indent one or more items to create a nested list.", example: """
                           # Heading 1 (Largest)
                           * Heading 2
                           * Heading 3
""")
                    MarkdownSection(heading: "Code" , content: "To denote a word or phrase as code, enclose it in backticks (`).", example: """
                                At the command prompt, type `nano`.
                                """)
                    
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Maarkdown Guide"))
        }
    }
}

struct MarkdownSection: View {
    var heading: String
    var content: String
    var example: String
    let html = "<ul><li>Heading</li></ul> <p>paragraph.</p>"
    var body: some View {
        VStack(alignment: .leading) {
            Text(heading)
                .bold()
            Text(content)
                .padding(5)
            VStack(alignment: .leading) {
                Text("Text:").bold()
                
                Text(example).padding()
                Text("Result:").bold()
                Text(LocalizedStringKey(stringLiteral: example))
                    .padding()
                
            }.padding()
                    
            
        }.padding(5)
    }
}
struct MarkdownGuideView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownGuideView()
    }
}
