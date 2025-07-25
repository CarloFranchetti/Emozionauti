//
//  GalleryView.swift
//  Emozionauti
//
//  Created by Studente on 10/07/25.
//

import SwiftUI


struct GridViewObject: View{
    let size: Double
    let selectedDrawing: Drawing
    
    var body: some View{
        ZStack(alignment: .topTrailing){
            selectedDrawing.drawing.toImage()
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        }
    }
}


struct GridView: View{
    @EnvironmentObject var drawingModel: DrawingModel
    @State private var selected: Drawing?
    @State private var selectedEmotion: String = "Nessun filtro"
    @State private var selectedDate: String = "Nessun filtro"
    @EnvironmentObject var navigationManager: NavigationManager

    private let emotions = [
        "Nessun filtro",
        "Felicità",
        "Noia",
        "Tristezza",
        "Rabbia",
        "Paura"
    ]
    
    private var index = 0
    private static let columns = 4
    private var dateFilter: [String] {
        let allDates = drawingModel.drawings.map { $0.date.formatted(date: .numeric, time: .omitted)}
        let uniqueDates = Set(allDates)
        var array = Array(uniqueDates)
        array.append("Nessun filtro")
        return array
    }
    var body: some View {
        ZStack{
            VStack{
                    HStack{
                        Text("Applica filtri:")
                            .fontWeight(.bold)
                            .padding([.leading],20)
                        DropDownMenu(title: "Emozione", options: emotions, selected: $selectedEmotion)
                        DropDownMenu(title: "Data", options: dateFilter, selected: $selectedDate)
                    }
                    ScrollGrid(
                        selectedEmotion: selectedEmotion,
                        selectedDate: selectedDate
                    ) { drawing in
                        selected = drawing
                    }
            }
            
            
            if let selected{
                ZStack{
                    Color.white
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                    VStack{
                        selected.drawing.toImage()
                            .onTapGesture {
                                self.selected = nil
                                navigationManager.dettaglioAperto = false
                            }
                        HStack{
                            Text("Emozione:")
                                .fontWeight(.bold)
                            Text(selected.emotion)
                        }
                        HStack{
                            Text("Data:")
                                .fontWeight(.bold)
                            Text(selected.date.formatted(Date.FormatStyle(date: .complete, time: .shortened) .locale(Locale(identifier: "it_IT"))))
                                .font(.system(size: 20))
                        }
                        Spacer()
                        Button(action:{
                            drawingModel.deleteDrawing(selected)
                            self.selected = nil
                            //navigationManager.open = false
                        }){
                            Image(systemName: "trash.fill")
                                .foregroundColor(.red)
                            Text("Cancella disegno")
                                .foregroundColor(.red)
                
                        }.padding([.bottom],60)
                        
                    }.padding([.leading],10)
                }
            }
            
        }.navigationBarTitle("Galleria Emozioni")
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
}



struct DrawingGalleryView: View{
    @StateObject var dataModel = DrawingModel()
    
    var body: some View {
        NavigationStack{
            GridView()
                .environmentObject(dataModel)
                .navigationViewStyle(.stack)
        }
            
        }
}

