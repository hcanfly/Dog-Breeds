//
//  DogBreedsViewController.swift
//  DogBreeds
//
//  Created by Gary Hanson on 2/27/22.
//

import UIKit


final class DogBreedsViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var viewModel: BreedViewModel
    private var cancellable: Cancellable?
    private let cellSize = UIScreen.main.bounds.width * 0.90 / 3

    required init?(coder: NSCoder) {
        viewModel = BreedViewModel()

        super.init(coder: coder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Dog Breeds"
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        collectionView.register(BreedCollectionViewCell.self, forCellWithReuseIdentifier: BreedCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        setupConstraints()
        
        cancellable = viewModel.$breeds.observe { [weak self] state in
            self?.handleStateChange()
        }
        
        loadData()
    }
    
    private func setupConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -6).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    fileprivate func loadData() {
        Task {
            await viewModel.fetchBreeds()
        }
    }
    
    private func handleStateChange() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension DogBreedsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.breeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedCollectionViewCell.identifier, for: indexPath) as! BreedCollectionViewCell

        let breed = viewModel.breeds[indexPath.row]
        
        cell.titleLabel.text = breed.name
        cell.cellImageView.downloadImage(urlString: breed.imageURL)
                    
        return cell
    }
    
}

extension DogBreedsViewController: UICollectionViewDelegate, UINavigationControllerDelegate {
    
    func CollectionView(_ CollectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellSize
    }
    
    func collectionView(_ CollectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let breed = viewModel.breeds[indexPath.row]
        
        let bvc = BreedViewController.instantiate()
        bvc.breed = breed
        
        self.navigationController?.delegate = self
        self.navigationController?.pushViewController(bvc, animated: false)
    }
}


//final class DogBreedsViewController: UIViewController {
//
//    let tableView = UITableView()
//    let viewModel = BreedViewModel()
//    private var cancellable: Cancellable?
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        title = "Dog Breeds"
//
//        tableView.register(BreedTableViewCell.self, forCellReuseIdentifier: BreedTableViewCell.identifier)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.backgroundColor = .darkGray
//        self.view.addSubview(tableView)
//
//        setupConstraints()
//
//        cancellable = viewModel.$breeds.observe { [weak self] state in
//            self?.handleStateChange()
//        }
//
//        loadData()
//    }
//
//    private func setupConstraints() {
//        self.tableView.translatesAutoresizingMaskIntoConstraints = false
//        self.tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
//        self.tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        self.tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        self.tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//    }
//
//    fileprivate func loadData() {
//        Task {
//            await viewModel.fetchBreeds()
//        }
//    }
//
//    private func handleStateChange() {
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//}


//extension DogBreedsViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)  -> Int {
//        return viewModel.breeds.count
//    }
//
//    func tableView(_ tableView: UITableView,
//                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: BreedTableViewCell.identifier, for: indexPath) as! BreedTableViewCell
//
//        let breed = viewModel.breeds[indexPath.row]
//
//        cell.titleLabel.text = breed.name
//        cell.cellImageView.downloadImage(urlString: breed.imageURL)
//
//        return cell
//    }
//}
//
//extension DogBreedsViewController: UITableViewDelegate, UINavigationControllerDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let breed = viewModel.breeds[indexPath.row]
//
//        let bvc = BreedViewController.instantiate()
//        bvc.breed = breed
//
//        self.navigationController?.delegate = self
//        self.navigationController?.pushViewController(bvc, animated: false)
//    }
//}


