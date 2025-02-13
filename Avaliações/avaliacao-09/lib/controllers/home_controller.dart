import 'package:avaliacao_09/models/isbn_model.dart';
import 'package:avaliacao_09/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  ApiService apiService = ApiService();

  ValueNotifier<IsbnModel?> address = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> searchAddress({required String isbn}) async {
    isLoading.value = true;

    IsbnModel? addressModel = await apiService.getAddress(isbn: isbn);

    if (addressModel != null) {
      address.value = addressModel;
      isLoading.value = false;
      notifyListeners();
    } else {
      address.value = null;
      isLoading.value = false;
      notifyListeners();
    }
  }

  void clear() {
    address.value = null;
    isLoading.value = false;
    notifyListeners();
  }
}