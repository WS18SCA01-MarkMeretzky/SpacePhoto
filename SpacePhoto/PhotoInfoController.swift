//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Mark Meretzky on 3/3/19.
//  Copyright © 2019 New York University School of Professional Studies. All rights reserved.
//

import Foundation;

struct PhotoInfoController {
    
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {   //p. 880
        
        guard let baseURL: URL = URL(string: "https://api.nasa.gov/planetary/apod") else {
            fatalError("could not create baseURL");
        }
        
        let query: [String: String] = [
            "api_key": "DEMO_KEY",
            //"date":    "2019-02-26"   //a date with a video, p. 890
        ];
    
        guard let url: URL = baseURL.withQueries(query) else {
            fatalError("could not create url");
        }
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            let jsonDecoder: JSONDecoder = JSONDecoder();
            
            guard let data: Data = data else {
                print("no data was returned");
                completion(nil);
                return;
            }
            
            guard let string: String = String(data: data, encoding: .utf8) else {
                fatalError("could not change Data into String");
            }
            print(string);
            
            guard let photoInfo: PhotoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) else {
                print("data was not serialized");
                completion(nil);
                return;
            }
            
            completion(photoInfo);
        }

        task.resume();
    }

}
