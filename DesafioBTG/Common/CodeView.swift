//
//  CodeView.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import Foundation

protocol CodeView {
    func buildVIewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    // TemplateMethod
    func setupView() {
        buildVIewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
