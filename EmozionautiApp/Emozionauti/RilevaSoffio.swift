//
//  RilevaSoffio.swift
//  Emozionauti
//
//  Created by Studente on 04/07/25.
//

/*La classe permette di attivare il microfono, misurare il volume dell'audio e
 *riconsocere il soffio tramite un filtro passa-basso*/

import AVFAudio
import Foundation

class RilevaSoffio: NSObject, ObservableObject{
    var registratore: AVAudioRecorder!
    var timer: Timer?
    @Published var risultatopassaBasso: Double = 0.0
    let a: Double = 0.05
    
    //avvia la registrazione, tramite il costruttore
    override init(){
        super.init()
        avviaRegistratore()
    }
    
    //richiesta permessi
    private func avviaRegistratore(){
        let sessioneAudioSession = AVAudioSession.sharedInstance()
        do{
            try sessioneAudioSession.setCategory(.playAndRecord, mode: .default)
            try sessioneAudioSession.setActive(true)
            //DispatchQueue.main è un thread asincrono
            AVAudioApplication.requestRecordPermission{ [weak self] allowed in DispatchQueue.main.async{
                if allowed{
                    self?.inizializzaRec()
                }else{
                    print("Permesso al microfono negato")
                }
            }
            }
        }catch{
            print("Errore nella configurazione della sessione audio")
        }
    }
    
    private func inizializzaRec(){
        let impostazioni: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey:1,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        //il file audio non viene salvato
        let url = URL(fileURLWithPath: "/dev/null")
        do{
            registratore = try AVAudioRecorder(url: url, settings: impostazioni)
            registratore.isMeteringEnabled = true
            registratore.record()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ [self] _ in
                self.aggiornaVol()
            }
        }catch{
            print("Errore nell'inizializzazione")
        }
    }
    
      func aggiornaVol() -> Bool{
        registratore.updateMeters()
        let potenza = registratore.averagePower(forChannel: 0)
          if potenza >= 70.0 {
             return true
         }
          else{
              return false
          }
    }
    
    func ferma(){
        registratore?.stop()
        timer?.invalidate()
        timer = nil
    }
    

}
