import SwiftUI
import SpriteKit
class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
@Published var alert = false

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.badge, .banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    if response.actionIdentifier == "RISPONDI" {
        print("rispondi o fai qualcos'altro")
        self.alert.toggle()
    }
    
    completionHandler()
    }
}
struct SchermataHome: View {
    let coloriEmozioni: [String: Color]
    @EnvironmentObject var navManager: NavigationManager
    @EnvironmentObject var diaryViewModel: DiaryViewModel
    @State var rotazione: Double = 0.0
    @StateObject var delegate = NotificationDelegate()
    @StateObject private var sfondoAnimato: SfondoAnimatoViewModel
  
    init(coloriEmozioni: [String : Color]) {
        self.coloriEmozioni = coloriEmozioni
        let sfondo = SfondoAnimatoViewModel(coloreSfondo: UIColor(coloriEmozioni["sfondo"]!))
        _sfondoAnimato = StateObject(wrappedValue: sfondo)
    }
    func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Emozionauti"
        content.subtitle = "è ora di giocare"
        content.categoryIdentifier = "AZIONI"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "IN-APP", content: content, trigger: trigger)
        
        let close = UNNotificationAction(identifier: "CHIUDI", title: "Chiudi", options: .destructive)
        let reply = UNNotificationAction(identifier: "RISPONDI", title: "Rispondi", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "AZIONI", actions: [close, reply], intentIdentifiers: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack {
                ZStack {
                  SpriteView(scene: {
                        let scene = SfondoAnimato()
                        scene.size = UIScreen.main.bounds.size
                        scene.scaleMode = .resizeFill
                        scene.viewModel = sfondoAnimato
                        return scene
                    }())
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                    
                    //Pulsante impostazioni
                    Button {
                        navManager.currentView = .parentalControl
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width*0.1, height: geometry.size.height*0.1)
                            //.background(Color(red:12/255,green:10/255,blue:96/255))
                            .cornerRadius(20)
                            .padding(80)
                    }
                    .position(x:geometry.size.width-50,y:geometry.size.height/20)
                    
                    VStack(alignment: .center, spacing:70) {
                        HStack(spacing:80) {
                            // RABBIA
                            Button {
                                diaryViewModel.recordEmotion("rabbia")
                                navManager.currentView = .animazioneRabbia
                            } label: {
                                Image("rabbia")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(coloriEmozioni["rabbia"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: coloriEmozioni["rabbiaombra"]!, radius: 0, x: 5, y: 10)
                            
                            // FELICITÀ
                            Button {
                                diaryViewModel.recordEmotion("felicità")
                                navManager.currentView = .animazioneFelicita
                            } label: {
                                Image("felicita")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(coloriEmozioni["felicita"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: coloriEmozioni["felicitaombra"]!, radius: 0, x: 5, y: 10)
                            
                            // PAURA
                            Button {
                                diaryViewModel.recordEmotion("paura")
                                navManager.currentView = .animazionePaura
                            } label: {
                                Image("paura")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(coloriEmozioni["paura"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: coloriEmozioni["pauraombra"]!, radius: 0, x: 5, y: 10)
                        }
                        
                        HStack(spacing:80) {
                            // NOIA
                            Button {
                                diaryViewModel.recordEmotion("noia")
                                navManager.currentView = .animazioneNoia
                            } label: {
                                Image("noia")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(coloriEmozioni["noia"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: coloriEmozioni["noiaombra"]!, radius: 0, x: 5, y: 10)
                            
                            // TRISTEZZA
                            Button {
                                diaryViewModel.recordEmotion("tristezza")
                                navManager.currentView = .animazioneTristezza
                            } label: {
                                Image("tristezza")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(coloriEmozioni["tristezza"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: coloriEmozioni["tristezzaombra"]!, radius: 0, x: 5, y: 10)
                        }
                    }
                    .position(x:geometry.size.width/2,y:geometry.size.height/2)
                }
                .navigationBarBackButtonHidden(true)
            }
        }.onAppear {
            createNotification()
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                    
        }
            UNUserNotificationCenter.current().delegate = delegate
            }
            .alert(isPresented: $delegate.alert) {
                Alert(title: Text("Messaggio"), message: Text("Il pulsante di risposta è stato premuto"), dismissButton: .destructive(Text("Ok")))
            }
        
    }
}


