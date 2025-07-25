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
    @Binding var selected: String
    @State private var open = false

    
    var body: some View{
        ZStack{
            HStack{
                VStack(alignment: .leading){
                    Text(title)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .opacity(0.8)
                    VStack{
                        HStack{
                            Text(selected)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .rotationEffect(.degrees(open ? -180 : 0))
                        }.frame(height:40)
                            .padding(.horizontal)
                            .onTapGesture {
                                withAnimation(.snappy){
                                    open.toggle()
                                }
                            }
                    }
                    if open{
                        ZStack{
                            VStack{
                                ForEach(options, id:\.self){ option in
                                    HStack{
                                        Text(option)
                                            .foregroundStyle(selected == option ? Color.primary : .gray)
                                        Spacer()
                                        if selected == option{
                                            Image(systemName: "checkmark")
                                                .font(.subheadline)
                                        }
                                    }.frame(height:40)
                                        .padding(.horizontal)
                                        .onTapGesture{
                                            withAnimation(.snappy){
                                                selected = option
                                                open.toggle()
                                            }
                                        }
                                }
                            }.clipShape(RoundedRectangle(cornerRadius:10))
                                .frame(minWidth: 130, maxWidth: .infinity, alignment: .leading)

                        }.zIndex(10)
                    }
                }
                
            }
        }
        }
}
