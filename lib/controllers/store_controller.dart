import 'package:get/get.dart';
import 'package:kisanpedia_app/models/store.dart';

class StoreController extends GetxController {
  RxList<Store> stores = <Store>[].obs;
  RxBool storeError = false.obs;

  void setStores(List<Store> newStores) {
    stores.assignAll(newStores);
  }

  void setError(bool error) {
    storeError.value = error;
  }
}
