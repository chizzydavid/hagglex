import 'package:hagglex/utils/validators/index.dart';

class AuthValidators extends Validators{
  String name(value) {
    return isEmpty(value) ?? isAlpha(value) ?? limit(value, min: 2);
  }
  String isEmptyOrAlpha(value) {
    if (value == '') return null;
    return limit(value, min: 2) ?? isAlpha(value);
  }  
  String email(value) {
    return isEmpty(value) ?? isEmail(value);
  }
  
  String isNumeral(value) {
    return isEmpty(value) ?? isNumeric(value);
  }

  String password(value) {
    return isEmpty(value) ?? limit(value, min: 8);
  }
}


