//
//  EditorViewController.swift
//  vk-image-editor
//
//  Created by Александр on 25.04.2021.
//

import UIKit
import DropDown

class EditorViewController: UIViewController {

    var originalImage: UIImage
    var images: [UIImage] = []
    var currentImage: UIImage {
        return images.last!
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    init(image: UIImage) {
        self.originalImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let goBackBarButton = UIBarButtonItem.init(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(onDidBackTapped))
        let saveBarButton = UIBarButtonItem.init(image: UIImage(named: "upload"), style: .plain, target: self, action: #selector(onDidUploadTapped))
        self.navigationItem.setRightBarButtonItems([saveBarButton, goBackBarButton], animated: true)
        images.append(originalImage)
        self.imageView.image = currentImage
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "VK Editor"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0.01749700122, green: 0.02918634377, blue: 0.0702014491, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // MARK: - Actions
    
    @IBAction func onDidHorizotalFlipped(_ sender: Any) {
        let flippedImage = self.currentImage.withHorizontallyFlippedOrientation()
        images.append(flippedImage)
        self.imageView.image = currentImage
    }
    
    @IBAction func onDidTextAdded(_ sender: Any) {
    }
    
    @IBAction func onDidFilterTapped(_ sender: UIButton) {
        let dropDown = DropDown.init(anchorView: sender)
        let filters = EditorService.filters
        dropDown.dataSource = filters.map({ $0.rawValue.replacingOccurrences(of: "CIPhotoEffect", with: "") })
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let filter = filters[index]
            let filterImage = self.currentImage.addFilter(filter: filter)
            self.images.append(filterImage)
            self.imageView.image = self.currentImage
        }
        dropDown.show()
    }
    
    @objc func onDidBackTapped() {
        if self.images.count > 1 {
            self.images.removeLast(1)
            self.imageView.image = currentImage
        }
    }
    
    @objc func onDidUploadTapped() {
        let items = [self.currentImage]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
