import SwiftUI
import UserNotifications
struct ContentView: View {
    @StateObject var navManager = NavigationManager()
    @StateObject private var diaryViewModel: DiaryViewModel
    @State private var ahead = false
    @StateObject private var drawingModel = DrawingModel()
    @State private var endHappinessGame = false
    @StateObject private var settingsAnimation = AnimationManagementModel()
    
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
                    AngerGame(angerColor: colors["angershadow"]!,angerShadowColor: colors["anger"]!)
                case .happinessAnimation:
                    Animation(
                        animation: "AnimazioneFelicità",
                        emotionColor: colors["happiness"]!,
                        shadowColor: colors["happinessShadow"]!,
                        nextView: .happinessGame
                    )
                case .happinessGame:
                    HappinessGameView(happinessColor: colors["happinessshadow"]!, happinessShadowColor: colors["happiness"]!, backgroundC: colors["background"]!)
                case .fearAnimation:
                    Animation(
                        animation: "AnimazionePaura",
                        emotionColor: colors["fear"]!,
                        shadowColor: colors["fearshadow"]!,
                        nextView: .fearGame
                    )
                case .fearGame:
                    FearGame(fearColor: colors["fearshadow"]!,fearShadowColor:colors["fear"]!)
                case .boredomAnimation:
                    Animation(
                        animation: "AnimazioneNoia",
                        emotionColor: colors["boredom"]!,
                        shadowColor: colors["boredomshadow"]!,
                        nextView: .boredomGame
                    )
                case .boredomGame:
                    BoredomView(ahead:$ahead,boredomShadowColor: colors["boredom"]!,boredomColor:colors["boredomshadow"]!)
                case .sadnessAnimation:
                    Animation(
                        animation: "AnimazioneTristezza",
                        emotionColor: colors["sadness"]!,
                        shadowColor: colors["sadnessshadow"]!,
                        nextView: .sadnessGame
                    )
                case .sadnessGame:
                    SadnessGame(sadnessColor: colors["sadnessshadow"]!,sadnessShadowColor: colors["shadow"]!, song: "songysong", image:"dancingAlien")
                case .canvas(let text, let emotion):
                    ContentView1(text: text, emotion: emotion)
                        .environmentObject(drawingModel)
                case .diary:
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
                    SkipAnimation(emotion: "anger", background: colors["background"]!, animationColor: colors["anger"]!, animationShadowColor: colors["angershadow"]!, nextViewAnimation: .angerAnimation, nextViewGame: .angerGame)
                        .environmentObject(settingsAnimation)
                        .environmentObject(diaryViewModel)
                case .skipSadnessAnimation:
                    SkipAnimation(emotion : "sadness", background: colors["background"]!, animationColor: colors["sadness"]!, animationShadowColor: colors["sadnessshadow"]!, nextViewAnimation: .sadnessAnimation, nextViewGame: .sadnessGame)
                        .environmentObject(settingsAnimation)
                        .environmentObject(diaryViewModel)
                case .skipBoredomAnimation:
                    SkipAnimation(emotion : "boredom",background: colors["background"]!, animationColor: colors["boredom"]! , animationShadowColor: colors["boredomshadow"]!, nextViewAnimation: .boredomAnimation, nextViewGame: .boredomGame)
                        .environmentObject(settingsAnimation)
                        .environmentObject(diaryViewModel)
                case .skipFearAnimation:
                    SkipAnimation(emotion : "fear",background: colors["background"]!, animationColor:colors["fear"]!, animationShadowColor: colors["fearshadow"]!, nextViewAnimation: .fearAnimation, nextViewGame:.fearGame )
                        .environmentObject(settingsAnimation)
                        .environmentObject(diaryViewModel)
                case .skipHappinessAnimation:
                    SkipAnimation(emotion : "happiness",background: colors["background"]!, animationColor:colors["happiness"]! , animationShadowColor: colors["happinessshadow"]!, nextViewAnimation: .happinessAnimation, nextViewGame: .happinessGame)
                        .environmentObject(settingsAnimation)
                        .environmentObject(diaryViewModel)
                case .animationManager:
                    AnimationManagementView()
                        .environmentObject(settingsAnimation)
                case .notificationSettings:
                    NotificationSettingsView()
                    
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
        .environmentObject(drawingModel)
        .onAppear{
            AppDelegate.instance.requestAuthorization()
        }
    }
}

