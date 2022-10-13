//
//  AirportsViewController.swift
//  Airports
//
//  Created by Maksim  on 13.10.2022.
//

import UIKit
import RxSwift
import RxDataSources

class AirportsViewController: UIViewController, Storyboardable {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: AirportsViewPresentable!
    private let bag = DisposeBag()
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<AirportItemSection>(configureCell: { (_, tableView, indexPath, item) in
        let airportCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AirportTableViewCell
        airportCell.configure(model: item)
        
        return airportCell
    })
    
    var viewModelBuilder: AirportsViewPresentable.ViewModelBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = viewModelBuilder( () )
        self.setupUI()
        self.setupBinding()
    }
    
}

private extension AirportsViewController {
    
    func setupUI() {
        tableView.register(UINib(nibName: "AirportTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    func setupBinding() {
        
        self.viewModel.output.airports
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        self.viewModel.output.title
            .drive(self.rx.title)
            .disposed(by: bag)
        
    }
    
}
