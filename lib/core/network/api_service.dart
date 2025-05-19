import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('{path}')
  Future<dynamic> get(
    @Path('path') String path,
    @Queries() Map<String, dynamic>? queryParameters,
  );

  @POST('{path}')
  Future<dynamic> post(
    @Path('path') String path,
    @Body() dynamic body,
    @Queries() Map<String, dynamic>? queryParameters,
  );

  @PUT('{path}')
  Future<dynamic> put(
    @Path('path') String path,
    @Body() dynamic body,
    @Queries() Map<String, dynamic>? queryParameters,
  );

  @DELETE('{path}')
  Future<dynamic> delete(
    @Path('path') String path,
    @Queries() Map<String, dynamic>? queryParameters,
  );
}
