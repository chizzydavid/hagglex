import 'package:hagglex/core/models/error_model.dart';
import 'package:hagglex/core/models/user_model.dart';
import 'package:hagglex/core/services/graphql_client.dart';
import 'package:hagglex/core/services/mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthClient {
  final GraphQLClient client = GraphQLConfiguration.graphQLClient();
  
  Future<dynamic> registerUser(Map<String, String> user) async {
    try {
      QueryResult response = await client.mutate(
        MutationOptions(documentNode: gql(Mutations.register(user)))
      );
      dynamic result = parseResponse(response);

      if (result is ErrorModel) return result.error;
      saveToken(result['register']['token']);
      return User.fromJson(result['register']['user']);

    } catch(e) {
      return e?.message;
    }
  }

  Future<dynamic> loginUser(Map<String, String> user) async {
    try {
      QueryResult response = await client.mutate(
        MutationOptions(documentNode: gql(Mutations.login(user)))
      );
      dynamic result = parseResponse(response);

      if (result is ErrorModel) return result.error;
      saveToken(result['login']['token']);
      return User.fromJson(result['login']['user']);
    } catch(e) {
      return e?.message;
    }
  }

  Future<dynamic> verifyUser(int code) async {
    try {
      GraphQLClient authenticatedClient = await setAuthToken();
      QueryResult response = await authenticatedClient.mutate(
        MutationOptions(documentNode: gql(Mutations.verifyUser(code)))
      );
      dynamic result = parseResponse(response);

      if (result is ErrorModel) return result.error;
      return true;
    } catch(e) {
      return e?.message;
    }
  }

   Future<dynamic> resendCode(String email) async {
    try {
      GraphQLClient authenticatedClient = await setAuthToken();
      QueryResult response = await authenticatedClient.mutate(
        MutationOptions(documentNode: gql(Mutations.sendVerificationCode(email)))
      );
      dynamic result = parseResponse(response);

      if (result is ErrorModel) return result.error;
      return 'Verification code sent';
    } catch(e) {
      return e?.message;
    }
  }

  dynamic parseResponse(QueryResult result) {
    if (result.hasException) {
      final error = 
        result.exception.clientException?.message ?? 
        result.exception.graphqlErrors[0].toString().split(":")[0];
      return ErrorModel(error);
    } else if (!result.hasException) {
      return result.data;
    }
  }

  Future<GraphQLClient> setAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return GraphQLConfiguration.graphQLClient(token: token);
  }

  saveToken(String token) async { 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

}


