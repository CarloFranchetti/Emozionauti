//
//  TavolaDisegno.swift
//  Emozionauti
//
//  Created by Studente on 04/07/25.
//

import UIKit
import PencilKit

class TavolaDisegno: UIViewController ,PKCanvasViewDelegate{
    
    private let canvasView:PKCanvasView = {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput
        return canvas
    }()
    
    let drawing = PKDrawing()
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.drawing=drawing
        canvasView.delegate=self
        view.addSubview(canvasView)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        canvasView.frame=view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let toolPicker = PKToolPicker()
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
   /* func updateContentSize(for canvasView: PKCanvasView) {
            // Calcola la dimensione minima necessaria per contenere il disegno
            let drawingBounds = canvasView.drawing.bounds

            // Aggiungi un padding extra
            let padding: CGFloat = 20
            let contentWidth = drawingBounds.width + padding
            let contentHeight = drawingBounds.height + padding
            canvasView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        }

   
    //Canvas
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        updateContentSize(for: canvasView)
    }
    */
    @IBAction func salvaDisegni(_ sender: Any) {
    }
    
}

#Preview {
    TavolaDisegno()
}
