import 'dart:io';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:profile_ui/core/departments.dart';
import 'package:profile_ui/core/desired_locations.dart';
import 'package:profile_ui/core/enums.dart';
import 'package:profile_ui/core/languages.dart';
import 'package:profile_ui/pdf_preview.dart';
import 'package:profile_ui/widgets/field_text.dart';
import 'package:profile_ui/widgets/labbeled_checkbox.dart';
import 'package:profile_ui/widgets/labeled_radio_buttons.dart';
import 'package:profile_ui/widgets/section_text.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PersonalDetailsScreen extends StatefulWidget {
  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final pdf = pw.Document();

  DateTime _birthDate;

  //String _currentSelectedValue;
  var _firstName = TextEditingController();
  var _lastName = TextEditingController();
  var _expectedSalary = TextEditingController();

  List _myLanguages;
  String _myLanguagesResult;
  List _myDesiredLocations;
  String _myDesiredLocationsResult;
  String _myDepartment;
  String _myDepartmentResult;
  Gender _gender = Gender.Male;
  MaritialStatus _maritialStatus = MaritialStatus.Unmarried;
  Shift _shift = Shift.Day;
  bool isPermanent = false;
  bool isContractual = false;
  bool isFullTime = false;
  bool isPartTime = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _birthDate = DateTime.now();
    _myLanguages = [];
    _myDepartment = '';
  }

  void submit() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    if (formkey.currentState.validate()) {
      setState(() {
        _myDepartmentResult = _myDepartment;
        _myLanguagesResult = _myLanguages.toString();
        _myDesiredLocationsResult = _myDesiredLocations.toString();
      });
      formkey.currentState.save();
      writeOnPDF();
      await savePDF();
      String fullPath = '$documentPath/example.pdf';
      print('Hello $fullPath');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PDFPreviewScreen(fullPath)));
      print('Yess');
      print(_firstName.text);
      print(_myLanguages);
      //print(_myDesiredLocations);
    } else {
      print('No');
    }
  }

  void writeOnPDF() {
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Header(child: pw.Text(_firstName.text));
          }),
    );
  }

  Future savePDF() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;

    File file = File('$documentPath/example.pdf');
    print('$documentPath/example.pdf');
    file.writeAsBytesSync(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text('${_birthDate.day}/${_birthDate.month}/${_birthDate.year}'),
                  SectionText('Personal Details'),
                  TextFormField(
                    controller: _firstName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'First Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "First Name Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _lastName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Last Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Last Name Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  FieldText('Date of birth'),
                  RichText(
                      text: TextSpan(
                          text:
                              '${_birthDate.day}/${_birthDate.month}/${_birthDate.year}',
                          style: TextStyle(color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2222),
                                      initialDatePickerMode: DatePickerMode.day)
                                  .then((value) {
                                setState(() {
                                  _birthDate = value;
                                });
                              });
                            })),
                  FieldText('Gender'),
                  //GenderRadioButtons(),
                  Row(
                    children: [
                      LabeledRadioButton(
                        title: 'Male',
                        function: (val) {
                          setState(() {
                            _gender = val;
                          });
                        },
                        value: Gender.Male,
                        groupValue: _gender,
                      ),
                      LabeledRadioButton(
                        title: 'Female',
                        function: (val) {
                          setState(() {
                            _gender = val;
                          });
                        },
                        value: Gender.Female,
                        groupValue: _gender,
                      ),
                      LabeledRadioButton(
                        title: 'Transgender',
                        function: (val) {
                          setState(() {
                            _gender = val;
                          });
                        },
                        value: Gender.Transgender,
                        groupValue: _gender,
                      ),
                    ],
                  ),

                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1, //Normal textInputField will be displayed
                    maxLines: 2,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Address'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Address Required";
                      } else {
                        return null;
                      }
                    }, // when user presses enter it will adapt to it
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Hometown'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Hometown Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Pin'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Pin Required";
                      }
                      if (value.length != 6) {
                        return "Pin should be 6 digits";
                      } else {
                        return null;
                      }
                    },
                  ),
                  FieldText('Maritial Status'),
                  //MaritialStatusRadioButtons(),
                  Row(
                    children: [
                      LabeledRadioButton(
                          title: 'Unmarried',
                          function: (val) {
                            setState(() {
                              _maritialStatus = val;
                            });
                          },
                          value: MaritialStatus.Unmarried,
                          groupValue: _maritialStatus),
                      LabeledRadioButton(
                          title: 'Married',
                          function: (val) {
                            setState(() {
                              _maritialStatus = val;
                            });
                          },
                          value: MaritialStatus.Married,
                          groupValue: _maritialStatus),
                    ],
                  ),

                  MultiSelectFormField(
                    title: FieldText('Languages'),
                    dataSource: languages,
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    hintWidget: Text('Select one or more languages'),
                    errorText: 'Please select one or more languages',
                    required: true,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        _myLanguages = value;
                      });
                    },
                  ),
                  SectionText('Career Profile'),
                  DropDownFormField(
                    titleText: 'Department',
                    value: _myDepartment,
                    required: true,
                    errorText: 'Please Select Dapartment',
                    onSaved: (value) {
                      setState(() {
                        _myDepartment = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myDepartment = value;
                      });
                    },
                    dataSource: departments,
                    textField: 'display',
                    valueField: 'value',
                  ),
                  FieldText('Desired Job Type'),
                  Row(
                    children: [
                      LabeledCheckbox(
                        value: isPermanent,
                        title: 'Permanent',
                        function: (val) {
                          setState(() {
                            isPermanent = val;
                          });
                        },
                      ),
                      LabeledCheckbox(
                        value: isContractual,
                        title: 'Contractual',
                        function: (val) {
                          setState(() {
                            isContractual = val;
                          });
                        },
                      ),
                    ],
                  ),
                  FieldText('Desired Employment Type'),
                  Row(
                    children: [
                      LabeledCheckbox(
                          title: 'Full Time',
                          value: isFullTime,
                          function: (val) {
                            setState(() {
                              isFullTime = val;
                            });
                          }),
                      LabeledCheckbox(
                          title: 'Part Time',
                          value: isPartTime,
                          function: (val) {
                            setState(() {
                              isPartTime = val;
                            });
                          }),
                    ],
                  ),
                  FieldText('Prefered Shift'),
                  Row(children: [
                    LabeledRadioButton(
                      function: (val) {
                        setState(() {
                          _shift = val;
                        });
                      },
                      value: Shift.Day,
                      groupValue: _shift,
                      title: 'Day',
                    ),
                    LabeledRadioButton(
                      function: (val) {
                        setState(() {
                          _shift = val;
                        });
                      },
                      value: Shift.Night,
                      groupValue: _shift,
                      title: 'Night',
                    ),
                    LabeledRadioButton(
                      function: (val) {
                        setState(() {
                          _shift = val;
                        });
                      },
                      value: Shift.Flexible,
                      groupValue: _shift,
                      title: 'Flexible',
                    ),
                  ]),
                  TextFormField(
                    controller: _expectedSalary,
                    keyboardType: TextInputType.number,
                    minLines: 1, //Normal textInputField will be displayed
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expected Salary'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Salary Required";
                      } else {
                        return null;
                      }
                    }, // when user presses enter it will adapt to it
                  ),
                  MultiSelectFormField(
                    title: FieldText('Desired Locations'),
                    dataSource: desiredLocations,
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    hintWidget: Text('Select one or more locations'),
                    errorText: 'Please select one or more locations',
                    required: true,
                    onSaved: (value) {
                      if (value == null) return "Hey??";
                      setState(() {
                        _myDesiredLocations = value;
                      });
                    },
                  ),
                  OutlineButton(
                      child: Text('Submit'),
                      onPressed: () {
                        submit();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
