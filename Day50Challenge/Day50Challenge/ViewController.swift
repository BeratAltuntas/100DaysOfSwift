//
//  ViewController.swift
//  Day50Challenge
//
//  Created by BERAT ALTUNTAŞ on 27.02.2022.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var imageView: UIImageView!
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddPhotos))
        let defaults = UserDefaults.standard
        
        if let savedPhotos = defaults.object(forKey: "Photos") as? Data{
            if let decodedPhotos = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPhotos) as? [Photo]{
                photos = decodedPhotos
                print("savedPhotos")
            }
        }
        tableView.reloadData()
    }

    @objc func AddPhotos(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        //picker.sourceType = .camera  gerçek cihazım olmadığı için hata veriyor sanal cihazda
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else{return}
               
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        var tempImageTitle = ""
        
        if let jpgData = image.jpegData(compressionQuality: 0.8){
           try? jpgData.write(to: imagePath)
        }
        let ac = UIAlertController(title: "İsim Giriniz", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let textField = UIAlertAction(title: "Tamam", style: .default,handler:{
            [weak self, weak ac] _ in
            guard let imgTitle = ac?.textFields?[0].text else{return}
            tempImageTitle = imgTitle
            let img = Photo(title:tempImageTitle, imageUrl: imageName,date: (self?.GetDate())!)
            self?.photos.append(img)
            self?.SavePhotos()
            self?.tableView.reloadData()
        })
        ac.addAction(textField)
       
        dismiss(animated: true)
        present(ac,animated: true)
        
        tableView.reloadData()
    }
    
    func getDocumentsDirectory() ->URL{
          let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
          return paths[0]
    }
    
    func GetDate()->String{
        let date = Date()
//        let calendar = Calendar.current
//        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
        return date.formatted(date: .numeric, time: .standard)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTitle", for: indexPath)
        cell.textLabel?.text = photos[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc=storyboard?.instantiateViewController(withIdentifier: "SeePhoto")as? PhotosViewController
        {
            vc.selectedPhotoUrl = photos[indexPath.row].imageUrl
            vc.selectedImageTitle = photos[indexPath.row].title
            vc.selectedImageDate = photos[indexPath.row].date
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func SavePhotos(){
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: photos, requiringSecureCoding: false){
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "Photos")
        }
    }
}

