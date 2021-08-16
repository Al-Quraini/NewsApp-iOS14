//
//  tabBarController.swift
//  NewsApp
//
//  Created by Mohammed Al-Quraini on 7/24/21.
//

import UIKit

class tabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My News"

        // Do any additional setup after loading the view.
        self.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print(item.title)
    }

    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController {
        case is FavouritesViewController:
            navigationItem.title = FavouritesViewController.navigationTitle
            
        case is NewsViewController:
            navigationItem.title = NewsViewController.navigationTitle
        default:
            navigationItem.title = "My News"
        }
    }

}
