import SwiftUI

struct ContentView: View {
    @StateObject var navManager = NavigationManager()

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
        "tristezzaombra": Color(red:19/255,green:43/255,blue:137/255)
    ]

    var body: some View {
        ZStack {
            if navManager.showHome {
                NavigationStack {
                    SchermataHome(coloriEmozioni: colori)
                }
            } else {
                SchermataIcona()
            }
        }
        .environmentObject(navManager)
    }
}
