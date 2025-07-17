//
//  VideoPlayerView.swift
//  Emozionauti
//
//  Created by Studente on 17/07/25.
//

import SwiftUI
import AVKit
struct VideoPlayerView: UIViewControllerRepresentable {
    let videoName: String
    let videoType:String="mp4"
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        if let path = Bundle.main.path(forResource: videoName, ofType: videoType) {
            let player = AVPlayer(url:URL(fileURLWithPath: path))
            controller.player=player
            controller.showsPlaybackControls=false
            player.play()
        }
        else {
            print("Video not found")
        }
        return controller
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
            
    }
}

