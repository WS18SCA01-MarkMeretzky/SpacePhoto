//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Mark Meretzky on 3/3/19.
//  Copyright © 2019 New York University School of Professional Studies. All rights reserved.
//

import UIKit;

class ViewController: UIViewController {
    let photoInfoController: PhotoInfoController = PhotoInfoController();   //p. 881

    @IBOutlet weak var imageView: UIImageView!;
    @IBOutlet weak var descriptionLabel: UILabel!;
    @IBOutlet weak var copyrightLabel: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        
        descriptionLabel.text = "";
        copyrightLabel.text = "";
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;   //p. 891
        
        photoInfoController.fetchPhotoInfo {(photoInfo: PhotoInfo?) in   //p. 881
            guard let photoInfo: PhotoInfo = photoInfo else {
                return;
            }
            
            self.updateUI(with: photoInfo);
        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {   //pp. 885-886
        
        guard let url: URL = photoInfo.url.withHTTPS() else {   //p. 889
            fatalError("could not change the scheme to https");
        }
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data: Data = data else {
                fatalError("no photo data was returned");
            }
            
            switch photoInfo.mediaType {
            case "video":   //p. 890
                DispatchQueue.main.async {
                    UIApplication.shared.open(photoInfo.url) {(b: Bool) in
                        print("opened, b = \(b)");
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false; //p. 891
                    }
                }
                
            case "image":
                guard let image: UIImage = UIImage(data: data) else {
                    fatalError("could not create image");
                }
                
                DispatchQueue.main.async {
                    self.title = photoInfo.title;
                    self.imageView.image = image;
                    self.descriptionLabel.text = photoInfo.description;
                    
                    if let copyright = photoInfo.copyright {
                        self.copyrightLabel.text = "Copyright \(copyright)";
                    } else {
                        self.copyrightLabel.isHidden = true;
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false; //p. 891
                }

            default:
                fatalError("unknown mediaType \(photoInfo.mediaType)");
            }
        }
        
        task.resume();
    }
}
