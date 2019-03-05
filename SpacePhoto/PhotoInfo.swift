//
//  PhotoInfo.swift
//  SpacePhoto
//
//  Created by Mark Meretzky on 3/3/19.
//  Copyright © 2019 New York University School of Professional Studies. All rights reserved.
//

import Foundation;

struct PhotoInfo: Codable {   //p. 879
    var title: String;
    var description: String;
    var url: URL;
    var copyright: String?;
    var mediaType: String;   //p. 890

    enum Keys: String, CodingKey {
        case title;
        case description = "explanation";   //is explanation in the JSON
        case url;
        case copyright;
        case mediaType = "media_type";
    }

    init(from decoder: Decoder) throws {
        let valueContainer: KeyedDecodingContainer<Keys> = try decoder.container(keyedBy: Keys.self);
        title       = try  valueContainer.decode(String.self, forKey: Keys.title);
        description = try  valueContainer.decode(String.self, forKey: Keys.description);
        url         = try  valueContainer.decode(URL.self,    forKey: Keys.url);
        copyright   = try? valueContainer.decode(String.self, forKey: Keys.copyright);
        mediaType   = try  valueContainer.decode(String.self, forKey: Keys.mediaType);
    }
}
