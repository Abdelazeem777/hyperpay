import '../flutter_hyperpay.dart';

/// This class is used to define a CustomUI object which is used to make payments using the PaymentConst.
/// customUi payment type. It has parameters to define the checkoutId, brandName,
/// cardNumber, holderName, month, year, cvv and enabledTokenization (optional).
class CustomUI {
  /// initializes a variable named paymentType with the value PaymentConst.customUi.
  String paymentType = PaymentConst.customUi;

  /// declares a string variable named checkoutId without assigning it an initial value.
  String checkoutId;

  ///  brandName variable could be used to store the name of the brand or company
  String brandName;

  /// cardNumber variable would typically hold the numerical sequence that uniquely identifies a payment card
  String cardNumber;

  /// holderName variable would typically hold the name of the individual or entity that owns or is authorized to use the payment card
  String holderName;

  /// the month variable could be used to represent the expiration month of a credit or debit card
  String month;

  /// the year variable could be used to represent the expiration year of a credit or debit card
  String year;

  /// the cvv variable holds the three- or four-digit security code printed on the back (for Visa, Mastercard, and Discover)
  String cvv;

  /// typically refers to a boolean variable or a configuration option that determines whether tokenization is enabled or disabled in a payment processing system or application.
  bool enabledTokenization;

  /// Apple Pay merchant ID - nullable for non-Apple Pay payments
  String? merchantId;

  /// Apple Pay country code - nullable for non-Apple Pay payments
  String? countryCode;

  /// Apple Pay company name - nullable for non-Apple Pay payments
  String? companyName;

  /// Apple Pay currency code - nullable for non-Apple Pay payments
  String? currencyCode;

  /// Apple Pay amount - nullable for non-Apple Pay payments
  double? amount;

  /// supportedNetworks defines the list of supported Apple Pay networks (e.g., ["visa", "masterCard", "mada"]).
  /// If empty or null, defaults will be used based on iOS version.
  List<String>? supportedNetworksApplePayIOS;

  CustomUI({
    required this.checkoutId,
    required this.brandName,
    required this.cardNumber,
    required this.holderName,
    required this.month,
    required this.year,
    required this.cvv,
    this.enabledTokenization = false,
    this.merchantId,
    this.countryCode,
    this.companyName,
    this.currencyCode,
    this.amount,
    this.supportedNetworksApplePayIOS,
  });
}
