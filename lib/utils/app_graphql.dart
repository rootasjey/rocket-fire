import 'package:graphql/client.dart';

class AppGraphQL {
  static GraphQLClient _client = GraphQLClient(
    /// **NOTE** The default store is the InMemoryStore,
    /// which does NOT persist to disk
    cache: GraphQLCache(),
    link: HttpLink(
      'https://api.spacex.land/graphql/',
    ),
  );

  GraphQLClient get client => _client;
}

final appGraphQL = AppGraphQL();
