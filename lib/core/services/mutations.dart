import 'dart:convert';

class Mutations {
  static String register(Map<String, String> user) {
    return """
      mutation{
        register(
          data: {
            email: ${jsonEncode(user['email'])}
            username: ${jsonEncode(user['username'])}
            password: ${jsonEncode(user['password'])}
            phonenumber: ${jsonEncode(user['phoneNumber'])}
            referralCode: ""
            phoneNumberDetails: {
              phoneNumber: "901234566"
              callingCode:""
              flag: ""
            }
            country: "234"
            currency: "NGN"
          }
        ){
          user{
            _id
            email
            username
            emailVerified
            phoneNumberVerified
          }
          token
        }
      }
    """;
  }


  static String login(Map<String, String> user) {
    return """
      mutation{
        login(
          data: {
            input: ${jsonEncode(user['email'])}
            password: ${jsonEncode(user['password'])} 
          }
        ){
          user{
            _id
            email
            username
            emailVerified
            phoneNumberVerified     
          }
          token
        }
      }
    """;
  }


  static String verifyUser(int code) {
    return """
      mutation{
        verifyUser(
          data: {
            code: $code
          }
        ){
          user{
            _id
            email
            username
            emailVerified
            phoneNumberVerified
          }
          token
        }
      }
    """;
  }


  static String sendVerificationCode(String email) {
    return """
      query{
        resendVerificationCode(
          data: {
            email: ${jsonEncode(email)}
          }
        )
      }
    """;
  }
}


