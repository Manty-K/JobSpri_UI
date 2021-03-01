import 'package:profile_ui/core/enums.dart';

class PersonalDetails {
  DateTime dob;
  Gender gender;
  var address;
  var hometown;
  int pin;
  MaritialStatus maritialStatus;
  var language;
  PersonalDetails({
    this.dob,
    this.gender,
    this.address,
    this.hometown,
    this.pin,
    this.maritialStatus,
    this.language,
  });
}
