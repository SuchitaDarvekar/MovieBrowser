//
//  HomeViewController.swift
//  MovieApp
//
//  Created by webwerks on 25/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit
import Alamofire
import PagingMenuController
import SDWebImage


class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageMenu()
        view.backgroundColor = UIColor.white

    }
    
    func setupPageMenu(){
        let options = PagingMenuOptions1()
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .didMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case .didScrollStart:
                print("Scroll start")
            case .didScrollEnd:
                print("Scroll end")
            }
        }
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
    }
}


