//
//  ConversionScreen.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import UIKit

class ConversionScreen: UIView {
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Futura-Bold", size: 40)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "Currency Converter"
        return titleLabel
    }()
    
    var convertedLabel: UILabel = {
        let convertedLabel = UILabel(frame: .zero)
        convertedLabel.translatesAutoresizingMaskIntoConstraints = false
        convertedLabel.text = "0.00"
        convertedLabel.textAlignment = .center
        convertedLabel.font = UIFont(name: "Futura", size: 30)
        convertedLabel.adjustsFontSizeToFitWidth = true
        return convertedLabel
    }()
    
    var currencieLabel: UILabel = {
        let currencieLabel = UILabel(frame: .zero)
        currencieLabel.translatesAutoresizingMaskIntoConstraints = false
        currencieLabel.textAlignment = .center
        currencieLabel.font = UIFont(name: "Futura", size: 30)
        currencieLabel.text = "United States Dollar"
        currencieLabel.adjustsFontSizeToFitWidth = true
        return currencieLabel
    }()
    
    var originStack: UIStackView = {
        let OriginStack = UIStackView(frame: .zero)
        OriginStack.translatesAutoresizingMaskIntoConstraints = false
        OriginStack.axis = .horizontal
        OriginStack.distribution = .fillEqually
        OriginStack.spacing = 5.0
        return OriginStack
    }()
    
    var destinationStack: UIStackView = {
        let DestinationStack = UIStackView(frame: .zero)
        DestinationStack.translatesAutoresizingMaskIntoConstraints = false
        DestinationStack.axis = .horizontal
        DestinationStack.distribution = .fillEqually
        DestinationStack.spacing = 5.0
        return DestinationStack
    }()
    
    // MARK: -> Fazer uma mascata "0.00"
    var originTF: UITextField = {
        let originTF = UITextField(frame: .zero)
        originTF.translatesAutoresizingMaskIntoConstraints = false
        originTF.isUserInteractionEnabled = true
        originTF.placeholder = "0.00"
        originTF.keyboardType = .numbersAndPunctuation
        originTF.borderStyle = .line
        return originTF
    }()
    
    var originLabel: UILabel = {
        let originLabel = UILabel(frame: .zero)
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        originLabel.text = "Origin Currencie"
        originLabel.font = UIFont(name: "Futura", size: 20)
        originLabel.adjustsFontSizeToFitWidth = true
        return originLabel
    }()
    
    var destinationLabel: UILabel = {
        let destinationLabel = UILabel(frame: .zero)
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        destinationLabel.text = "Destination Currencie"
        destinationLabel.font = UIFont(name: "Futura", size: 20)
        destinationLabel.adjustsFontSizeToFitWidth = true
        return destinationLabel
    }()
    
    // MARK: -> Fazer uma mascata "0.00"
    var destinationTF: UITextField = {
        let destinationTF = UITextField(frame: .zero)
        destinationTF.translatesAutoresizingMaskIntoConstraints = false
        destinationTF.isUserInteractionEnabled = false
        destinationTF.text = "0.00"
        destinationTF.keyboardType = .numberPad
        destinationTF.borderStyle = .line
        return destinationTF
    }()
    
    var originBtn: UIButton = {
        let originBtn = UIButton(frame: .zero)
        originBtn.translatesAutoresizingMaskIntoConstraints = false
        originBtn.isEnabled = true
        originBtn.setTitle("Brazilian Real", for: .normal)
        originBtn.titleLabel?.font = UIFont(name: "Futura", size: 20)
        originBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        originBtn.addTarget(self, action: #selector(originTapped), for: .touchUpInside)
        originBtn.tag = 0
        return originBtn
    }()
    
    var destinationBtn: UIButton = {
        let destinationBtn = UIButton(frame: .zero)
        destinationBtn.translatesAutoresizingMaskIntoConstraints = false
        destinationBtn.isEnabled = true
        destinationBtn.setTitle("United States Dollar", for: .normal)
        destinationBtn.titleLabel?.font = UIFont(name: "Futura", size: 20)
        destinationBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        destinationBtn.addTarget(self, action: #selector(destinationTapped), for: .touchUpInside)
        destinationBtn.tag = 1
        return destinationBtn
    }()
    
    var convertBtn: UIButton = {
        let convertBtn = UIButton(frame: .zero)
        convertBtn.translatesAutoresizingMaskIntoConstraints = false
        convertBtn.isEnabled = true
        convertBtn.setTitle("Converts", for: .normal)
        convertBtn.titleLabel?.font = UIFont(name: "Futura", size: 20)
        convertBtn.titleLabel?.textAlignment = .center
        convertBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        convertBtn.addTarget(self, action: #selector(convertTapped), for: .touchUpInside)
        convertBtn.tag = 2
        return convertBtn
    }()
    
    var loadingScreen: LoadingScreen = {
        let loadingScreen = LoadingScreen(frame: .zero)
        loadingScreen.translatesAutoresizingMaskIntoConstraints = false
        return loadingScreen
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.937254902, blue: 0.9529411765, alpha: 1)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        originTF.text = "1"
        
    }
    
    var originKey: String?
    var destinationKey: String?
    
    var destination:((Int)->())?
    var origin:((Int)->())?
    var convert:((Double, String, String)->())?
    
    @objc func destinationTapped(sender: UIButton) {
        destination!(sender.tag)
    }
    
    @objc func originTapped(sender: UIButton) {
        origin!(sender.tag)
    }
    
    @objc func convertTapped(sender: UIButton = UIButton()) {
        originTF.text = originTF.text?.replacingOccurrences(of: ",", with: ".")
        if let valueOrigin = originTF.text!.isEmpty ? 0.0 : Double(originTF.text ?? "0.0") {
            convert!(valueOrigin,originKey!,destinationKey!)
        } else {
            originTF.text = "1"
            convert!(1,originKey!,destinationKey!)
        }
    }
    
    func changeBtnTitle(key: String, value: String, buttonTag: Int) {
        if buttonTag == 0 {
            originKey = key
            originBtn.setTitle("\(key) - \(value)", for: .normal)
        }else if buttonTag == 1 {
            destinationKey = key
            destinationBtn.setTitle("\(key) - \(value)", for: .normal)
        }
    }
    
    func valueWasConverted(convertedValue: Double) {
        self.convertedLabel.text = "\(convertedValue)"
        self.destinationTF.text = "\(convertedValue)"
    }
    
    func loading(_ isLoading: Bool) {
        if isLoading {
            titleLabel.isHidden = true
            convertedLabel.isHidden = true
            currencieLabel.isHidden = true
            originStack.isHidden = true
            originTF.isHidden = true
            originBtn.isHidden = true
            destinationStack.isHidden = true
            destinationTF.isHidden = true
            destinationBtn.isHidden = true
            originLabel.isHidden = true
            destinationLabel.isHidden = true
            convertBtn.isHidden = true
            loadingScreen.isHidden = true
            loadingScreen.isHidden = false
        }else{
            titleLabel.isHidden = false
            //convertedLabel.isHidden = false
            //currencieLabel.isHidden = false
            originStack.isHidden = false
            originTF.isHidden = false
            originBtn.isHidden = false
            destinationStack.isHidden = false
            destinationTF.isHidden = false
            destinationBtn.isHidden = false
            originLabel.isHidden = false
            destinationLabel.isHidden = false
            convertBtn.isHidden = false
            loadingScreen.isHidden = false
            loadingScreen.isHidden = true
        }
    }
}

extension ConversionScreen: CodeView {
    func buildVIewHierarchy() {
        addSubview(titleLabel)
        addSubview(convertedLabel)
        addSubview(currencieLabel)
        addSubview(originStack)
        originStack.addArrangedSubview(originTF)
        originStack.addArrangedSubview(originBtn)
        addSubview(destinationStack)
        destinationStack.addArrangedSubview(destinationTF)
        destinationStack.addArrangedSubview(destinationBtn)
        addSubview(originLabel)
        addSubview(destinationLabel)
        addSubview(convertBtn)
        addSubview(loadingScreen)
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            
            originLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            originLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            originLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            originStack.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 5),
            originStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            originStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            originStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            
            destinationLabel.topAnchor.constraint(equalTo: originStack.bottomAnchor, constant: 10),
            destinationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            destinationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            destinationStack.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor, constant: 5),
            destinationStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            destinationStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            destinationStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            
            convertBtn.topAnchor.constraint(equalTo: destinationStack.bottomAnchor, constant: 10),
            convertBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            convertBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            convertBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07),
            
            convertedLabel.topAnchor.constraint(equalTo: convertBtn.bottomAnchor, constant: 30),
            convertedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            convertedLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            convertedLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.09),
            
            currencieLabel.topAnchor.constraint(equalTo: convertBtn.bottomAnchor, constant: 30),
            currencieLabel.leadingAnchor.constraint(equalTo: self.convertedLabel.trailingAnchor, constant: 5),
            currencieLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            currencieLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.09),
            
            loadingScreen.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            loadingScreen.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loadingScreen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loadingScreen.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        originBtn.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.4039215686, blue: 0.662745098, alpha: 1)
        destinationTF.backgroundColor = .systemGray3
        originTF.backgroundColor = .white
        destinationBtn.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.4039215686, blue: 0.662745098, alpha: 1)
        convertBtn.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.4039215686, blue: 0.662745098, alpha: 1)
    }
}
