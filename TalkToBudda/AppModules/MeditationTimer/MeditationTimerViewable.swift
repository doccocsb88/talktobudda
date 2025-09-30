//
//  MeditationTimerViewable.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

protocol MeditationTimerViewable: AnyObject {
    var presenter: MeditationTimerPresentable? { get set }
    func updateTimerDisplay(timeString: String)
    func showMeditationTitle(_ title: String)
}
