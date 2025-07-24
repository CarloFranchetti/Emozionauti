
import SwiftUI
import PencilKit
import UIKit
import Foundation

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
        if let index = drawings.firstIndex(of: drawing) {
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
        if let window = UIApplication.shared.windows.first {
                   let toolPicker = PKToolPicker.shared(for: window)
                   context.coordinator.toolPicker = toolPicker
                   toolPicker?.setVisible(toolPickerShows, forFirstResponder: canvasView)
                   toolPicker?.addObserver(canvasView)
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


