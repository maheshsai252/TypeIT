//
//  SpeechSynthesizer.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/14/23.
//

import SwiftUI
import AVFoundation


struct SpeechSynthesizer {
    static let synthesizer = AVSpeechSynthesizer()
    static func speech(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5
        
        
        SpeechSynthesizer.synthesizer.speak(utterance)
    }
}

// en-us : 0.001

// en-GB: 0.5
