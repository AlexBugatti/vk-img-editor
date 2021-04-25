//
//  MainViewController.swift
//  vk-image-editor
//
//  Created by Александр on 25.04.2021.
//

import UIKit

class MainViewController: UIViewController {

    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        // Do any additional setup after loading the view.
    }

    @IBAction func onDidPickerTapped(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
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
    
    func openEditor(image: UIImage) {
        let vc = EditorViewController.init(image: image)
        self.navigationController?.pushViewController(vc, animated: false)
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

extension MainViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        if let image = image {
            self.openEditor(image: image)
        }
    }
    
}
