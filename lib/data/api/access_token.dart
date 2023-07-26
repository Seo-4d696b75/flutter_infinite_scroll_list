
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'access_token.g.dart';

@Riverpod(keepAlive: true)
String accessToken(AccessTokenRef ref) {
  return const String.fromEnvironment('ACCESS_TOKEN');
}
