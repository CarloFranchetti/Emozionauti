//
//  CanvasView.swift
//  Emozionauti
//
//  Created by Studente on 07/07/25.
//

import SwiftUI
import PencilKit
import UIKit
import Foundation
//@Model
class DesignModel {
    private var drawingData: Data
    var drawing: PKDrawing {
        get {
            (try? PKDrawing(data: drawingData)) ?? PKDrawing()
        }
        
        set {
            drawingData = newValue.dataRepresentation()
        }
    }
    
    init(drawingData: Data) {
        self.drawingData = drawingData
        
    }
    
    init(drawing: PKDrawing) {
        self.drawingData = drawing.dataRepresentation()
    }
    
    init() {
        drawingData = Data()
    }
}
extension PKDrawing {
    
    func saveToPhotoLibrary() {
        // Generate a UIImage from the drawing (since only UIImages can be saved to photo library):
        let uiImage = self.image(from: self.bounds, scale: 1)
        
        // Call a UIKit method to save an image
        UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
    }
    
}
struct CanvasView: UIViewRepresentable {
    @Binding var toolPickerShows: Bool
    @Binding var drawing: PKDrawing
    private let canvasView = PKCanvasView()
    private let toolPicker = PKToolPicker()
    
    func makeUIView(context: Context) -> PKCanvasView {
        // Allow finger drawing
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = context.coordinator
        // Make the tool picker visible or invisible depending on toolPickerShows
        toolPicker.setVisible(toolPickerShows, forFirstResponder: canvasView)
        // Make the canvas respond to tool changes
        toolPicker.addObserver(canvasView)
        if let window = UIApplication.shared.windows.first {
                   // Prendi la tool picker condivisa
                   let toolPicker = PKToolPicker.shared(for: window)
                   context.coordinator.toolPicker = toolPicker
                   toolPicker?.setVisible(toolPickerShows, forFirstResponder: canvasView)
                   toolPicker?.addObserver(canvasView)
               }
        // Make the canvas active -- first responder
        if toolPickerShows {
            canvasView.becomeFirstResponder()
        }
        
        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        // Called when SwiftUI updates the view, (makeUIView(context:) called when creating the view.)
        // For example, called when toolPickerShows is toggled:
        // so hide or show tool picker
        if drawing != canvasView.drawing {
            canvasView.drawing = drawing
            toolPicker.setVisible(toolPickerShows, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            if toolPickerShows {
                canvasView.becomeFirstResponder()
            } else {
                canvasView.resignFirstResponder()
            }
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(drawing: $drawing)
    }
    class Coordinator: NSObject, PKCanvasViewDelegate {
            var drawing: Binding<PKDrawing>
            var toolPicker: PKToolPicker?

            init(drawing: Binding<PKDrawing>) {
                self.drawing = drawing
            }

            func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
                drawing.wrappedValue = canvasView.drawing
            }
        }
    
    
}
    
    struct ContentView1: View {
        @State private var drawing = PKDrawing()
        @State private var toolPickerShows = true
        @State private var navigateHome = false
        var body: some View {
            NavigationStack {
                CanvasView(toolPickerShows: $toolPickerShows,drawing: $drawing)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Disegno")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                                           drawing.saveToPhotoLibrary()
                                                           toolPickerShows = false
                                                           navigateHome = true  // attiva la navigazione
                                                       }) {
                                                           Image(systemName: "xmark.circle")
                                                       }
                                                   }
                                               }
                                           
                NavigationLink(destination: SchermataHome(coloriEmozioni: ContentView().colori),
                                                          isActive: $navigateHome) {
                                               EmptyView()
                }
            }
        }
    }

/*
struct ContentView1: View {
    @State private var drawing = PKDrawing()
    @State private var toolPickerShows = true
    @Environment(\.dismiss) var dismiss  // 👈 Per tornare indietro
    
    var body: some View {
        CanvasView(toolPickerShows: $toolPickerShows, drawing: $drawing)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Disegno")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button (action:{
                        drawing.saveToPhotoLibrary()
                        toolPickerShows = false
                        dismiss() // 👈 Torna alla SchermataHome
                    }){
                        Image(systemName: "xmark.circle")
                         
                    }
                }
            }
    }
}*/

