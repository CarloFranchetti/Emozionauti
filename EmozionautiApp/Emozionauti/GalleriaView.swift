//
//  GalleriaView.swift
//  Emozionauti
//
//  Created by Studente on 10/07/25.
//
import SwiftUI


struct OggettoGridView: View{
    let size: Double
    let disegnoSelect: Disegno
    
    var body: some View{
        ZStack(alignment: .topTrailing){
            disegnoSelect.disegno.toImage()
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)

        }
    }
}


struct GridView: View{
    @EnvironmentObject var disegniModel: DisegniModel
    @State private var selezionato: Disegno?
    @State private var emozioneSelezionata: String = "Nessun filtro"
    @State private var dataSelezionata: String = "Nessun filtro"
    @EnvironmentObject var navigationManager: NavigationManager

    private let emozioni = [
        "Nessun filtro",
        "Felicità",
        "Noia",
        "Tristezza",
        "Rabbia",
        "Paura"
    ]
    private var index = 0
    private static let columns = 4
    
    private var dateFiltrabili: [String] {
        let allDates = disegniModel.disegni.map { $0.date.formatted(date: .numeric, time: .omitted)}
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
                        DropDownMenu(title: "Emozione", options: emozioni, selezionatoE: $emozioneSelezionata)
                        DropDownMenu(title: "Data", options: dateFiltrabili, selezionatoE: $dataSelezionata)
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
                        ForEach(disegniModel.disegni){ disegno in
                            if disegno.emozione.hasPrefix(emozioneSelezionata) && dataSelezionata == "Nessun filtro"{
                                GeometryReader{ geometry in
                                    OggettoGridView(size: geometry.size.width, disegnoSelect: disegno)
                                        .onTapGesture {
                                            selezionato = disegno
                                            navigationManager.dettaglioAperto = true
                                        }
                                    
                                }.cornerRadius(8.0)
                                    .aspectRatio(1,contentMode: .fit)
                            }else if emozioneSelezionata == "Nessun filtro" && dataSelezionata == "Nessun filtro"{
                                GeometryReader{ geometry in
                                    OggettoGridView(size: geometry.size.width, disegnoSelect: disegno)
                                        .onTapGesture {
                                            selezionato = disegno
                                            navigationManager.dettaglioAperto = true
                                        }
                                    
                                }.cornerRadius(8.0)
                                    .aspectRatio(1,contentMode: .fit)
                            }else if emozioneSelezionata == "Nessun filtro" && dataSelezionata == disegno.date.formatted(date: .numeric, time: .omitted){
                                GeometryReader{ geometry in
                                    OggettoGridView(size: geometry.size.width, disegnoSelect: disegno)
                                        .onTapGesture {
                                            selezionato = disegno
                                            navigationManager.dettaglioAperto = true
                                        }
                                    
                                }.cornerRadius(8.0)
                                    .aspectRatio(1,contentMode: .fit)
                                
                            }else if disegno.emozione.hasPrefix(emozioneSelezionata) && dataSelezionata == disegno.date.formatted(date: .numeric, time: .omitted){
                                GeometryReader{ geometry in
                                    OggettoGridView(size: geometry.size.width, disegnoSelect: disegno)
                                        .onTapGesture {
                                            selezionato = disegno
                                            navigationManager.dettaglioAperto = true
                                        }
                                    
                                }.cornerRadius(8.0)
                                    .aspectRatio(1,contentMode: .fit)
                            }
                            
                            
                        }
                    }
                }.padding(10)
            }
            
            
            if let selezionato{
                ZStack{
                    Color.white
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                    VStack{
                        selezionato.disegno.toImage()
                            .onTapGesture {
                                self.selezionato = nil
                                navigationManager.dettaglioAperto = false
                            }
                        HStack{
                            Text("Emozione:")
                                .fontWeight(.bold)
                            Text(selezionato.emozione)
                        }
                        HStack{
                            Text("Data:")
                                .fontWeight(.bold)
                            Text(selezionato.date.formatted(Date.FormatStyle(date: .complete, time: .shortened) .locale(Locale(identifier: "it_IT"))))
                                .font(.system(size: 20))
                        }
                        Spacer()
                        Button(action:{
                            disegniModel.cancellaDisegno(selezionato)
                            self.selezionato = nil
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
    @StateObject var dataModel = DisegniModel()
    
    var body: some View {
        NavigationStack{
            GridView()
        }
            .environmentObject(dataModel)
            .navigationViewStyle(.stack)
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingGalleryView()
    }
}

