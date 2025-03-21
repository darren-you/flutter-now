import 'package:dio/dio.dart';
import 'package:flutternow/models/app_user_model.dart';
import 'package:flutternow/models/app_version_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  /// 游客登录
  @GET('/api/user/login/visitor')
  Future<AppUserModel> loginByGuest();

  /// 获取短信验证码
  @POST('/api/user/code')
  Future getSMSCode({
    @Field() required String phone,
  });

  /// 手机号+验证码登录
  @POST('/api/user/login/code')
  Future<AppUserModel> loginByPhone({
    @Field() required String phone,
    @Field() required String code,
  });

  /// 第三方平台登录
  @POST('/api/user/login/tl')
  Future<AppUserModel> loginByPlatform({
    @Field('login_type') required int type,
    @Field('open_id') required String openId,
    required String avatar,
  });

  /// 手机号一键登录
  @POST('/api/user/login/phone')
  Future<AppUserModel> loginByPhoneVerify({
    @Field() required String token,
    @Field() required String gyuid,
  });

  /// 注销账号
  @DELETE('/api/user/del')
  Future deleteAccount();

  /// 获取当前登录用户信息
  @GET('/api/user/detail')
  Future<AppUserModel> getCurrentUser();

  /// 获取app版本，检查有没有更新
  @GET('/api/common/version')
  Future<AppVersionModel> getAppVersion();

  /// 获取app配置
  @GET('/api/common/config')
  Future getAppConfig();
}
