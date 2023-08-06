//
//  RickyMortieViewModel.swift
//  RickyMortieAppSwiftWithoutSB
//
//  Created by ahmet azak on 5.08.2023.
//

import Foundation
protocol IRickyMortieViewModel{
    func fetchItems()
    func changeLoading()
    var rickyMortieCharacters:[Result]{get set}
    var rickyMortieService : IRickyMortyService{get set}
    var rickyMortieOutput : RickyMortieOutput? {get set}
    func setDelegate(output : RickyMortieOutput)
}
class RickyMortieViewModel : IRickyMortieViewModel
{
    var rickyMortieOutput: RickyMortieOutput?
    
    var rickyMortieService: IRickyMortyService
    private var isLoading = false 
    init(){
        rickyMortieService = RickyMortieService()
        
    }
    func fetchItems() {
        self.changeLoading()
        rickyMortieService.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.rickyMortieCharacters = response?.results ?? []
            self?.rickyMortieOutput?.saveDatas(values: self?.rickyMortieCharacters ?? [])
        }
    }
    func setDelegate(output: RickyMortieOutput) {
        rickyMortieOutput = output
    }
    func changeLoading() {
        isLoading = !isLoading
        rickyMortieOutput?.changeLoading(isLoad: isLoading)
        
        
    }
    
    var rickyMortieCharacters: [Result] = []
    
 
    
}

