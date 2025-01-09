import 'package:blog_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
   Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<String> loginWithEmailPassword({
    required String email, 
    required String password, 
  }) {
  // TODO
    throw UnimplementedError();
  }
  @override
  Future<String> signUpWithEmailPassword({
    required String name, 
    required String email, 
    required String password, 
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password, 
        email: email,
        // data: {
        //   'name':name,
        // }
      );
      if (response.user == null) {
        throw const ServerException('User is null.');
      }
      // If you want to store additional user data (e.g., name), do it after signing up
      final userId = response.user!.id;

      final userDataResponse = await supabaseClient.from('users').upsert({
        'id': userId,
        'name': name,
      });

      if (userDataResponse.error != null) {
        throw ServerException('Failed to store user data.');
      }

      return userId;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

}