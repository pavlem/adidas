//
//  RatingVC.swift
//  AdidasTest
//
//  Created by Pera Detlic on 22/11/2020.
//

import UIKit

class ProductRatingVC: UIViewController {

    // MARK: - API
    var ratingID: String?
    
    // MARK: - Properties
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var reviewtxtFld: UITextField!
    @IBOutlet weak var addRatingLbl: UILabel!
    @IBOutlet weak var ratingStepper: UIStepper!
    @IBOutlet weak var ratingInfoLbl: UILabel!
    @IBOutlet weak var postRatingBtn: AdidasBtn!
    @IBOutlet weak var ratingInfoTxtView: UITextView!
    // MARK: Vars
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        fetchRatings(forRatingId: ratingID)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        dataTask?.cancel()
    }
    
    // MARK: - Actions
    @IBAction func postRating(_ sender: AdidasBtn) {
        guard let ratingID = ratingID else { return }
        guard let txt = reviewtxtFld.text, txt.count > 0 else {
            AlertHelper.simpleAlert(message: "Please put a rating description....")
            return
        }
        let ratingValue = Int(ratingStepper.value)
        let locale = Locale.current.languageCode ?? "en"

        self.view.endEditing(true)
        BlockingScreen.start()

        dataTask = ProductService().postRating(ratingRequest: RatingRequest(productId: ratingID, locale: locale, rating: ratingValue, text: txt)) { [weak self] (result) in

            BlockingScreen.stop()

            guard let `self` = self else { return }
            
            self.numberOfReviews += 1

            switch result {
            case .success(let rating):
                self.ratingInfoTxtView.text! = ProductListVM.addReview(rating: rating, existingReviews: self.ratingInfoTxtView.text!, numberOfReviews: self.numberOfReviews)
            case .failure(let netErr):
                AlertHelper.simpleAlert(message: String(describing: netErr))
            }
        }
    }

    @IBAction func stepUpOrDown(_ sender: UIStepper) {
        ratingInfoLbl.text = "You rated: \(Int(sender.value))"
    }

    // MARK: - Helper
    private func setUI() {
        ratingInfoTxtView.isEditable = false
        ratingInfoTxtView.delegate = self
    }

    private func fetchRatings(forRatingId ratingID: String?) {
        guard let ratingID = ratingID else {
            AlertHelper.simpleAlert(message: "Rating ID is missing")
            return
        }

        dataTask = ProductService().getRatings(forRatingId: ratingID) { [weak self] (result) in
            guard let `self` = self else { return }

            switch result {
            case .success(let ratings):
                let reviewTuple = ProductListVM.getReviews(fromArrayOfReviews: ratings)
                self.ratingInfoTxtView.text = reviewTuple.reviews
                self.numberOfReviews = reviewTuple.reviewCount
            case .failure(let netErr):
                AlertHelper.simpleAlert(message: String(describing: netErr))
            }
        }
    }

    var numberOfReviews = 0
}

// MARK: - UITextViewDelegate
extension ProductRatingVC: UITextViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
