//
//  LoadingScreen.swift
//  DesafioBTG
//
//  Created by Fábio França on 26/11/20.
//

import UIKit

class LoadingScreen: UIView {
    
    var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingScreen: CodeView {
    func buildVIewHierarchy() {
        addSubview(indicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor?.withAlphaComponent(0.6)
    }
}
