//
//  PageMenuControllerOption.swift
//  MovieApp
//
//  Created by webwerks on 28/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
import PagingMenuController

struct MenuItemNowPlaying: MenuItemViewCustomizable {}
struct MenuItemUpcoming: MenuItemViewCustomizable {}


struct PagingMenuOptions1: PagingMenuControllerCustomizable {
    let nowPlayingVC =  NowPlayingMovieViewController.instantiateFromStoryboard()
    let comingSoomVC = CommingSoonMoviewViewController.instantiateFromStoryboard()
    
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: [nowPlayingVC, comingSoomVC])
    }
    var lazyLoadingPage: LazyLoadingPage {
        return .all
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var focusMode: MenuFocusMode {
            return .roundRect(radius: 6, horizontalPadding: 8, verticalPadding: 8, selectedColor: UIColor.lightGray)
        }
        var height: CGFloat {
            return 55
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2()]
        }
    }
    
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "Now Playing"))
        }
    }
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "Coming Soon"))
        }
    }
}
