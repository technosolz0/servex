import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/data/models/service_model.dart';

class ServiceApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<List<ServiceModel>> fetchServices() async {
    final response = await _dio.get('/api/services/');

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((item) => ServiceModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load services');
    }
  }
}
