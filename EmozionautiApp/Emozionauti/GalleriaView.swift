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
    private let emozioni = [
        "Nessun filtro",
        "Felicità",
        "Noia",
        "Tristezza",
        "Rabbia",
        "Paura"
    ]

    private static let columns = 4

    
    
    var body: some View{
        ZStack{
            VStack{
                HStack{
                    Text("Applica filtri:")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leadingFirstTextBaseline)
                        .padding(20)
                    DropDownMenu(title: "Emozione", options: emozioni, selezionatoE: $emozioneSelezionata)
                }
                ScrollView{
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 100, maximum: 200),spacing: 10),
                        GridItem(.flexible(minimum: 100, maximum: 200),spacing: 10),
                        GridItem(.flexible(minimum: 100, maximum: 200),spacing: 10),
                        GridItem(.flexible(minimum: 100, maximum: 200),spacing: 10)
                    ],spacing: 10){
                        ForEach(disegniModel.disegni){ disegno in
                                if disegno.emozione.hasPrefix(emozioneSelezionata){
                                    GeometryReader{ geometry in
                                        OggettoGridView(size: geometry.size.width, disegnoSelect: disegno)
                                            .onTapGesture {
                                                selezionato = disegno
                                            }
                                        
                                    }.cornerRadius(8.0)
                                        .aspectRatio(1,contentMode: .fit)
                                }else if emozioneSelezionata == "Nessun filtro"{
                                    GeometryReader{ geometry in
                                        OggettoGridView(size: geometry.size.width, disegnoSelect: disegno)
                                            .onTapGesture {
                                                selezionato = disegno
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
                            }
                        HStack{
                            Text("Emozione:")
                                .fontWeight(.bold)
                            Text(selezionato.emozione)
                        }
                        Text(selezionato.date.formatted(date: .complete, time: .shortened))
                            .font(.system(size: 20))
                    }
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

