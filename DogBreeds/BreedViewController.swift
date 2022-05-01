//
//  BreedViewController.swift
//  DogBreeds
//
//  Created by Gary Hanson on 2/27/22.
//

import UIKit


final class BreedViewController: UIViewController, Storyboarded {
    var breed: Breed!
    
    @IBOutlet weak var imageView: AsyncCachedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var bredForLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = breed.name
        
        view.layer.backgroundColor = UIColor(named: "BreedBackground")?.cgColor
        
        stackView.layer.backgroundColor = UIColor(named: "StackViewBackground")?.cgColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 15
        
        nameLabel.text = breed.name
        DescriptionLabel.text = breed.temperment
        heightLabel.text = "Height: \(breed.height)"
        weightLabel.text = "Weight: \(breed.weight)"
        lifeSpanLabel.text = "Life span: \(breed.lifeSpan)"
        groupLabel.text = "Group: \(breed.breedGroup)"
        bredForLabel.text = "Bred for:: \(breed.bredFor)"
        
        imageView.downloadImage(urlString: breed.imageURL)
        imageView.layer.cornerRadius = 15
    }

}


protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {
    // Creates a view controller from our storyboard. This relies on view controllers having the same storyboard identifier as their class name. This method shouldn't be overridden in conforming types.
    static func instantiate() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
