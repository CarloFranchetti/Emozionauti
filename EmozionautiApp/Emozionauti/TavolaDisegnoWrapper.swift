import SwiftUI

struct TavolaDisegnoWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TavolaDisegno {
        return TavolaDisegno()
    }
    
    func updateUIViewController(_ uiViewController: TavolaDisegno, context: Context) {
        // eventuali aggiornamenti
    }
}
