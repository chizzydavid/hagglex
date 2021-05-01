import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/utils/constants.dart';

class GraphQLConfiguration {

  static GraphQLClient graphQLClient({String token}) {
    Link link;
    HttpLink httpLink = HttpLink(uri: API_URL);
    if (token != null) {
      AuthLink authLink = AuthLink(getToken: () => "Bearer $token");
      link = authLink.concat(httpLink);
    } 
    else link = httpLink;

    return GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    );
  }
}

