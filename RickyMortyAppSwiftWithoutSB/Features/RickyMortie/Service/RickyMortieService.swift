//
//  RickyMortieService.swift
//  RickyMortieAppSwiftWithoutSB
//
//  Created by ahmet azak on 5.08.2023.
//

import Alamofire
enum RickyMortieServiceEndPoint:String {
    case BASE_URL = "https://rickandmortyapi.com/api/"
    case PATH = "/character"
    static func characterPath()->String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickyMortyService {
    func fetchAllDatas(response:@escaping(PostModel?)->Void)
}
struct RickyMortieService : IRickyMortyService {
    func fetchAllDatas(response:@escaping(PostModel?)->Void ){
        AF.request(RickyMortieServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self) {(model) in
            guard let data = model.value else {
                //err
                response(nil)
                return
            }
            response(data)
        }
    }
    
    
}
