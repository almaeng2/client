import 'dart:io';

import 'package:dio/dio.dart';
import 'globals.dart';

const _API_HOUSEHOLD = "http://54.180.131.10:8080/api/v1/household";
const _API_SIGNUP = "http://54.180.131.10:8080/api/v1/auth/signup";
const _API_SIGNIN = "http://54.180.131.10:8080/api/v1/auth/signIn";
const _API_PRE = "http://54.180.131.10:8080/api/v1/medicine";
const _API_PRE_RE ="http://54.180.131.10:8080/api/v1/medicine?name={a}";
const _API_TOD = "http://54.180.131.10:8080/api/v1/medicine/checkTOD";
const _API_PREID = "http://54.180.131.10:8080/api/v1/medicine/{prescriptionId}";
const _API_SIMILAR = "http://54.180.131.10:8080/api/v1/medicine/similarity";

class Server {
  final Dio _dio = Dio();


  Future<Map<String, dynamic>?> postPill(File? imageFile1, File? imageFile2) async {
    if (imageFile1 == null || imageFile2 == null) {
      throw Exception('Both images must be provided');
    }

    try {
      print(accessToken);
      Options options = Options(
        headers: {
          "Authorization": accessToken!,
          "Content-Type": "multipart/form-data",
        },
      );

      // Prepare the form data with two images
      FormData formData = FormData.fromMap({
        'images': [
          await MultipartFile.fromFile(imageFile1.path),
          await MultipartFile.fromFile(imageFile2.path),
        ]
      });


      // Send the POST request
      Response response = await _dio.post(
        _API_SIMILAR, // Assuming the same endpoint for posting two images
        options: options,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['result'];
      } else {
        throw Exception('Failed to retrieve household medicine information');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return null;
    } catch (e) {
      print('Unexpected POST request error: $e');
      return null;
    }
  }


  Future<List<dynamic>> getPrescriptionById(int prescriptionId) async {
    try {
      print(accessToken);
      // Authorization 헤더에 전역 토큰 추가
      Options options = Options(
        headers: {
          "Authorization": accessToken!,
        },
      );
      String url = _API_PREID.replaceAll('{prescriptionId}', prescriptionId.toString());
      Response response = await _dio.get(url, options: options);
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        List<dynamic> resultList = response.data['result'];
        return resultList;
      } else {
        throw Exception('Failed to load prescription');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return [];
    } catch (e) {
      print('Unexpected GET request error: $e');
      return [];
    }
  }



  Future<List<dynamic>> getPre() async {
    try {
      print(accessToken);
      // Authorization 헤더에 전역 토큰 추가
      Options options = Options(
        headers: {
          "Authorization": accessToken,
        },
      );
      Response response = await _dio.get(_API_PRE, options: options);
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        var data = response.data['result']['lists'];
        return data;
      } else {
        throw Exception('Failed to load medicines');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return [];
    } catch (e) {
      print('Unexpected GET request error: $e');
      return [];
    }
  }

  Future<bool> signUp({
    required String userId,
    required String pw,
    required String username,
    required String level,
    required String birth,
  }) async {
    try {
      Response response = await _dio.post(
        _API_SIGNUP,
        data: {
          "userId": userId,
          "pw": pw,
          "username": username,
          "level": level,
          "birth": birth,
        },
      );
      print('Response data: ${response.data}');
      return true;
    } on DioException catch (e) {
      _handleDioError(e);
      return false;
    } catch (e) {
      print('Unexpected POST request error: $e');
      return false;
    }
  }


  Future<bool> signIn({
    required String id,
    required String pw,
  }) async {
    try {
      Response response = await _dio.post(
        _API_SIGNIN,
        data: {
          "id": id,
          "pw": pw,
        },
      );
      print('Response data: ${response.data}');
      if (response.statusCode == 200 ) {
        accessToken = response.data['result']['accessToken'];
        refreshToken = response.data['result']['refreshToken'];
        return true;
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return false;
    } catch (e) {
      print('Unexpected POST request error: $e');
      return false;
    }
  }

  Future<bool> deletePrescription(int prescriptionId) async {
    try {
      // Add authorization header
      Options options = Options(
        headers: {
          "Authorization": accessToken!,
        },
      );

      // Construct the URL with the prescriptionId
      String url = _API_PREID.replaceAll('{prescriptionId}', prescriptionId.toString());

      // Send the DELETE request
      Response response = await _dio.delete(
        url,
        options: options,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Prescription deleted successfully
        return true;
      } else {
        // Failed to delete prescription
        throw Exception('Failed to delete prescription');
      }
    } on DioException catch (e) {
      // Handle DioException
      _handleDioError(e);
      return false;
    } catch (e) {
      // Handle other exceptions
      print('Unexpected DELETE request error: $e');
      return false;
    }
  }


  Future<String?> postPrescription(File imageFile, String name) async {
    try {
      print(accessToken);
      Options options = Options(
        headers: {
          "Authorization": accessToken!,
          "Content-Type": "multipart/form-data",
        },
      );
      // Prepare the form data
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path),
      });
      String url2 = _API_PRE_RE.replaceAll('{a}', name);
      print(url2);
      // Send the POST request
      Response response = await _dio.post(
        url2,
        options: options,
        data: formData,
      );

      print('Response data: ${response.data}');
      if (response.statusCode == 200) {
        return response.data['msg'];
      } else {
        throw Exception('Failed to register prescription');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return null;
    } catch (e) {
      print('Unexpected POST request error: $e');
      return null;
    }
  }


  Future<String?> postTOD(File imageFile) async {
    try {
      print(accessToken);
      Options options = Options(
        headers: {
          "Authorization": accessToken!,
          "Content-Type": "multipart/form-data",
        },
      );

      // Prepare the form data
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path),
      });

      // Send the POST request
      Response response = await _dio.post(
        _API_TOD,
        options: options,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['result'];
      } else {
        throw Exception('Failed to retrieve household medicine information');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return null;
    } catch (e) {
      print('Unexpected POST request error: $e');
      return null;
    }
  }


  Future<Map<String, dynamic>?> postHousehold(File imageFile) async {
    try {
      print(accessToken);
      Options options = Options(
        headers: {
          "Authorization": accessToken!,
          "Content-Type": "multipart/form-data",
        },
      );
      // Prepare the form data
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path),
      });

      // Send the POST request
      Response response = await _dio.post(
        _API_HOUSEHOLD,
        options: options,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['result'];
      } else {
        throw Exception('Failed to retrieve household medicine information');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return null;
    } catch (e) {
      print('Unexpected POST request error: $e');
      return null;
    }

  }




  void _handleDioError(DioException e) {
    if (e.response != null) {
      print('Request error: ${e.response?.statusCode} ${e.response?.statusMessage}');
      if (e.response?.statusCode == 403) {
        print('Client error - Access forbidden');
      } else if (e.response?.statusCode == 404) {
        print('Error 404: ${e.response?.data}');
      } else if (e.response?.statusCode == 500) {
        print('Server error - Internal server error');
      }
    } else {
      print('Request error: ${e.message}');
    }
  }
}

// 싱글톤 인스턴스
final Server server = Server();
