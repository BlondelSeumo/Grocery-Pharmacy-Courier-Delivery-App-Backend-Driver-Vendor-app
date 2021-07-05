import 'package:fuodz/models/user.dart';
import 'package:fuodz/requests/user.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';

class AssignOrderViewModel extends MyBaseViewModel {
  //
  UserRequest userRequest = UserRequest();
  List<User> drivers = [];
  int selectedDriverId;

  void initialise() {
    fetchDrivers();
  }

  //
  fetchDrivers() async {
    setBusy(true);
    try {
      drivers = await userRequest.getUsers(
        role: "driver",
      );
      clearErrors();
    } catch (error) {
      print("Users Error ==> $error");
      setError(error);
    }

    setBusy(false);
  }

  //
  changeSelectedDriver(int driverId) {
    selectedDriverId = driverId;
    notifyListeners();
  }
}
