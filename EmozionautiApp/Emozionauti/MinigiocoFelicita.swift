import SwiftUI

struct MinigiocoFelicita: View {
    @EnvironmentObject var navManager: NavigationManager
    let vectorImage = [Image("astronauta1"), Image("astronauta2"), Image("astronauta3")]

    var body: some View {
        VStack(spacing: 30) {
            Text("Conta gli astronauti!")
                .font(.custom("Mitr-Regular", size: 50))
                .fontWeight(.bold)
                .padding(.top, 50)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)

            HStack(spacing: 40) {
                vectorImage[0]
                    .resizable()
                    .frame(width: 200, height: 200)
                vectorImage[1]
                    .resizable()
                    .frame(width: 200, height: 200)
            }

            Button(action: {
                navManager.currentView = .canvas
            }) {
                Text("Prosegui")
                    .font(.custom("Mitr-Regular", size: 30))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 60)
                    .background(Color.green)
                    .cornerRadius(12)
            }
            .padding(.top, 50)

            Spacer()
        }
        .padding()
    }
}
