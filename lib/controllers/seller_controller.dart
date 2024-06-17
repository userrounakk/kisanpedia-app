import 'package:get/get.dart';
import 'package:kisanpedia_app/models/seller.dart';

class SellerController extends GetxController {
  RxList<Seller> sellers = <Seller>[].obs;
  RxBool sellerError = false.obs;

  void setSellers(List<Seller> newSellers) {
    sellers.assignAll(newSellers);
  }

  void setError(bool error) {
    sellerError.value = error;
  }
}
