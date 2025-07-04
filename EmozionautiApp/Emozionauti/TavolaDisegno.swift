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
    
    //Canvas
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        <#code#>
    }
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        <#code#>
    }
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        <#code#>
    }
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        <#code#>
    }
    @IBAction func salvaDisegni(_ sender: Any) {
    }
    
}

#Preview {
    TavolaDisegno()
}
