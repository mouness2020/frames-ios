import Foundation
import UIKit

/// A view that displays card information inputs
public class CardView: UIView {

    // MARK: - Properties

    let scrollView = UIScrollView()
    let contentView = UIView()
    let stackView = UIStackView()
    let schemeIconsStackView = SchemeIconsStackView()
    let addressTapGesture = UITapGestureRecognizer()

    /// Accepted Card Label
    public let acceptedCardLabel = UILabel()

    /// Card number input view
    public let cardNumberInputView = CardNumberInputView()

    /// Card holder's name input view
    public let cardHolderNameInputView = StandardInputView()

    /// Expiration date input view
    public let expirationDateInputView = ExpirationDateInputView()

    /// Cvv input view
    public let cvvInputView = CvvInputView()

    /// Billing details input view
    public let billingDetailsInputView = DetailsInputView()

    // Input options
    let cardHolderNameState: InputState
    let billingDetailsState: InputState

    var scrollViewBottomConstraint: NSLayoutConstraint!

    // MARK: - Initialization

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        cardHolderNameState = .required
        billingDetailsState = .required
        super.init(frame: frame)
        setup()
    }

    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        cardHolderNameState = .required
        billingDetailsState = .required
        super.init(coder: aDecoder)
        setup()
    }

    /// Initializes and returns a newly  allocated card view with the specified input states.
    init(cardHolderNameState: InputState, billingDetailsState: InputState) {
        self.cardHolderNameState = cardHolderNameState
        self.billingDetailsState = billingDetailsState
        super.init(frame: .zero)
        setup()
    }

    // MARK: - Methods

    private func setup() {
        addViews()
        addInitialConstraints()
        backgroundColor = UIColor.groupTableViewBackground
        acceptedCardLabel.text = "البطاقات المدعومة"
        cardNumberInputView.set(label: "cardNumber", backgroundColor: .white)
        expirationDateInputView.set(label: "expirationDate", backgroundColor: .white)
        cvvInputView.set(label: "cvv", backgroundColor: .white)
        // card holder name
        if cardHolderNameState == .required {
            cardHolderNameInputView.set(label: "cardholderNameRequired", backgroundColor: .white)
        } else {
            cardHolderNameInputView.set(label: "cardholderName", backgroundColor: .white)
        }
        // billing details
        if billingDetailsState == .required {
            billingDetailsInputView.set(label: "billingDetailsRequired", backgroundColor: .white)
        } else {
            billingDetailsInputView.set(label: "billingDetails", backgroundColor: .white)
        }

        cardNumberInputView.textField.placeholder = "4242"
        expirationDateInputView.textField.placeholder = "06/2020"
        cvvInputView.textField.placeholder = "100"
        cvvInputView.textField.keyboardType = .numberPad

        schemeIconsStackView.spacing = 8
        stackView.axis = .vertical
        stackView.spacing = 16
        // keyboard
        var textFields = [cardNumberInputView.textField,
                          expirationDateInputView.textField,
                          cvvInputView.textField]
        if cardHolderNameState != .hidden {
            textFields.insert(cardHolderNameInputView.textField, at: 1)
        }
        addKeyboardToolbarNavigation(textFields: textFields)
    }

    private func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(acceptedCardLabel)
        contentView.addSubview(schemeIconsStackView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(cardNumberInputView)
        if cardHolderNameState != .hidden {
            stackView.addArrangedSubview(cardHolderNameInputView)
        }
        stackView.addArrangedSubview(expirationDateInputView)
        stackView.addArrangedSubview(cvvInputView)
        if billingDetailsState != .hidden {
            stackView.addArrangedSubview(billingDetailsInputView)
        }
    }

    private func addInitialConstraints() {
        scrollViewBottomConstraint = self.addScrollViewContraints(scrollView: scrollView, contentView: contentView)
        acceptedCardLabel.translatesAutoresizingMaskIntoConstraints = false
        schemeIconsStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        acceptedCardLabel.trailingAnchor
            .constraint(equalTo: contentView.trailingAnchor, constant: -8)
            .isActive = true
        acceptedCardLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        acceptedCardLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        acceptedCardLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
            .isActive = true

        schemeIconsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
            .isActive = true
        schemeIconsStackView.topAnchor.constraint(equalTo: acceptedCardLabel.bottomAnchor, constant: 16).isActive = true
        schemeIconsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true

        stackView.trailingAnchor.constraint(equalTo: contentView.safeTrailingAnchor, constant: -8).isActive = true
        stackView.topAnchor.constraint(equalTo: schemeIconsStackView.safeBottomAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.safeLeadingAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.safeBottomAnchor).isActive = true
    }
}
