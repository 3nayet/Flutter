import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:polimi/db/card.dart';
import 'package:polimi/db/purchase.dart';
import 'package:polimi/models/cartItem.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:polimi/models/stripe_transaction_response.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';



class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String  CUSTOMERS_URL = '${StripeService.apiBase}/customers';
  static String PAYMENT_METHOD_URL = '${StripeService.apiBase}/payment_methods';
  static String secret = 'sk_test_jhYlKRGwF6i8HB29dPqPZidT00SNYScI3Z';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(
        StripeOptions(
            publishableKey: "pk_test_ecd1kdxELT3N6tFSHc2WstBi00GpffP5UU",
            merchantId: "PolimiShopping",
            androidPayMode: 'test'
        )
    );
  }

  static Future<StripeTransactionResponse> payViaExistingCard({List<CartItem> products, String currency, CreditCard card , String userId}) async{
    int amount = 0;
    products.forEach((element) {amount += (element.price*element.qty).toInt();});
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card)
      );
      var paymentIntent = await StripeService.createPaymentIntent(
          amount.toString(),
          currency
      );
      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent['client_secret'],
              paymentMethodId: paymentMethod.id
          )
      );
      if (response.status == 'succeeded') {
        PurchaseServices purchaseServices = PurchaseServices();
        var uuid = Uuid();
        var purchaseId = uuid.v1();
        purchaseServices.createPurchase(id: purchaseId,
            amount: amount,
            cardId: card.cardId,
            userId: userId,
            products: products);

        return new StripeTransactionResponse(
            message: 'Transaction successful',
            success: true
        );
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed',
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}',
          success: false
      );
    }
  }

  static Future<StripeTransactionResponse> payWithNewCard({String currency, List<CartItem> products , String userId}) async {
    int amount = 0;
    products.forEach((element) {amount += (element.price*element.qty).toInt();});
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest()
      );
      var paymentIntent = await StripeService.createPaymentIntent(
          amount.toString(),
          currency
      );
      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent['client_secret'],
              paymentMethodId: paymentMethod.id
          )
      );
      if (response.status == 'succeeded') {
        PurchaseServices purchaseServices = PurchaseServices();
        var uuid = Uuid();
        var purchaseId = uuid.v1();
        purchaseServices.createPurchase(id: purchaseId,
            amount: amount,
            cardId: paymentMethod.id,
            userId: userId,
            products: products);
        return new StripeTransactionResponse(
            message: 'Transaction successful',
            success: true
        );
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed',
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}',
          success: false
      );
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(
        message: message,
        success: false
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': (int.parse(amount)*100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          StripeService.paymentApiUrl,
          body: body,
          headers: StripeService.headers
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }



  Future<void> addCard(
      {String cardNumber, String  exp_Date,  String cvc, String card_HolderName , bool showBack, String userId}) async {

    Uuid uuid = new Uuid();
      CardServices cardServices = CardServices();
      cardServices.createCard(id: uuid.v1(),
          cardNumber: cardNumber,
          expDate: exp_Date,
          cardHolderName: card_HolderName,
          userId: userId,
      showBack: showBack,
      cvv:  cvc);

    }


}
