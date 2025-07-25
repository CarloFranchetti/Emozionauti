//
//  AnimationManager.swift
//  Emozionauti
//
//  Created by Studente on 24/07/25.
//


import SwiftUI


class AnimationManagementModel: ObservableObject{
    @Published var selectedSetting: String = "Mai"
}

struct AnimationManagementView: View{
    @EnvironmentObject private var settings: AnimationManagementModel
    @EnvironmentObject var navigationManager: NavigationManager

    private let frequencies = [
        "Mai",
        "Una volta per ogni emozione",
        "Sempre"
    ]
    
    var body: some View{
        ZStack{
            VStack{
                List{
                    Section{
                            ZStack{
                                VStack{
                                    ForEach(frequencies, id:\.self){ frequency in
                                        HStack{
                                            Text(frequency)
                                                .foregroundStyle(settings.selectedSetting == frequency ? Color.primary : .gray)
                                            Spacer()
                                            if settings.selectedSetting  == frequency{
                                                Image(systemName: "checkmark")
                                                    .font(.subheadline)
                                            }
                                        }.frame(height:40)
                                            .padding(.horizontal)
                                            .onTapGesture{
                                                withAnimation(.snappy){
                                                   settings.selectedSetting  = frequency
                                                }
                                            }
                                    }
                                }.clipShape(RoundedRectangle(cornerRadius:10))
                                    .frame(minWidth: 130, maxWidth: .infinity, alignment: .leading)

                            }.zIndex(10)
                            

                        }
                        
                    
                }
                    
                Spacer()
            }
        }.navigationBarTitle("Mostra animazioni")
        .navigationBarTitleDisplayMode(.inline)
        }
}
