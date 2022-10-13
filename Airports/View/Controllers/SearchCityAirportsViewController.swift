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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = viewModelBuilder((
            searchText: searchTextField.rx.text.orEmpty.asDriver(),
            citySelect: tableView.rx.modelSelected(CityViewModel.self).asDriver()
        ))
                
        setupNavBar()
       // setupTF()
        setupBinding()
    }
}

private extension SearchCityAirportsViewController {
    
    func setupNavBar() {
        title = "Airports"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
       
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir", size: 30)!]
        
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    func setupTF() {
        searchTextField.leftView = UIImageView(image: UIImage(named: "magnifyingglass"))
        searchTextField.leftView?.frame = CGRect(x: 0, y: 5, width: 20, height: 20)
        searchTextField.leftViewMode = .always
       
    }
    
    func setupBinding() {
        self.viewModel.output.cities.drive(tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    }
    
    
}

