//
//  CurrencieListScreen.swift
//  DesafioBTG
//
//  Created by Fábio França on 26/11/20.
//

import UIKit

class CurrencieListScreen: UIView {
    
    var currencies: [String: String]?
    
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
    
        setupView()
    }
    
    override func didMoveToWindow() {
        self.currenciesTableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var selected:((String)->())?
}

extension CurrencieListScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesKey.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let key = currenciesKey[indexPath.row]
        cell.textLabel?.text = "\(key) - \(currencies![key]!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currencieSelected = currenciesKey[indexPath.row]
        selected!(currencieSelected)
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
