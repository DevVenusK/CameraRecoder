//
//  ViewController.swift
//  CameraRecoder
//
//  Created by Ppop on 2022/01/14.
//

import UIKit

final class ViewController: UIViewController {

    struct Dependency {
        let cameraRecoder: CameraRecoderProtocol
    }
    
    private let dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildButtonStackView()
        dependency.cameraRecoder.previewLayer.frame = view.bounds
        view.layer.addSublayer(dependency.cameraRecoder.previewLayer)
    }
}

extension ViewController {
    private func buildButtonStackView() {
        let startButton: UIButton = {
            let button = UIButton()
            button.setTitle("시작",
                            for: .normal)
            button.setTitleColor(.blue,
                                 for: .normal)
            button.addTarget(self,
                             action: #selector(didTapStartButton),
                             for: .touchUpInside)
            return button
        }()
        
        let stopButton: UIButton = {
            let button = UIButton()
            button.setTitle("종료",
                            for: .normal)
            button.setTitleColor(.blue,
                                 for: .normal)
            button.addTarget(self,
                             action: #selector(didTapStopButton),
                             for: .touchUpInside)
            return button
        }()
        
        let buttonStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        buttonStackView.addArrangedSubview(startButton)
        buttonStackView.addArrangedSubview(stopButton)
        
        view.addSubview(buttonStackView)
        
        [buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         buttonStackView.heightAnchor.constraint(equalToConstant: 44)]
            .forEach { $0.isActive = true }
    }
}

extension ViewController {
    @objc private func didTapStartButton() {
        dependency.cameraRecoder.startRecording()
    }
    
    @objc private func didTapStopButton() {
        dependency.cameraRecoder.stopRecording()
    }
}
