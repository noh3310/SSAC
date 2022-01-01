//
//  BeerViewModel.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/29.
//

import Foundation

class BeerViewModel {
    
    var beer: Observable<Beer> = Observable(Beer(name: "", tagline: "", beerDescription: "", imageURL: "", foodPairing: []))
    
    
    
}
