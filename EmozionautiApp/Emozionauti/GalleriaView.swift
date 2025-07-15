//
//  GalleriaView.swift
//  Emozionauti
//
//  Created by Studente on 10/07/25.
//
import SwiftUI

struct DrawingGalleryView: App {
    @StateObject var dataModel = DataModel()
    
    var body: some Scene {
        WindowGroup{
            NavigationStack{
                GridView()
            }
            .environmentObject(dataModel)
            .navigationViewStyle(.stack)
        }
    }
}
