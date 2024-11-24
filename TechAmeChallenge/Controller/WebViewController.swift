//
//  File.swift
//  TechAmeChallenge
//
//  Created by Henrique on 23/11/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var urlString: String?
    
    init(urlString: String = "www.google.com") {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let backBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        if let urlString = urlString, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        
        setupBackBtn()
    
    }
    
    func setupBackBtn(){
        view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        NSLayoutConstraint.activate([
            backBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14)
        ])
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
