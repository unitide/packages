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
        button.addTarget(self, action: #selector(showImage(_:))
                         , for: .touchUpInside)
        return button
    }()
    
    private var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Images", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 6.0
        button.layer.borderColor = UIColor.red.cgColor

        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeImage(_:))
                         , for: .touchUpInside)
        return button
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bundle = Bundle.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        
        setupUI()
        
        print(bundle.resourceURL!)
        print(bundle.resourcePath!)
        
        if let image = UIImage(named: "eugene-golovesov-pph10lc5QK0-unsplash.jpg") {
            imageView.image = image
        }

    }
    
    @objc private func showImage(_ sender: UIButton) {
       // downloadImage()
        showLocalImage()
    }
    
    @objc private func changeImage(_ sender: UIButton) {
       // downloadImage()
        let image = self.imageView.image!
        let imageTitled = image.resizableImage(withCapInsets: UIEdgeInsets(top: image.size.height/4.0, left: image.size.width/4.0, bottom: image.size.height/4.0, right: image.size.width/4.0), resizingMode: .tile)
        self.imageView.image = imageTitled
    }
    
    private func showLocalImage(){
        let imagePaths = bundle.paths(forResourcesOfType: ".jpg", inDirectory: "")
        
        let randomInt = Int.random(in: 0 ..< imagePaths.count)
        let path = imagePaths[randomInt]
        let name = (path.split(separator: "/")).last!
        
        let image = UIImage(named: String(name))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
    }
    
    private func downloadImage() {
        let urlString = "https://picsum.photos/400/600"
        
        
        
        if let url = URL(string: urlString) {
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: url,options: [.forceRefresh])
        }
    }
        
//        if let url = URL(string: urlString) {
//            let _ = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//                if let data = data {
//                    DispatchQueue.main.async {
//                        self?.imageView.image = UIImage(data: data)
//                    }
//                }
//                if let error = error {
//                    print(error)
//                }
//            }.resume()
//        }
    }

    private func setupUI() {
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        stackView.addArrangedSubview(downloadButton)
        stackView.addArrangedSubview(changeButton)
        
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor,constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor,constant: -20).isActive = true
        
        
        self.view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor).isActive = true
        
    }

}

