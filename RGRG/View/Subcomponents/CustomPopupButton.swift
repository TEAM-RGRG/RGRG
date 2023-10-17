//
//  CustomPopupButton.swift
//  RGRG
//
//  Created by (^ㅗ^)7 iMac on 10/17/23.
//

import UIKit

final class CustomBarButton: UIBarButtonItem {
    override init() {
        super.init()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomBarButton {
    func makeBarButtonItem(imageName: String, menu: UIMenu) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: UIImage(systemName: imageName), primaryAction: nil, menu: menu)
        return item
    }
}

// MARK: - Making Pop-Up Button

extension CustomBarButton {
    func makeUIMenu(title: String, opetions: UIMenu.Options, uiActions: [UIAction]) -> UIMenu {
        let menu = UIMenu(title: title, options: opetions, children: [
            UIDeferredMenuElement.uncached { [weak self] completion in
                guard let self = self else { return }
                let actions = uiActions
                completion(actions)
            }
        ])

        return menu
    }

    func makeSingleAction(title: String, state: UIMenuElement.State, handler: @escaping UIActionHandler) -> UIAction {
        let action = UIAction(title: title, image: nil, state: state, handler: handler)
        return action
    }
}
