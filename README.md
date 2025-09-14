# HyperPay SDK Plugin

The HyperPay platform offers a complete, easy-to-use guide to enable seamless integration of our end-to-end payment gateway for mobile and desktop browsers. Through a unified API, you can enable and gain access to all platform features. Choose one of the options below to quickly get started

[![pub package](https://img.shields.io/badge/Release-3.1.4%20Pub%20dev-blue)](https://pub.dev/packages/hyperpay_plugin)
[![Discord](https://img.shields.io/badge/Discord-JOIN-blue?logo=discord)](https://discord.gg/T8TyGxpGBS)
[![GitHub](https://img.shields.io/badge/Github-Link-blue?logo=github)](https://github.com/ahmedelkhyary/hyperpay)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](https://pub.dev/packages/hyperpay_plugin/license)
[![Coffee](https://img.shields.io/badge/coffee-black?logo=buy-me-a-coffee)](https://buymeacoffee.com/ahmedelkhyary)

## Support ReadyUI , CustomUI

- **VISA** **,** **MasterCard**
- **STC**
- **Apple Pay**
- **MADA** _( Saudi Arabia )_

### Android Setup

1. Open `android/app/build.gradle` and add the following lines
   &NewLine;

```
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    debugImplementation(name: "ipworks3ds_sdk", ext: 'aar')
    releaseImplementation(name: "ipworks3ds_sdk_deploy", ext: 'aar')
    implementation(name: "oppwa.mobile-release", ext: 'aar')
    implementation "com.google.android.material:material:1.6.1"
    implementation "androidx.appcompat:appcompat:1.5.1"
    implementation 'com.google.android.gms:play-services-wallet:19.1.0'
    implementation "androidx.browser:browser:1.4.0"
    implementation "com.google.code.gson:gson:2.8.9"
    implementation "androidx.lifecycle:lifecycle-viewmodel-ktx:2.5.1"
    implementation "androidx.webkit:webkit:1.4.0"
    implementation "androidx.fragment:fragment-ktx:1.4.1"
    implementation "androidx.constraintlayout:constraintlayout:2.1.4"
    implementation "androidx.recyclerview:recyclerview:1.2.1"
    implementation 'androidx.databinding:viewbinding:7.1.2'
```

2. Open `app/build.gradle` and make sure that the `minSdkVersion` is **21**
   &NewLine;

3. Open your `AndroidManifest.xml`, and put `intent-filter` inside `activity`.
   &NewLine;

```
<application
  <activity
        <intent-filter>
                <action android:name="android.intent.action.VIEW" />
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.BROWSABLE" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.LAUNCHER" />
                <data android:scheme="com.testpayment.payment" />
            </intent-filter>
  </activity>
</application>

```

#### Note about Intent-filter scheme

#### `shopperResultUrl since mSDK version 6.0.0 the shopper result URL is not required`

The `Scheme` field must match the `InAppPaymentSetting.shopperResultUrl` field.
Don't make `Scheme` like `com.testPayment.Payment` avoid capital letters in Android.

`It's used when making a payment outside the app (Like open browser) and back into the app`

### IOS Setup

1. Open Podfile, and paste the following inside of it:
   &NewLine;

```ruby
pod 'hyperpay_sdk', :git => 'https://github.com/ahmedelkhyary/hyperpay_sdk.git'
$static_framework = ['hyperpay_plugin']
pre_install do |installer|
  Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
  installer.pod_targets.each do |pod|
      if $static_framework.include?(pod.name)
        def pod.build_type;
          Pod::BuildType.static_library
        end
      end
    end
end
```

2. Add `Url Scheme` to the list of bundle identifiers.
   The `Url Scheme` field must match the `InAppPaymentSetting.shopperResultUrl` field.

<br /><img src="https://user-images.githubusercontent.com/70061912/222664709-0744b798-ba1d-47e4-917d-c05e803f89ef.PNG" atl="Xcode URL type" width="700"/>

### Setup HyperPay Environment Configuration

define instanse of `FlutterHyperPay`

```dart
late FlutterHyperPay flutterHyperPay ;
flutterHyperPay = FlutterHyperPay(
shopperResultUrl: InAppPaymentSetting.shopperResultUrl, // return back to app
paymentMode:  PaymentMode.test, // test or live
lang: InAppPaymentSetting.getLang(),
);

```

create a method to get the checkoutId

```
  /// URL TO GET CHECKOUT ID FOR TEST
  /// http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php
  /// Brands Names [ PaymentBrands.visa , PaymentBrands.masterCard , PaymentBrands.mada , PaymentBrands.stcPay , PaymentBrands.applePay ]

getCheckOut() async {
    final url = Uri.parse('https://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      payRequestNowReadyUI(
        checkoutId: json.decode(response.body)['id'],
        brandsName: [
          PaymentBrands.visa,
          PaymentBrands.masterCard,
          PaymentBrands.mada,
          PaymentBrands.stcPay,
          PaymentBrands.applePay
        ]);
    }else{
      dev.log(response.body.toString(), name: "STATUS CODE ERROR");
    }
  }
```

If you want using `readyUI` send checkoutId and List of `brandsName` to Plugin

Brands Names support [ PaymentBrands.visa , PaymentBrands.masterCard , PaymentBrands.mada , PaymentBrands.stcPay , PaymentBrands.applePay ]

```
  payRequestNowReadyUI(
      {required List<String> brandsName, required String checkoutId}) async {
    PaymentResultData paymentResultData;
      paymentResultData = await flutterHyperPay.readyUICards(
        readyUI: ReadyUI(
            brandsName: brandsName ,
            checkoutId: checkoutId,
            merchantIdApplePayIOS: InAppPaymentSetting.merchantId, // applepay
            countryCodeApplePayIOS: InAppPaymentSetting.countryCode, // applePay
            companyNameApplePayIOS: "Test Co", // applePay
            themColorHexIOS: "#000000" ,// FOR IOS ONLY
            supportedNetworksApplePayIOS: [
              PaymentBrands.visa,
              PaymentBrands.masterCard,
              PaymentBrands.mada
            ], // Configure supported networks
            setStorePaymentDetailsMode: true // store payment details for future use
            ),
      );
  }


```

If you want using `CustomUI`

```
  payRequestNowCustomUi(
      {required String brandName, required String checkoutId}) async {
    PaymentResultData paymentResultData;

    if (brandName == PaymentBrands.applePay) {
      // Apple Pay CustomUI example
      paymentResultData = await flutterHyperPay.customUICards(
        customUI: CustomUI(
          brandName: brandName,
          checkoutId: checkoutId,
          merchantId: InAppPaymentSetting.merchantId,
          countryCode: InAppPaymentSetting.countryCode,
          companyName: "Test Co",
          currencyCode: "SAR",
          amount: 99.99,
          supportedNetworks: [
            PaymentBrands.visa,
            PaymentBrands.masterCard
          ], // Configure supported networks
        ),
      );
    } else {
      // Regular card payment CustomUI example
      paymentResultData = await flutterHyperPay.customUICards(
        customUI: CustomUI(
          brandName: brandName,
          checkoutId: checkoutId,
          cardNumber: "5541805721646120",
          holderName: "test name",
          month: 12,
          year: 2023,
          cvv: 123,
          enabledTokenization: false, // default
        ),
      );
    }
  }
```

`STC CustomUI` - now for android only next release we will support IOS

```
  // STC_PAY
    payRequestNowCustomUiSTCPAY(
      {required String phoneNumber, required String checkoutId}) async {
    PaymentResultData paymentResultData;
    paymentResultData = await flutterHyperPay.customUISTC(
      customUISTC: CustomUISTC(
          checkoutId: checkoutId,
          phoneNumber: phoneNumber
      ),
    );
  }
```

get check the payment status after request

```
    if (paymentResultData.paymentResult == PaymentResult.success ||
        paymentResultData.paymentResult == PaymentResult.sync) {
      // do something
    }
```

`ReadyUI`
change color in `android` platform
open `android/app/src/main/res/values` and add the following lines

```
    <!--    DEFAULT COLORS YOU CAN OVERRIDE IN YOUR APP-->
    <color name="headerBackground">#000000</color>
    <color name="cancelButtonTintColor">#FFFFFF</color>
    <color name="listMarkTintColor">#000000</color>
    <color name="cameraTintColor">#000000</color>
    <color name="checkboxButtonTintColor">#000000</color>
```

`payment setting`

```
  class InAppPaymentSetting {
   // shopperResultUrl : this name must like scheme in intent-filter, url scheme in xcode
   // Avoid capital letters like `com.testPayment.Payment`, as it will not work in Android.
  static const String shopperResultUrl= "com.testpayment.payment";
  static const String merchantId= "MerchantId";
  static const String countryCode="SA";
  static getLang() {
    if (Platform.isIOS) {
      return  "en"; // ar
    } else {
      return "en_US"; // ar_AR
    }
  }
}
```

[`MerchantId apple pay Setup click here this steps to create and verify apple pay and domain`](https://github.com/ahmedelkhyary/applepay_merchantId_config)

## Apple Pay Supported Networks Configuration

You can now configure which payment networks are supported for Apple Pay transactions. This allows you to customize the available payment options based on your business requirements and regional preferences.

### Supported Network Names

The following network names are supported (case-insensitive):

- `"visa"` or `PaymentBrands.visa` - Visa
- `"masterCard"`, `"master card"` or `PaymentBrands.masterCard` - MasterCard
- `"mada"` or `PaymentBrands.mada` - Mada (iOS 12.1.1+ only, primarily used in Saudi Arabia)
- `"amex"` or `"american express"` - American Express
- `"discover"` - Discover (iOS 9.0+ only)

**💡 Best Practice:** Use the predefined constants from `PaymentBrands` class for consistency and type safety. The Swift implementation handles case conversion automatically.

### For ReadyUI:

```dart
// Option 1: Using PaymentBrands constants (Recommended)
final readyUI = ReadyUI(
  checkoutId: "your_checkout_id",
  brandsName: [PaymentBrands.applePay, PaymentBrands.visa],
  merchantIdApplePayIOS: "merchant.com.example",
  countryCodeApplePayIOS: "US",
  companyNameApplePayIOS: "Your Company",
  supportedNetworksApplePayIOS: [
    PaymentBrands.visa,
    PaymentBrands.masterCard
  ], // Configure supported networks
  setStorePaymentDetailsMode: false,
);

// Option 2: Using string literals
final readyUI = ReadyUI(
  checkoutId: "your_checkout_id",
  brandsName: ["APPLEPAY", "VISA"],
  merchantIdApplePayIOS: "merchant.com.example",
  countryCodeApplePayIOS: "US",
  companyNameApplePayIOS: "Your Company",
  supportedNetworksApplePayIOS: ["visa", "masterCard"], // Configure supported networks
  setStorePaymentDetailsMode: false,
);

final result = await flutterHyperPay.readyUICards(readyUI: readyUI);
```

### For CustomUI:

```dart
// Option 1: Using PaymentBrands constants (Recommended)
final customUI = CustomUI(
  checkoutId: "your_checkout_id",
  brandName: PaymentBrands.applePay,
  merchantId: "merchant.com.example",
  countryCode: "US",
  companyName: "Your Company",
  currencyCode: "USD",
  amount: 99.99,
  supportedNetworks: [
    PaymentBrands.visa,
    PaymentBrands.masterCard,
    PaymentBrands.mada
  ], // Configure supported networks
);

// Option 2: Using string literals
final customUI = CustomUI(
  checkoutId: "your_checkout_id",
  brandName: "APPLEPAY",
  merchantId: "merchant.com.example",
  countryCode: "US",
  companyName: "Your Company",
  currencyCode: "USD",
  amount: 99.99,
  supportedNetworks: ["visa", "masterCard", "mada"], // Configure supported networks
);

final result = await flutterHyperPay.customUICards(customUI: customUI);
```

### Edge Cases and Best Practices

1. **Empty or null networks**: If `supportedNetworks` is empty or null, the plugin will use default networks based on iOS version:

   - iOS 12.1.1+: `[mada, visa, masterCard]`
   - Older versions: `[visa, masterCard]`

2. **Invalid network names**: Invalid network names are automatically filtered out with a warning logged to the console.

3. **iOS version compatibility**: Networks not supported on the current iOS version are automatically excluded (e.g., Mada on iOS < 12.1.1).

4. **Fallback behavior**: If no valid networks remain after filtering, the plugin falls back to default networks.

5. **Network name flexibility**: Network names are trimmed and converted to lowercase for better user experience.
