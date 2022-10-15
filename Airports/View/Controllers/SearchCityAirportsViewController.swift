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
    var viewModelBuilder: SearchCityViewPresentable.ViewModelBuilder!
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<CityItemsSection>(configureCell: { _, tableView, indexPath, item in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityTableViewCell
        cell.configure(viewModel: item)
        
        return cell
    })
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deleteHorizonLineNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = viewModelBuilder((
            searchText: searchTextField.rx.text.orEmpty.asDriver(),
            citySelect: tableView.rx.modelSelected(CityViewModel.self).asDriver()
        ))
                
        setupNavBar()
        setupBinding()
    }
}

private extension SearchCityAirportsViewController {
    
    func setupNavBar() {
        title = "Airports"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    func deleteHorizonLineNavBar() {
        
      
    }
    
    func setupBinding() {
        self.viewModel.output.cities.drive(tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    }
    
    
}

