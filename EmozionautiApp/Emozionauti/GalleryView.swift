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
    
    
    
    var body: some View{
        ZStack{
            VStack{
                ZStack{
                    HStack{
                        Text("Applica filtri:")
                            .fontWeight(.bold)
                            .padding([.leading],20)
                        DropDownMenu(title: "Emozione", options: emotions, selected: $selectedEmotion)
                        DropDownMenu(title: "Data", options: dateFilter, selected: $selectedDate)
                    }
                    .fixedSize(horizontal: false, vertical: false)
                }
                .zIndex(1)
                ScrollView{
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 100, maximum: 200),spacing: 10),
                        GridItem(.flexible(minimum: 100, maximum: 200),spacing: 10),
                        GridItem(.flexible(minimum: 100, maximum: 200),spacing: 10),
                        GridItem(.flexible(minimum: 100, maximum: 200),spacing: 10)
                    ],spacing: 10){
                        ForEach(drawingModel.drawings){ drawing in
                            if drawing.emotion.hasPrefix(selectedEmotion) && selectedDate == "Nessun filtro"{
                                GeometryReader{ geometry in
                                    GridViewObject(size: geometry.size.width, selectedDrawing: drawing)
                                        .onTapGesture {
                                            selected = drawing
                                            navigationManager.open = true
                                        }
                                    
                                }.cornerRadius(8.0)
                                    .aspectRatio(1,contentMode: .fit)
                            }else if selectedEmotion == "Nessun filtro" && selectedDate == "Nessun filtro"{
                                GeometryReader{ geometry in
                                   GridViewObject(size: geometry.size.width, selectedDrawing: drawing)
                                        .onTapGesture {
                                            selected = drawing
                                            navigationManager.open = true
                                        }
                                    
                                }.cornerRadius(8.0)
                                    .aspectRatio(1,contentMode: .fit)
                            }else if selectedEmotion == "Nessun filtro" && selectedDate == drawing.date.formatted(date: .numeric, time: .omitted){
                                GeometryReader{ geometry in
                                    GridViewObject(size: geometry.size.width, selectedDrawing: drawing)
                                        .onTapGesture {
                                            selected = drawing
                                            navigationManager.open = true
                                        }
                                    
                                }.cornerRadius(8.0)
                                    .aspectRatio(1,contentMode: .fit)
                                
                            }else if drawing.emotion.hasPrefix(selectedEmotion) && selectedDate == drawing.date.formatted(date: .numeric, time: .omitted){
                                GeometryReader{ geometry in
                                   GridViewObject(size: geometry.size.width, selectedDrawing: drawing)
                                        .onTapGesture {
                                            selected = drawing
                                            navigationManager.open = true
                                        }
                                    
                                }.cornerRadius(8.0)
                                    .aspectRatio(1,contentMode: .fit)
                            }
                            
                            
                        }
                    }
                }.padding(10)
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
                            navigationManager.open = false
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
        }
            .environmentObject(dataModel)
            .navigationViewStyle(.stack)
        }
    }

