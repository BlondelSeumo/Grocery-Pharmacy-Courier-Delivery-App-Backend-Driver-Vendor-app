import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/services/http.service.dart';

class SettingsRequest extends HttpService {
  //
  Future<ApiResponse> appSettings() async {
    final apiResult = await get(
      Api.appSettings
    );
    return ApiResponse.fromResponse(apiResult);
  }

}
