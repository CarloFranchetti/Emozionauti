//
//  GifView.swift
//  Emozionauti
//
//  Created by Studente on 10/07/25.
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String
    
    init(_ name: String){
        self.name = name;
    }
    
    func makeUIView(context: Context) -> WKWebView{
        let webView = WKWebView()
        if let urlString = Bundle.main.url(forResource: name , withExtension: "gif"){
            do{
               let image = try (Data(contentsOf: urlString))
                webView.load(
                    image,
                    mimeType: "image/gif",
                    characterEncodingName: "UTF-8",
                    baseURL: urlString.deletingLastPathComponent()
                )
            }catch{
                print("Errore di caricametìnto GIF")
            }
           
        }
        
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
    typealias UIViewType = WKWebView

}
