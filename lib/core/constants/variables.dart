class Variables {
  // set with host or ip address where the server is running
  static const String baseUrl = 'http://192.168.1.24/api';

  // Auth endpoints
  static const String register = '$baseUrl/register';
  static const String login = '$baseUrl/login';
  static const String logout = '$baseUrl/logout';
  static const String profile = '$baseUrl/profile';

  // Story endpoints
  static const String stories = '$baseUrl/stories';
  static const String myStories = '$baseUrl/my-stories';

  static String storyById(int id) => '$baseUrl/stories/$id';
}
