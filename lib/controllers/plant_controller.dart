import 'package:get/get.dart';
import 'package:kisanpedia_app/models/plant.dart';

class PlantController extends GetxController {
  RxList<Plant> plants = <Plant>[].obs;
  RxBool plantError = false.obs;

  void setPlants(List<Plant> newPlants) {
    plants.assignAll(newPlants);
  }

  void setError(bool error) {
    plantError.value = error;
  }
}
