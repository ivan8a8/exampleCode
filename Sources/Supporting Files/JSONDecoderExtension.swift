//
//  JSONDecoderExtension.swift
//

import Foundation

extension JSONDecoder {
    static func decode<T: Decodable>(type: T.Type, from: Data?, dateDecodingStreategy: JSONDecoder.DateDecodingStrategy? = nil, logError: Bool = true) -> T? {
        guard let data = from else {
            return nil
        }

        do {
            let decoder = JSONDecoder()
            if let dateDecodingStreategy {
                decoder.dateDecodingStrategy = dateDecodingStreategy
            }

            return try decoder.decode(type, from: data)
        } catch {
            if logError {
                print(error)
            }

            return nil
        }
    }
}
