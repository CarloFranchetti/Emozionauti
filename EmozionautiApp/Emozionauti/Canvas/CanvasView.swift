//
//  CanvasView.swift
//  Emozionauti
//
//  Created by Studente on 22/07/25.
//

import SwiftUI
import PencilKit
import UIKit
import Foundation


struct CanvasView: UIViewRepresentable {
    @Binding var toolPickerShows: Bool
    @Binding var drawing: PKDrawing
    private let canvasView = PKCanvasView()
    private let toolPicker = PKToolPicker()
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = context.coordinator
        toolPicker.setVisible(toolPickerShows, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first {
                let toolPicker = PKToolPicker()
                context.coordinator.toolPicker = toolPicker
                toolPicker.setVisible(toolPickerShows, forFirstResponder: canvasView)
                toolPicker.addObserver(canvasView)
            }
        
        if toolPickerShows {
            canvasView.becomeFirstResponder()
        }
        
        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        canvasView.drawing = drawing
        if toolPickerShows {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            canvasView.becomeFirstResponder()
        } else {
            toolPicker.setVisible(false, forFirstResponder: canvasView)
            toolPicker.removeObserver(canvasView)
            canvasView.resignFirstResponder()
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
    @EnvironmentObject var navManager: NavigationManager
    @State private var drawing = PKDrawing()
    @State private var toolPickerShows = true
    @EnvironmentObject var drawings: DrawingModel
    var text: String
    var emotion: String

    var body: some View {
        VStack {
            CanvasView(toolPickerShows: $toolPickerShows, drawing: $drawing)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(text)
                    .font(.custom("Mitr-regular",size:30))
                    .foregroundColor(.black)
                    .padding([.top],50)
            }

  
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    let newDrawing = Drawing(drawing: drawing, emotion: emotion)
                    drawings.add(newDrawing)
                    toolPickerShows = false
                    DispatchQueue.main.asyncAfter(deadline:  .now() + 0.3) {
                        navManager.currentView = .home
                    }
                })
                {
                    Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
