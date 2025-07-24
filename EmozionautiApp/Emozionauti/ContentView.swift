import SwiftUI
import UserNotifications
struct ContentView: View {
    @StateObject var navManager = NavigationManager()
    @StateObject private var diaryViewModel: DiaryViewModel
    @State private var ahead = false
    @StateObject private var drawingModel = DisegniModel()
    @State private var endHappinessGame = false
    @StateObject private var settingsAnimation = GestioneAnimazioniModel()
    
    init(diaryViewModel: DiaryViewModel) {
            _diaryViewModel = StateObject(wrappedValue: diaryViewModel)
        }
    let colors: [String: Color] = [
        "anger": Color(red:255/255,green:102/255,blue:104/255),
        "happiness": Color(red:70/255,green:239/255,blue:48/255),
        "fear": Color(red:194/255,green:168/255,blue:230/255),
        "boredom": Color(red:171/255,green:173/255,blue:171/255),
        "sadness": Color(red:123/255,green:206/255,blue:248/255),
        "angershadow": Color(red:202/255,green:37/255,blue:22/255),
        "happinessshadow": Color(red:12/255,green:165/255,blue:7/255),
        "fearshadow": Color(red:125/255,green:27/255,blue:191/255),
        "boredomshadow": Color(red:66/255,green:64/255,blue:56/255),
        "sadnessshadow": Color(red:19/255,green:43/255,blue:137/255),
        "background": Color(red: 12/255, green: 10/255, blue: 96/255)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                switch navManager.currentView {
                    case .splash:
                        IconScreen()
                    case .home:
                        HomeScreen(emotionsColors: colors)
                    case .angerAnimation:
                        Animation(
                            animation: "AnimazioneRabbia",
                            emotionColor: colors["anger"]!,
                            shadowColor: colors["angershadow"]!,
                            nextView: .angerGame
                        )
                    case .angerGame:
                    AngerGame(angerColor: colors["angershadow"]!,angerShadowColor: colori["anger"]!)
                    case .happinessAnimation:
                        Animation(
                            animation: "AnimazioneFelicità",
                            emotionColor: colors["happiness"]!,
                            shadowColor: colors["happinessShadow"]!,
                            nextView: .happinessGame
                        )
                    case .happinessGame:
                        HappinessGameView(coloreFelicita: colors["happinessshadow"]!, coloreFelicitaOmbra: colors["happiness"]!, coloreS: colors["background"]!)
                    case .fearAnimation:
                        Animation(
                            animation: "AnimazionePaura",
                            emotionColor: colors["fear"]!,
                            shadowColor: colors["fearshadow"]!,
                            nextView: .fearGame
                        )
                    case .fearGame:
                    FearGame(colorePaura: colors["fearshadow"]!,colorePauraOmbra:colori["fear"]!)
                    case .boredomAnimation:
                        Animation(
                            animation: "AnimazioneNoia",
                            emotionColor: colori["boredom"]!,
                            shadowColor: colori["boredomshadow"]!,
                            nextView: .boredomGame
                        )
                    case .boredomGame:
                    BoredomGame(vaiAvanti:$vaiAvanti,coloreNoiaOmbra: colors["boredom"]!,coloreNoia:colors["boredomshadow"]!)
                    case .sadnessAnimation:
                        Animation(
                            animation: "AnimazioneTristezza",
                            emotionColor: colori["sadness"]!,
                            shadowColor: colori["sadnessshadow"]!,
                            nextView: .sadnessGame
                        )
                    case .sadnessGame:
                    SadnessGame(coloreTriste: colors["sadnessshadow"]!,coloreTristeOmbra: colors["shadow"]!, song: "songysong", image:"dancingAlien")
                    case .canvas(let text, let emozione):
                    ContentView1(text: text, emozione: emozione)
                        .environmentObject(drawingModel)
                    case .diario:
                        DiaryStatsView()
                            .environmentObject(diaryViewModel)
                    case .parentalControl:
                        ParentAccessView()
                    case .parentDashboard:
                        ParentDashboardView()
                            .environmentObject(navManager)
                            .environmentObject(diaryViewModel)
                            .environmentObject(drawingModel)                  
                    case .gallery:
                        DrawingGalleryView()
                    case .skipAngerAnimation:
                    SkipAnimation(emozione: "rabbia", sfondo: colori["sfondo"]!, colore: colori["rabbia"]!, coloreOmbra: colori["rabbiaombra"]!, nextViewAnimazione: .animazioneRabbia, nextViewMinigioco: .minigiocoRabbia)
                        .environmentObject(impostazioniAnimazione)
                        .environmentObject(diaryViewModel)
                    case .skipSadnessAnimation:
                    SaltaAnimazione(emozione : "tristezza", sfondo: colori["sfondo"]!, colore: colori["tristezza"]!, coloreOmbra: colori["tristezzaombra"]!, nextViewAnimazione: .animazioneTristezza, nextViewMinigioco: .minigiocoTristezza)
                        .environmentObject(impostazioniAnimazione)
                        .environmentObject(diaryViewModel)
                    case .skipBoredomAnimation:
                    SaltaAnimazione(emozione : "noia",sfondo: colori["sfondo"]!, colore: colori["noia"]! , coloreOmbra: colori["noiaombra"]!, nextViewAnimazione: .animazioneNoia, nextViewMinigioco: .minigiocoNoia)
                        .environmentObject(impostazioniAnimazione)
                        .environmentObject(diaryViewModel)
                    case .skipFearAnimation:
                    SaltaAnimazione(emozione : "paura",sfondo: colori["sfondo"]!, colore:colori["paura"]!, coloreOmbra: colori["pauraombra"]!, nextViewAnimazione: .animazionePaura, nextViewMinigioco:.minigiocoPaura )
                        .environmentObject(impostazioniAnimazione)
                        .environmentObject(diaryViewModel)
                    case .skipHappinessAnimation:
                    SaltaAnimazione(emozione : "felicità",sfondo: colori["sfondo"]!, colore:colori["felicita"]! , coloreOmbra: colori["felicitaombra"]!, nextViewAnimazione: .animazioneFelicita, nextViewMinigioco: .minigiocoFelicita2)
                        .environmentObject(impostazioniAnimazione)
                        .environmentObject(diaryViewModel)
                    case .animationManager:
                        GestioneAnimazioniView()
                        .environmentObject(settingsAnimation)
                        
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
        .environmentObject(drawingModel)
        .onAppear{
            AppDelegate.instance.requestAuthorization()
        }
    }
}
