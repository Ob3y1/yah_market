
import 'package:http/http.dart'as http;

class ServiceConf {

   static const domainNameServer = 'http://localhost:8000'; 

  //auth
  static const register = '/api/register';
    static const login = '/api/login';
        static const update = '/api/user';
        static const showUserInfo='/api/user';
          static const logout='/api/logout';


}