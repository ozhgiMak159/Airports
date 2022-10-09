//
//  SearchCityAirportsViewController.swift
//  Airports
//
//  Created by Maksim  on 09.10.2022.
//

import UIKit
import RxSwift
import RxDataSources

class SearchCityAirportsViewController: UIViewController {

    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: SearchCityViewPresentable!
    var viewModelBuilder: SearchCityViewPresentable.ViewModelBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = viewModelBuilder((
            searchText: searchTextField.rx.text.orEmpty.asDriver(), ()
        ))
                
    }
}

extension SearchCityAirportsViewController: Storyboardable {
    
}

