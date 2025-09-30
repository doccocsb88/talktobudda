//
//  MeditationTimerRoutable.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import UIKit


protocol MeditationTimerRoutable: AnyObject {
    func dismiss()
}

final class MeditationTimerRouter: MeditationTimerRoutable {
    weak var viewController: UIViewController?
    static func createModule() -> UIViewController {
        let view = MeditationTimerViewController()
               let presenter = MeditationTimerPresenter()
               let interactor = MeditationTimerInteractor()
               let router = MeditationTimerRouter()

               view.presenter = presenter

               presenter.view = view
               presenter.interactor = interactor
               presenter.router = router

               interactor.output = presenter
               router.viewController = view

               return view
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
