import 'package:transpporter_app_test/databaseModels/users.dart';

class PaymentMethodsData{
  int id;
  paymentMethod method;
  int userId;
  
  PaymentMethodsData({
    this.id,
    this.method = paymentMethod.cash,
    this.userId
  });
}