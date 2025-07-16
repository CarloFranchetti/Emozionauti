//
//  DropDownMenu.swift
//  Emozionauti
//
//  Created by Studente on 16/07/25.
//

import SwiftUI

struct DropDownMenu: View{
    let title: String
    let options: [String]
    @Binding var selezionatoE: String
    @State private var filtroEaperto = false

    
    var body: some View{
        HStack{
           
            VStack(alignment: .leading){
                Text(title)
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .opacity(0.8)
                VStack{
                    HStack{
                        Text(selezionatoE)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .rotationEffect(.degrees(filtroEaperto ? -180 : 0))
                    }.frame(height:40)
                     .padding(.horizontal)
                     .onTapGesture {
                         withAnimation(.snappy){
                             filtroEaperto.toggle()
                         }
                     }
                }
                if filtroEaperto{
                    VStack{
                        ForEach(options, id:\.self){ option in
                            HStack{
                                Text(option)
                                    .foregroundStyle(selezionatoE == option ? Color.primary : .gray)
                                Spacer()
                                if selezionatoE == option{
                                    Image(systemName: "checkmark")
                                        .font(.subheadline)
                                }
                            }.frame(height:40)
                            .padding(.horizontal)
                            .onTapGesture{
                                withAnimation(.snappy){
                                    selezionatoE = option
                                    filtroEaperto.toggle()
                                }
                            }
                        }
                    }
                }
            }.clipShape(RoundedRectangle(cornerRadius:10))
              .frame(width:140)

        }
        }
}

/*#Preview {
    DropDownMenu(selezionatoE: .constant("Felicità"));
}*/
