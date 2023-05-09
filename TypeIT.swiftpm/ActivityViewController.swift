//
//  ActivityViewController.swift
//  wwdc23
//
//  Created by Mahesh sai on 4/12/23.
//

import SwiftUI

class UIActivityViewControllerHost: UIViewController {
    var itemsToShare: [Any] = []
    var completionWithItemsHandler: UIActivityViewController.CompletionWithItemsHandler? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        share()
    }
    
    func share() {
        // set up activity view controller
        
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)

        activityViewController.completionWithItemsHandler = completionWithItemsHandler
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    @Binding var itemsToShare: [Any]
    @Binding var showing: Bool
    
    func makeUIViewController(context: Context) -> UIActivityViewControllerHost {
        // Create the host and setup the conditions for destroying it
        let result = UIActivityViewControllerHost()
        
        result.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
            // To indicate to the hosting view this should be "dismissed"
            self.showing = false
        }
        
        return result
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewControllerHost, context: Context) {
        // Update the text in the hosting controller
        uiViewController.itemsToShare = itemsToShare
    }
    
}
