import 'package:e_store/constants/toast.dart';

bool signInvalidation(String email, String password) {
  if (email.isEmpty || password.isEmpty) {
    showToast("Please fill all the fields");
    return false;
  } else {
    if (email.isEmpty) {
      showToast("Email is empty");
      return false;
    } else {
      if (password.isEmpty) {
        showToast("Password is empty");
        return false;
      }
    }
  }
  return true;
}

bool signUpvalidation(String email, String password, String name, String phone,
    String confirmpassword, String address) {
  if(email.isEmpty ||
      password.isEmpty ||
      name.isEmpty ||
      phone.isEmpty ||
      confirmpassword.isEmpty) {
    showToast("Please fill all the fields");
    return false;
  }  else {
    if (phone.length < 11 && phone.length>11) {
      showToast("Mobile number must be of 11 digits");
      return false;
    }
    else {
      if (password == confirmpassword) {
        return true;
      }
      else {
        showToast("Password do not match");
        return false;
      }
    }
  }
}
bool passwordChangevalidation( String password,
    String confirmpassword) {
  if(
      password.isEmpty ||

      confirmpassword.isEmpty) {
    showToast("Please fill all the fields");
    return false;
  }
    else {
      if (password == confirmpassword){
        return true;
      }
      else {
        showToast("Password do not match");
        return false;
      }
    }
  }

