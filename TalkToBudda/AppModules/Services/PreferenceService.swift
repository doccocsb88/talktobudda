//
//  PreferenceService.swift
//  TalkToBudda
//
//  Created by mac on 11/5/25.
//

import Foundation

class PreferenceService {
    enum Keys {
        static let isShowedOnboarding = "is_showed_onboarding"
        static let mediationBackgroundSound = "meditation_background_sound"

    }
    
    var isShowedOnboarding: Bool {
        get {
            userDefault.bool(forKey: Keys.isShowedOnboarding)
        }
        
        set {
            userDefault.set(newValue, forKey: Keys.isShowedOnboarding)
            userDefault.synchronize()
        }
    }
    
    
    var meditationSound: SoundCodable {
        
        get {
            if let data =  userDefault.data(forKey: Keys.mediationBackgroundSound) {
                return (try? JSONDecoder().decode(SoundCodable.self, from: data)) ?? .default
            }
            
            return .default
        }
        
        set {
            let data = try? JSONEncoder().encode(newValue)
            userDefault.set(data, forKey: Keys.mediationBackgroundSound)
        }
    }
    private let userDefault = UserDefaults.standard
    static let shared = PreferenceService()
}
