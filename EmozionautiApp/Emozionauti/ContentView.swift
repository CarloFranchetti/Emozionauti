import SwiftUI
import UserNotifications
struct ContentView: View {
    @StateObject var navManager = NavigationManager()
    @StateObject private var diaryViewModel: DiaryViewModel
    @State private var vaiAvanti = false
    @StateObject private var disegniModel = DisegniModel()
    @State private var fineGiocoFelicita = false
    init(diaryViewModel: DiaryViewModel) {
            _diaryViewModel = StateObject(wrappedValue: diaryViewModel)
        }
    
    let colori: [String: Color] = [
        "rabbia": Color(red:255/255,green:102/255,blue:104/255),
        "felicita": Color(red:70/255,green:239/255,blue:48/255),
        "paura": Color(red:194/255,green:168/255,blue:230/255),
        "noia": Color(red:171/255,green:173/255,blue:171/255),
        "tristezza": Color(red:123/255,green:206/255,blue:248/255),
        "rabbiaombra": Color(red:202/255,green:37/255,blue:22/255),
        "felicitaombra": Color(red:12/255,green:165/255,blue:7/255),
        "pauraombra": Color(red:125/255,green:27/255,blue:191/255),
        "noiaombra": Color(red:66/255,green:64/255,blue:56/255),
        "tristezzaombra": Color(red:19/255,green:43/255,blue:137/255),
        "sfondo": Color(red: 12/255, green: 10/255, blue: 96/255)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                switch navManager.currentView {
                    case .splash:
                        SchermataIcona()
                    case .home:
                        SchermataHome(coloriEmozioni: colori)
                            .environmentObject(diaryViewModel)
                    case .animazioneRabbia:
                        Animazione(
                            animazione: "AnimazioneRabbia",
                            coloreEmozione: colori["rabbia"]!,
                            coloreOmbra: colori["rabbiaombra"]!,
                            text: "Quando ti senti arrabbiato...",
                            nextView: .minigiocoRabbia
                        )
                    case .minigiocoRabbia:
                    MinigiocoRabbia(colore: colori["rabbiaombra"]!,coloreOmbra: colori["rabbia"]!)
                    case .animazioneFelicita:
                        Animazione(
                            animazione: "AnimazioneFelicità",
                            coloreEmozione: colori["felicita"]!,
                            coloreOmbra: colori["felicitaombra"]!,
                            text: "Quando ti senti felice...",
                            nextView: .minigiocoFelicita2
                        )
                    case .minigiocoFelicita2:
                        MinigiocoFelicitaView(coloreFelicita: colori["felicitaombra"]!, coloreFelicitaOmbra: colori["felicita"]!, coloreS: colori["sfondo"]!)
                    case .animazionePaura:
                        Animazione(
                            animazione: "AnimazionePaura",
                            coloreEmozione: colori["paura"]!,
                            coloreOmbra: colori["pauraombra"]!,
                            text: "Quando hai paura...",
                            nextView: .minigiocoPaura
                        )
                    case .minigiocoPaura:
                    MinigiocoPaura(colorePaura: colori["pauraombra"]!,colorePauraOmbra:colori["paura"]!)
                    case .animazioneNoia:
                        Animazione(
                            animazione: "AnimazioneNoia",
                            coloreEmozione: colori["noia"]!,
                            coloreOmbra: colori["noiaombra"]!,
                            text: "Quando sei annoiato...",
                            nextView: .minigiocoNoia
                        )
                    case .minigiocoNoia:
                    MinigiocoNoia(vaiAvanti:$vaiAvanti,coloreNoiaOmbra: colori["noia"]!,coloreNoia:colori["noiaombra"]!)
                    case .animazioneTristezza:
                        Animazione(
                            animazione: "AnimazioneTristezza",
                            coloreEmozione: colori["tristezza"]!,
                            coloreOmbra: colori["tristezzaombra"]!,
                            text: "Quando ti senti triste...",
                            nextView: .minigiocoTristezza
                        )
                    case .minigiocoTristezza:
                    MinigiocoTristezza(coloreTriste: colori["tristezzaombra"]!,coloreTristeOmbra: colori["tristezza"]!, song: "songysong", image:"dancingAlien")
                    case .canvas(let text, let emozione):
                    ContentView1(text: text, emozione: emozione)
                        .environmentObject(disegniModel)
                    case .diario:
                        DiaryStatsView()
                            .environmentObject(diaryViewModel)
                    case .parentalControl:
                        ParentAccessView()
                    case .parentDashboard:
                        ParentDashboardView()
                            .environmentObject(navManager)
                            .environmentObject(diaryViewModel)
                            .environmentObject(disegniModel)                  
                    case .gallery:
                        DrawingGalleryView()                
                }
            }
            .toolbar {
                if navManager.showBackButton{
                // Aggiungi il pulsante back solo se serve
                ToolbarItem(placement: .navigationBarLeading) {
                    
                        Button {
                            navManager.goBack()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Indietro")
                            }
                        }
                    }
                }
                
            }
            .navigationBarBackButtonHidden(true) // Nasconde il back automatico
        }
        .environmentObject(navManager)
        .environmentObject(diaryViewModel)
        .environmentObject(disegniModel)
        .onAppear{
            AppDelegate.instance.requestAuthorization()
        }
    }
}
