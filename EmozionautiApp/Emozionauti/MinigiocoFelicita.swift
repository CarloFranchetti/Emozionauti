import SwiftUI
import AudioToolbox

struct MinigiocoFelicita: View {
    @EnvironmentObject var navManager: NavigationManager

    var coloreFelicita: Color
    var coloreFelicitaOmbra: Color
    let vectorImage = [Image("astronauta1"),
                       Image("astronauta2"),
                       Image("astronauta3"),
                       Image("astronauta4"),
                       Image("astronauta5"),
                       Image("astronauta6"),
                       Image("pianeta1"),
                       Image("pianeta2"),
                       Image("pianeta3"),
                       Image("pianeta4")]
    
    @State var conteggio: String = ""
    @State var messaggio: String = ""
    @State var coloreMex: Color = .white
    
    var body: some View {
        VStack{
            Text("Conta gli astronauti!")
                .font(.custom("Mitr-Regular",size:50))
                .fontWeight(.bold)
                .padding(.top, 10)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            VStack{
                HStack{
                    vectorImage[0]
                        .resizable()
                        .frame(width: 200, height: 200)
                    vectorImage[5]
                        .resizable()
                        .frame(width:200, height:200)
                    vectorImage[1]
                        .resizable()
                        .frame(width:200, height:200)
                }
                HStack{
                    vectorImage[6]
                        .resizable()
                        .frame(width: 200, height: 180)
                    vectorImage[3]
                        .resizable()
                        .frame(width:200, height:200)
                    vectorImage[7]
                        .resizable()
                        .frame(width:200, height:200)
                }
                HStack{
                    vectorImage[4]
                        .resizable()
                        .frame(width: 200, height: 180)
                    vectorImage[8]
                        .resizable()
                        .frame(width:200, height:200)
                    vectorImage[5]
                        .resizable()
                        .frame(width:200, height:200)
                }
            }
            Text("Quanti astronauti hai contato?")
                .font(.custom("Mitr-regular",size:40))
                .fontWeight((.bold))
            HStack{
                TextField("Inserisci un numero...", text: $conteggio)
                    .font(.custom("Mitr-regular",size:30))
                    .padding([.bottom],20)
                    .clipShape(RoundedRectangle(cornerRadius:25))
                    .frame(width:600, height:100)
                Button(action: {verificaConta(conta: conteggio)}){
                    Image(systemName:"checkmark.circle")
                        .resizable()
                }.frame(width:50,height:50)
                    .foregroundColor(coloreFelicita)
            }
            Text(messaggio)
                .foregroundColor(coloreMex)
                .font(.custom("Mitr-regular", size: 30))
        }

    }
    
    func verificaConta(conta: String){
        if let contaUnwp = Int(conta){
            if contaUnwp == 7{
                messaggio = "Ben fatto!"
                coloreMex = .green
                playSuccessSound()
                Button(action: {navManager.currentView = .canvas}) {
                    Text("Avanti")
                        .font(.custom("Mitr-Regular", size: 36))
                        .foregroundColor(.white)
                        .frame(width: 300, height: 100)
                        .background(coloreFelicita)
                        .cornerRadius(25)
                        .shadow(color: coloreFelicitaOmbra, radius: 0, x: 10, y: 10)
                }

            }else{
                messaggio = "Oops, Riprova!"
                coloreMex = .red
                playErrorSound()
            }
        }
        else{
            messaggio = "Riprova ad inserire!"
            coloreMex = .orange
        }
   }
    
    func playSuccessSound() {
           AudioServicesPlaySystemSound(1104) // Suono "pop"
       }

       func playErrorSound() {
           AudioServicesPlaySystemSound(1023) // Suono errore
       }

}


#Preview {
    ContentView()
}

