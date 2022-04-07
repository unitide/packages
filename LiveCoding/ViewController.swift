//
//  ViewController.swift
//  LiveCoding
//
//  Created by Mingyong Zhu on 4/4/22.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    private var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download Images", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 6.0
        button.layer.borderColor = UIColor.red.cgColor

        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showImage)
                         , for: .touchUpInside)
        return button
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        setupUI()
    }
    
    @objc private func showImage(_ sender: UIButton) {
        print("butten is presssed!")
        downloadImage()
    }
    
    private func downloadImage() {
        let urlString = "https://picsum.photos/400/600"
//        if let url = URL(string: urlString) {
//        DispatchQueue.main.async {
//            self.imageView.kf.setImage(with: url)
//        }
//    }
        
        if let url = URL(string: urlString) {
            let _ = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
                if let error = error {
                    print(error)
                }
            }.resume()
        }
    }

    private func setupUI() {
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(downloadButton)
        downloadButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
        downloadButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor).isActive = true
        downloadButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor).isActive = true
        
        self.view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: downloadButton.bottomAnchor,constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor).isActive = true
        
    }

}

