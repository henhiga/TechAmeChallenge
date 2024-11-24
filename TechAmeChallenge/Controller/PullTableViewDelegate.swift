//
//  PullTableViewDelegate.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation
import UIKit

class PullTableViewDelegate: NSObject, UITableViewDelegate {
    
    var pulls: [Pull]
    
    weak var navigationController: UINavigationController?
    weak var view: UIViewController?
    
    init(pulls: [Pull], navigationController: UINavigationController) {
        self.pulls = pulls
        self.navigationController = navigationController
    }
    
    func setPulls(pulls: [Pull]){
        self.pulls = pulls
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let webViewController = WebViewController(urlString: pulls[indexPath.row].url)
        webViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.viewControllers[1].present(webViewController, animated: true)
    }
    
    func modifyString(url: String)->String{
        let modifiedString = url
            .replacingOccurrences(of: "api.", with: "")
            .replacingOccurrences(of: "/repos", with: "")
        return modifiedString
    }
}
