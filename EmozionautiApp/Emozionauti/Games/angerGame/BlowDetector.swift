//
//  BlowDetector.swift
//  Emozionauti
//
//  Created by Studente on 04/07/25.
//


import AVFAudio
import Foundation

class BlowDetector: NSObject, ObservableObject{
    var recorder: AVAudioRecorder!
    var timer: Timer?
    let a: Double = 0.05
    

    override init(){
        super.init()
        startRecording()
    }
    

    private func startRecording(){
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            AVAudioApplication.requestRecordPermission{ [weak self] allowed in DispatchQueue.main.async{
                if allowed{
                    self?.initializeRecording()
                }else{
                    print("Permesso al microfono negato")
                }
            }
            }
        }catch{
            print("Errore nella configurazione della sessione audio")
        }
    }
    
    private func initializeRecording(){
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey:1,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        //il file audio non viene salvato
        let url = URL(fileURLWithPath: "/dev/null")
        do{
            recorder = try AVAudioRecorder(url: url, settings: settings)
            recorder.isMeteringEnabled = true
            recorder.record()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ [self] _ in
                self.updateMeasures()
            }
        }catch{
            print("Errore nell'inizializzazione")
        }
    }
    
      func updateMeasures() -> Bool{
        recorder.updateMeters()
        let power = recorder.averagePower(forChannel: 0)
          if power >= -25.0 && power <= 10.0{
             return true
         }
          else{
              return false
          }
    }
    
    func stop(){
        recorder?.stop()
        timer?.invalidate()
        timer = nil
    }
    

}
