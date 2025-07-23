//
//  GestioneAnimazioni.swift
//  Emozionauti
//
//  Created by Studente on 22/07/25.
//

import SwiftUI


class GestioneAnimazioniModel: ObservableObject{
    @Published var impostazioneSel: String = "Mai"
}

struct GestioneAnimazioniView: View{
    @EnvironmentObject private var impostazioni: GestioneAnimazioniModel
    @EnvironmentObject var navigationManager: NavigationManager

    private let frequenze = [
        "Mai",
        "Una volta per ogni emozione",
        "Sempre"
    ]
    
    var body: some View{
        ZStack{
            VStack{
                List{
                    Section (header: Text("Mostra animazioni:")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.black))
                    {
                            ZStack{
                                VStack{
                                    ForEach(frequenze, id:\.self){ frequenza in
                                        HStack{
                                            Text(frequenza)
                                                .foregroundStyle(impostazioni.impostazioneSel == frequenza ? Color.primary : .gray)
                                            Spacer()
                                            if impostazioni.impostazioneSel  == frequenza{
                                                Image(systemName: "checkmark")
                                                    .font(.subheadline)
                                            }
                                        }.frame(height:40)
                                            .padding(.horizontal)
                                            .onTapGesture{
                                                withAnimation(.snappy){
                                                    impostazioni.impostazioneSel  = frequenza
                                                }
                                            }
                                    }
                                }.clipShape(RoundedRectangle(cornerRadius:10))
                                    .frame(minWidth: 130, maxWidth: .infinity, alignment: .leading)

                            }.zIndex(10)
                            

                        }
                        .textCase(nil)
                    
                }
                    
                Spacer()
            }
        }
        }
}
