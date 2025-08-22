//
//  DrawingModel.swift
//  Emozionauti
//
//  Created by Studente on 18/08/25.
//

import SwiftUI
import PencilKit

class DrawingModel: ObservableObject {
    @Published var drawings: [Drawing] = []
    var currentEmotion: String = ""
    
    private let fileURL: URL={
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent("disegni.json")
    }()
    
    init(){
        uploadDrawings()
    }
    
    func add(_ drawing: Drawing){
        drawings.insert(drawing, at: 0)
        saveDrawings()
    }
    
    func saveDrawings(){
        do{
            let data = try JSONEncoder().encode(drawings)
            try data.write(to: fileURL)
        }catch{
            print("Errore nel salvataggio!")
        }
    }
    
    func uploadDrawings(){
        do{
            let data = try Data(contentsOf: fileURL)
            drawings = try JSONDecoder().decode([Drawing].self, from: data)
        }catch{
            print("Errore nel caricamento!")
        }
    }
    
    func deleteDrawing(_ drawing: Drawing){
        if let index = drawings.firstIndex(where:{ $0.id == drawing.id }) {
                drawings.remove(at: index)
                saveDrawings()
            }
    }
    
    func resetDrawings(){
        drawings.removeAll()
        saveDrawings()
    }
    
}

extension URL{
    var isImage: Bool{
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }
}
    

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
