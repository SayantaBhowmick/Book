//
//  ViewController.swift
//  Book
//
//  Created by Hanriver Macbook on 08/06/24.
//

import UIKit

class SplashController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "BookListController") as! BookListController
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }


}

