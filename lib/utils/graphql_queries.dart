class GraphQLQueries {
  static const String getPastLaunches = r'''
  query GetPastLaunches($limit: Int!, $offset: Int!) {
    launchesPast(limit: $limit, offset: $offset, order: "desc", sort: "launch_date_local") {
      id
      mission_name
      launch_date_local
      links {
        article_link
        video_link
      }
      rocket {
        rocket_name
      }
      ships {
        name
        home_port
        image
      }
    }
  }
  ''';

  static const String getLaunch = r'''
  query GetLaunch($id: ID!) {
    launch(id: $id) {
      id
      mission_name
      launch_date_local
      links {
        article_link
        video_link
      }
      rocket {
        rocket_name
      }
      ships {
        name
        home_port
        image
      }
    }
  }
  ''';
}
