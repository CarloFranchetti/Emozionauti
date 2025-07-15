import SwiftUI

struct Animazione: View {
    @EnvironmentObject var navManager: NavigationManager

    var coloreEmozione: Color
    var coloreOmbra: Color
    var text: String
    var nextView: NavigationViewType

    var body: some View {
        ZStack {
            let sfondoBlu = Color(red: 12/255, green: 10/255, blue: 96/255)
            Color(sfondoBlu)
                .ignoresSafeArea()

            VStack() {
                Text(text)
                    .font(.custom("Mitr-regular", size: 50))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    navManager.currentView = nextView
                }) {
                    Text("Inizia il minigioco")
                        .font(.custom("Mitr-regular", size: 50))
                }
                .padding()
                .background(coloreOmbra)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}
