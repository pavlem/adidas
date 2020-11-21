//
//  ProductDetailsVC.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 21/11/2020.
//

import UIKit

class ProductDetailsVC: UIViewController {

    // MARK: - API
    var productDetailsVM: ProductDetailsVM?
    
    // MARK: - Properties
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var descriptionTxtFld: UITextView!
    @IBOutlet weak var reviewsTxtFld: UITextView!
    @IBOutlet weak var addReviewBtn: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUI()
    }
    
    // MARK: - Actions
    @IBAction func addReview(_ sender: UIButton) {
        let ratingVC = UIStoryboard.productRatingVC
        ratingVC.ratingID = productDetailsVM?.id
        self.present(ratingVC, animated: true) {}
    }
    
    // MARK: - Helper
    private func setUI() {
        guard let productDetailsVM = productDetailsVM else { return }
        
        if let imageFromCache = ImageHelper.imageCache.object(forKey: productDetailsVM.imgUrl as AnyObject) {
            self.productImg.image = imageFromCache as? UIImage
        } else {
            self.productImg.image = UIImage(named: "productPlaceholder")
        }
        
        priceLbl.text = productDetailsVM.price
        productLbl.text = productDetailsVM.name
        descriptionTxtFld.text = productDetailsVM.description
        reviewsTxtFld.text = productDetailsVM.reviews
        
        navigationItem.title = productDetailsVM.name
        descriptionTxtFld.isEditable = false
    }
}
