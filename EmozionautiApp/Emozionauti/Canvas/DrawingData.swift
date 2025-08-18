//
//  DrawingData.swift
//  Emozionauti
//
//  Created by Studente on 18/08/25.
//
import SwiftUI
import PencilKit

class Drawing: Identifiable, ObservableObject, Equatable, Codable{
    let id: UUID
    let date: Date
    let emotion: String
    let drawing: PKDrawing
    let drawingbase64: String
    
    init(drawing: PKDrawing, emotion: String){
        self.id = UUID()
        self.drawing = drawing
        self.drawingbase64 = drawing.dataRepresentation().base64EncodedString()
        self.date = Date()
        self.emotion = emotion
    }
    
    var pkDrawing: PKDrawing {
            (try? PKDrawing(data: Data(base64Encoded: drawingbase64) ?? Data())) ?? PKDrawing()
    }
    
    static func ==(draw1: Drawing, draw2: Drawing)-> Bool {
        return draw1.id == draw2.id
    }
    
}

extension PKDrawing {
    func toImage(scale: CGFloat = 1.0) -> Image{
        let uiImage = self.image(from: self.bounds, scale: scale)
        return Image(uiImage: uiImage)
    }
}
