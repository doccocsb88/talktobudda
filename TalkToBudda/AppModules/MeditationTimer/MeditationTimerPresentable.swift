//
//  MeditationTimerPresentable.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import Foundation

protocol MeditationTimerPresentable: AnyObject {
    var quotes: [QuoteCodable] { get set }
    func viewDidLoad()
    func didTapPause()
    func didTapStop()
    func didTapBack()
}

final class MeditationTimerPresenter: MeditationTimerPresentable {
    weak var view: MeditationTimerViewable?
    var interactor: MeditationTimerInteractable?
    var router: MeditationTimerRoutable?
    var quotes: [QuoteCodable] = []

    func viewDidLoad() {
        view?.showMeditationTitle("Breathing Meditation")
        interactor?.startTimer()
        loadQuote()
        let sound = PreferenceService.shared.meditationSound
        MeditationAudioPlayer.shared.playMeditationSound(sound: sound)
    }

    func didTapPause() {
        MeditationAudioPlayer.shared.togglePlayPause()
        interactor?.pauseTimer()
    }

    func didTapStop() {
        MeditationAudioPlayer.shared.pause()
        interactor?.stopTimer()
    }
    
    func didTapBack() {
        MeditationAudioPlayer.shared.stop()
    }
    
    func loadQuote() {
        guard let url = Bundle.main.url(forResource: "buddha_quotes_100", withExtension: "json") else {
            return
        }
        
        guard let data = try? Data(contentsOf: url) else { return }
        quotes = (try? JSONDecoder().decode([QuoteCodable].self, from: data)) ?? []
    }
    
}


extension MeditationTimerPresenter: MeditationTimerInteractorOutput {
    func timerUpdated(to timeString: String) {
        view?.updateTimerDisplay(timeString: timeString)
    }
}
