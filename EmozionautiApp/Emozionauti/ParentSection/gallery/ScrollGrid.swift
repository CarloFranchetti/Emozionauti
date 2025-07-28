//
//  ScrollGrid.swift
//  Emozionauti
//
//  Created by Studente on 24/07/25.
//

import SwiftUI

struct GridItemView: View {
    let drawing: Drawing
    let onSelect: (Drawing) -> Void

    var body: some View {
        GeometryReader { geometry in
            GridViewObject(size: geometry.size.width, selectedDrawing: drawing)
                .onTapGesture {
                    onSelect(drawing)
                }
        }
        .cornerRadius(8.0)
        .aspectRatio(1, contentMode: .fit)
    }
}


struct ScrollGrid: View {
    let selectedEmotion: String
    let selectedDate: String
    let onSelect: (Drawing) -> Void 

    @EnvironmentObject var drawingModel: DrawingModel
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 100, maximum: 200), spacing: 10),
                GridItem(.flexible(minimum: 100, maximum: 200), spacing: 10),
                GridItem(.flexible(minimum: 100, maximum: 200), spacing: 10),
                GridItem(.flexible(minimum: 100, maximum: 200), spacing: 10)
            ], spacing: 10) {

                ForEach(drawingModel.drawings) { drawing in
                    let dateFormatted = drawing.date.formatted(date: .numeric, time: .omitted)

                    if drawing.emotion.hasPrefix(selectedEmotion) && selectedDate == "Nessun filtro" {
                        GridItemView(drawing: drawing, onSelect: onSelect)

                    } else if selectedEmotion == "Nessun filtro" && selectedDate == "Nessun filtro" {
                        GridItemView(drawing: drawing, onSelect: onSelect)

                    } else if selectedEmotion == "Nessun filtro" && selectedDate == dateFormatted {
                        GridItemView(drawing: drawing, onSelect: onSelect)

                    } else if drawing.emotion.hasPrefix(selectedEmotion) && selectedDate == dateFormatted {
                        GridItemView(drawing: drawing, onSelect: onSelect)
                    }
                }
            }
        }
        .padding(10)
    }
}

