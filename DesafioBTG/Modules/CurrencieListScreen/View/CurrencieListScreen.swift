//
//  CurrencieListScreen.swift
//  DesafioBTG
//
//  Created by Fábio França on 26/11/20.
//

import UIKit

class CurrencieListScreen: UIView {
    
    var currencies: [String: String]?
    
    var currenciesValue = [String]()
    var currenciesKey = [String]()
    
    
    var currenciesTableView: UITableView = {
        let currenciesTableView = UITableView(frame: .zero)
        currenciesTableView.translatesAutoresizingMaskIntoConstraints = false
        currenciesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return currenciesTableView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.currenciesTableView.delegate = self
        self.currenciesTableView.dataSource = self
    
        print(currencies)
        setupView()
    }
    
    override func didMoveToWindow() {
        print(currencies)
        if let currencies = currencies {
            for(key,value) in currencies {
                currenciesValue.append(value)
                currenciesKey.append(key)
            }
        }
        self.currenciesValue = currenciesValue.sorted{ $0 < $1 }
        self.currenciesKey = currenciesKey.sorted{ $0 < $1 }
        self.currenciesTableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencieListScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(currenciesKey[indexPath.row]) - \(currenciesValue[indexPath.row])"
        return cell
    }
    
    
}

extension CurrencieListScreen: CodeView {
    func buildVIewHierarchy() {
        addSubview(currenciesTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            currenciesTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            currenciesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            currenciesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            currenciesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        currenciesTableView.backgroundColor = .clear
    }
}
