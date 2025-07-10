import SwiftUI

struct MinigiocoTristezza: View {
    @EnvironmentObject var navManager: NavigationManager

    var body: some View {
        VStack(spacing: 40) {
            Text("Balla via la tristezza!")
                .font(.custom("Mitr-Regular", size: 50))
                .fontWeight(.bold)
                .padding(.top, 50)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)

            Spacer()
            
            Button(action: {
                navManager.currentView = .canvas
            }) {
                Text("Avanti")
                    .font(.custom("Mitr-Regular", size: 36))
                    .foregroundColor(.white)
                    .frame(width: 300, height: 100)
                    .background(Color.blue)
                    .cornerRadius(25)
                    .shadow(radius: 5)
            }
            .padding(.bottom, 50)
        }
        .padding()
    }
}
