//
//  SearchCityAirportsViewController.swift
//  Airports
//
//  Created by Maksim  on 09.10.2022.
//

import UIKit
import RxSwift
import RxDataSources

class SearchCityAirportsViewController: UIViewController, Storyboardable {

    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var viewModel: SearchCityViewPresentable!
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<CityItemsSection>(configureCell: { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityTableViewCell
        cell.configure(viewModel: item)
        
        return cell
    })
    
    
    var viewModelBuilder: SearchCityViewPresentable.ViewModelBuilder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = viewModelBuilder((
            searchText: searchTextField.rx.text.orEmpty.asDriver(), ()
        ))
                
        setupUI()
        setupBinding()
        
    }
}

private extension SearchCityAirportsViewController {
    
    func setupUI() {
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setupBinding() {
        self.viewModel.output.cities.drive(tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    }
}

