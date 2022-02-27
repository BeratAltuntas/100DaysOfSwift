//
//  Photos.swift
//  Day50Challenge
//
//  Created by BERAT ALTUNTAŞ on 27.02.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var imageView: UIImageView!
    var selectedPhotoUrl:String = ""
    var selectedImageTitle:String = ""
    var selectedImageDate:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = """
        Resim İsmi        : \(selectedImageTitle)
        Oluşturulma zamanı: \(selectedImageDate)
        """
        let path = getDocumentsDirectory().appendingPathComponent(selectedPhotoUrl)
        
        imageView.image = UIImage(contentsOfFile: path.path)
        imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 3
        

    }
    func getDocumentsDirectory() ->URL{
          let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
          return paths[0]
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
