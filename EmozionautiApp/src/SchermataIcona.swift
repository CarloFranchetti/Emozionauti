//
//  SchermataIcona.swift
//  Emozionauti
//
//  Created by Studente on 01/07/25.
//

import SwiftUI

struct SchermataIcona: View {
    var val:Double=0.0
    var body: some View {
        ZStack{
            Color(red:12/255,green:10/255,blue:96/255)
                .ignoresSafeArea()
            VStack{
                Image("logoEmozionauti")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .cornerRadius(40)
                ProgressView(value: val, total: 100)
                    .padding(80)
                    .bold(true)
                    .saturation(1)
                    .foregroundColor(.white)
            }
                
        }
    }
}

#Preview {
    SchermataIcona()
}
