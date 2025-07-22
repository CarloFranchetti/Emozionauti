
import SwiftUI
import PencilKit
import UIKit
import Foundation

class Disegno: Identifiable, ObservableObject, Equatable, Codable{
    let id: UUID
    let date: Date
    let emozione: String
    let disegno: PKDrawing
    let drawingbase64: String
    
    init(disegno: PKDrawing, emozione: String){
        self.id = UUID()
        self.disegno = disegno
        self.drawingbase64 = disegno.dataRepresentation().base64EncodedString()
        self.date = Date()
        self.emozione = emozione
    }
    
    var pkDrawing: PKDrawing {
            (try? PKDrawing(data: Data(base64Encoded: drawingbase64) ?? Data())) ?? PKDrawing()
    }
    
    static func ==(dis1: Disegno, dis2: Disegno)-> Bool {
        return dis1.id == dis2.id
    }
    
}

extension PKDrawing {
    func toImage(scale: CGFloat = 1.0) -> Image{
        let uiImage = self.image(from: self.bounds, scale: scale)
        return Image(uiImage: uiImage)
    }
}


class DisegniModel: ObservableObject {
    @Published var disegni: [Disegno] = []
    var emozioneCorrente: String = ""
    
    private let fileURL: URL={
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent("disegni.json")
    }()
    
    init(){
        caricaDisegni()
    }
    
    func aggiungi(_ disegno: Disegno){
        disegni.insert(disegno, at: 0)
        salvaDisegni()
    }
    
    func salvaDisegni(){
        do{
            let data = try JSONEncoder().encode(disegni)
            try data.write(to: fileURL)
        }catch{
            print("Errore nel salvataggio!")
        }
    }
    
    func caricaDisegni(){
        do{
            let data = try Data(contentsOf: fileURL)
            disegni = try JSONDecoder().decode([Disegno].self, from: data)
        }catch{
            print("Errore nel caricamento!")
        }
    }
    
    func cancellaDisegno(_ disegno: Disegno){
        if let indice = disegni.firstIndex(of: disegno) {
                disegni.remove(at: indice)
                salvaDisegni()
            }
    }
    
    func resettaDisegni(){
        disegni.removeAll()
        salvaDisegni()
    }
    
}

extension URL{
    var isImage: Bool{
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }
}
    


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
    @State private var disegno = PKDrawing()
    @State private var toolPickerShows = true
    @EnvironmentObject var disegni: DisegniModel
    var text: String
    var emozione: String

    var body: some View {
        VStack {
            CanvasView(toolPickerShows: $toolPickerShows, drawing: $disegno)
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
                    let nuovoDisegno = Disegno(disegno: disegno, emozione: emozione)
                    disegni.aggiungi(nuovoDisegno)
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


