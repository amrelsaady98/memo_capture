import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:memo_capture/core/services/remote_services/auth_api_service.dart';

import '../../utils/base/data_state/data_state.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthProvider {
  AuthProvider(this._authApiService);

  final AuthApiService _authApiService;

  Future<DataState<LoginResponse>> fetchLogin(LoginRequest request) async {
    // TODO: implement Api
    LoginResponse response = await _authApiService.fetchLogin(request);
    if (response.success ?? false) {
      return DataSuccess<LoginResponse>(response);
    } else {
      return DataField<LoginResponse>(
        GetHttpException(
          response.message ?? "error from authRepo",
        ),
      );
    }
  }

  @override
  Future<DataState<Response>> fetchRegister(
      {required String name, required String email, required String password}) {
    // TODO: implement fetchRegister
    throw UnimplementedError();
  }
}