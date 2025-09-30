//
//  MeditationAudioPlayer.swift
//  TalkToBudda
//
//  Created by mac on 7/5/25.
//

import AVFoundation
import RxSwift
import RxRelay

enum MeditationAudioState {
    case playing
    case paused
    case stopped
}

class MeditationAudioPlayer {
    static let shared = MeditationAudioPlayer()
    
    private var audioPlayer: AVAudioPlayer?
    private var isMuted: Bool = false {
        didSet {
            muteSubject.onNext(isMuted)
        }
    }
    
    private var currentVolume: Float = 1.0
    let stateSubject = BehaviorSubject<MeditationAudioState>(value: .stopped)
    let muteSubject = BehaviorSubject<Bool>(value: false)
    let soundSubject = PublishSubject<SoundCodable>()
    init() {}

    // MARK: - Play Audio
    func playMeditationSound(sound: SoundCodable) {
        guard let url = Bundle.main.url(forResource: sound.name, withExtension: nil) else {
            print("Không tìm thấy file âm thanh.")
            return
        }
        
        soundSubject.onNext(sound)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Lặp vô hạn
            audioPlayer?.volume = isMuted ? 0 : currentVolume
            audioPlayer?.play()
            stateSubject.onNext(.playing)

            print("Âm thanh đang phát...")
        } catch {
            print("Lỗi phát âm: \(error.localizedDescription)")
        }
    }

    // MARK: - Play / Pause
    func togglePlayPause() {
        guard let player = audioPlayer else { return }
        
        if player.isPlaying {
            player.pause()
            print("Âm thanh đã tạm dừng.")
            stateSubject.onNext(.paused)

        } else {
            player.play()
            stateSubject.onNext(.playing)
            print("Âm thanh tiếp tục phát.")
        }
    }
    
    func pause() {
        guard let player = audioPlayer else { return }
        player.pause()
        stateSubject.onNext(.paused)
    }
    
    func play() {
        guard let player = audioPlayer else { return }
        player.play()
        stateSubject.onNext(.playing)
    }
    
    // MARK: - Mute / Unmute
    func toggleMute() {
        isMuted.toggle()
        audioPlayer?.volume = isMuted ? 0 : currentVolume
        print(isMuted ? "Âm thanh đã tắt." : "Âm thanh đã bật.")
    }
    
    // MARK: - Set Volume (0.0 to 1.0)
    func setVolume(_ volume: Float) {
        guard (0.0...1.0).contains(volume) else {
            print("Volume phải nằm trong khoảng từ 0.0 đến 1.0")
            return
        }
        currentVolume = volume
        if !isMuted {
            audioPlayer?.volume = volume
        }
        print("Âm lượng đã thay đổi: \(volume * 100)%")
    }
    
    // MARK: - Stop Audio
    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
        stateSubject.onNext(.stopped)
        print("Đã dừng phát âm thanh.")
    }
    
    // MARK: - save sound
    
    func save(sound: SoundCodable) {
        UserDefaults.standard.set(sound, forKey: "")
    }
}
