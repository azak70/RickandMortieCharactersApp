//
//  RickyMortieViewController.swift
//  RickyMortieAppSwiftWithoutSB
//
//  Created by ahmet azak on 3.08.2023.
//

import UIKit
import SnapKit
protocol RickyMortieOutput {
    func changeLoading(isLoad:Bool)
    func saveDatas(values : [Result])
    
}
final class RickyMortieViewController: UIViewController {
    private let labelTitle : UILabel = UILabel()
    private let tableView : UITableView = UITableView()
    private let indicator : UIActivityIndicatorView = UIActivityIndicatorView()
    private lazy var results : [Result] = []
    lazy var viewModel : IRickyMortieViewModel = RickyMortieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
        // Do any additional setup after loading the view.
    }
    private func config () {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        view.backgroundColor = .white
        drawDesign()
        makeLabel()
        makeBox()
        makeIndicator()
    }
    private func drawDesign(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(RickyMortieTableViewCell.self, forCellReuseIdentifier: RickyMortieTableViewCell.Identifier.custom.rawValue)
       tableView.rowHeight = 160
        DispatchQueue.main.async {
            self.tableView.backgroundColor = .red
            self.labelTitle.font = .boldSystemFont(ofSize: 20)
            self.labelTitle.text = "Rick and Mortie"
            self.indicator.tintColor = .red
        }
        
        
        indicator.startAnimating()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension RickyMortieViewController:RickyMortieOutput {
    func changeLoading(isLoad: Bool) {
        isLoad  ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
    
    
}
extension RickyMortieViewController {
    private func  makeBox(){
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
            
        }
    }
    private func makeLabel () {
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
            
        }
    }
    private func makeIndicator (){
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
            
        }
    }
    
}
extension RickyMortieViewController : UITableViewDataSource , UITableViewDelegate  {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell : RickyMortieTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickyMortieTableViewCell.Identifier.custom.rawValue) as? RickyMortieTableViewCell else {
            return UITableViewCell()
            
        }
        cell.saveModel(model: results[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count;
    }
    
}
