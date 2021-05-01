class Validators {
  String isEmpty(value) {
    if (value.isEmpty) {
      return 'Empty field';
    }
    return null;
  }

  String isAlpha(val) {
    final regex = RegExp(r'^[a-zA-Z ]+$');
    if (!regex.hasMatch(val)) {
      return 'enter letters only';
    }
    return null;
  }

  String isNumeric(val) {
    bool valid(val) => double.tryParse(val) != null;
    if (!valid(val)) {
      return 'all digits must be numeric';
    }
    return null;
  }

  String limit(value, {int min = 0, int max = 0, String msg}) {
    if (min != 0 && value.length < min) {
      return msg != null ? msg : '$min minimum characters';
    } else if (max != 0 && value.length > max) {
      return msg != null ? msg : '$max maximum characters';
    }
    return null;
  }

  String isEmail(value) {
    if (!RegExp(
            r"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$")
        .hasMatch(value)) {
      return 'email is invalid';
    }
    return null;
  }
}

