//
//  ViewController.swift
//  LVPopup
//
//  Created by levivig on 09/28/2019.
//  Copyright (c) 2019 levivig. All rights reserved.
//

import LVPopup
import UIKit

class ViewController: UIViewController {
    
    private var popup: PopupViewController!
    private var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = UIButton()
        button.setTitle("Show!", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        button.center = view.center
        button.addTarget(self, action: #selector(showPopup), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func showPopup() {
        let button1 = RoundButtonAction(title: "Helloo", action: { [weak self] in
            print("Helloo")
            self?.popup.hidePopup()
        })
        
        let button2 = RoundButtonAction(title: "Test", action: {
            print("Test")
        })
        
        popup = popupWithImage(with: button1, button2: button2)
        
        popup.view.alpha = 0.0
        popup.modalPresentationStyle = .overFullScreen
        present(popup, animated: false, completion: { [weak self] in
            UIView.animate(withDuration: 0.3) {
                self?.popup.view.alpha = 1.0
            }
        })
    }
    
    private func popupWithOneButton(with button1: RoundButtonBindable) -> PopupViewController {
        let popup = PopupViewController(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                        descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam quis consequat sem, in consequat ligula. Donec non tortor id dolor pharetra lacinia non non felis. Quisque malesuada nec risus sed tristique. Curabitur nec est non magna euismod tincidunt nec in magna. Integer pretium, nisl a luctus interdum, justo justo cursus lacus, sed mollis ipsum urna ut ante. Nunc efficitur varius lectus, at hendrerit arcu feugiat a. Nullam non lectus non ligula iaculis rhoncus sit amet in eros. Nullam luctus ex sit amet justo mattis, sit amet fermentum arcu viverra. Aliquam pellentesque vitae ante ut vestibulum. Nullam fermentum pulvinar mauris quis blandit.",
                                        leftButtonModel: button1)
        
        return popup
    }
    
    private func popupWithTowButtons(with button1: RoundButtonBindable, button2: RoundButtonBindable) -> PopupViewController {
        let popup = PopupViewController(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                        subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam quis consequat sem, in consequat ligula. Donec non tortor id dolor pharetra lacinia non non felis.",
                                        descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam quis consequat sem, in consequat ligula. Donec non tortor id dolor pharetra lacinia non non felis. Quisque malesuada nec risus sed tristique. Curabitur nec est non magna euismod tincidunt nec in magna. Integer pretium, nisl a luctus interdum, justo justo cursus lacus, sed mollis ipsum urna ut ante. Nunc efficitur varius lectus, at hendrerit arcu feugiat a. Nullam non lectus non ligula iaculis rhoncus sit amet in eros. Nullam luctus ex sit amet justo mattis, sit amet fermentum arcu viverra. Aliquam pellentesque vitae ante ut vestibulum. Nullam fermentum pulvinar mauris quis blandit.",
                                        leftButtonModel: button1,
                                        rightButtonModel: button2)
        
        return popup
    }
    
    private func popupWithImage(with button1: RoundButtonBindable, button2: RoundButtonBindable) -> PopupViewController {
        let popup = PopupViewController(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                        subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam quis consequat sem, in consequat ligula. Donec non tortor id dolor pharetra lacinia non non felis.",
                                        descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam quis consequat sem, in consequat ligula. Donec non tortor id dolor pharetra lacinia non non felis. Quisque malesuada nec risus sed tristique. Curabitur nec est non magna euismod tincidunt nec in magna. Integer pretium, nisl a luctus interdum, justo justo cursus lacus, sed mollis ipsum urna ut ante. Nunc efficitur varius lectus, at hendrerit arcu feugiat a. Nullam non lectus non ligula iaculis rhoncus sit amet in eros. Nullam luctus ex sit amet justo mattis, sit amet fermentum arcu viverra. Aliquam pellentesque vitae ante ut vestibulum. Nullam fermentum pulvinar mauris quis blandit.",
                                        leftButtonModel: button1,
                                        rightButtonModel: button2,
                                        image: UIImage(named: "ohno"))
        
        return popup
    }
}

