//
//  ViewController.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = CurrencyLayerAPI(manager: RequestManagerFactory.urlsession.create())
        
        request.getCurrencie { (response) in
            switch response {
            case .success(let currencie):
                print(currencie.success)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }


}

