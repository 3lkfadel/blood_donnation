import 'package:flutter/material.dart';

class BloodDonationFormPage extends StatefulWidget {
  @override
  _BloodDonationFormPageState createState() => _BloodDonationFormPageState();
}

class _BloodDonationFormPageState extends State<BloodDonationFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  String? _bloodType;
  // int _unitsNeeded = 1;
  String? _reason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Gender'),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Male'),
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Female'),
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Blood Type'),
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  _buildBloodTypeChip('A+'),
                  _buildBloodTypeChip('A-'),
                  _buildBloodTypeChip('B+'),
                  _buildBloodTypeChip('B-'),
                  _buildBloodTypeChip('AB+'),
                  _buildBloodTypeChip('AB-'),
                  _buildBloodTypeChip('O+'),
                  _buildBloodTypeChip('O-'),
                ],
              ),
              SizedBox(height: 16),
              Text('Units needed'),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     IconButton(
              //       icon: Icon(Icons.remove),
              //       onPressed: () {
              //         setState(() {
              //           if (_unitsNeeded > 1) {
              //             _unitsNeeded--;
              //           }
              //         });
              //       },
              //     ),
              //     Text('$_unitsNeeded'),
              //     IconButton(
              //       icon: Icon(Icons.add),
              //       onPressed: () {
              //         setState(() {
              //           _unitsNeeded++;
              //         });
              //       },
              //     ),
              //   ],
              // ),
              SizedBox(height: 16),
              Text('Reason'),
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  _buildReasonChip('Accident'),
                  _buildReasonChip('Surgery'),
                  _buildReasonChip('Other'),
                  _buildReasonChip('Pregnancy'),
                  _buildReasonChip('I prefer not say'),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                 
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBloodTypeChip(String bloodType) {
    return ChoiceChip(
      label: Text(bloodType),
      selected: _bloodType == bloodType,
      onSelected: (selected) {
        setState(() {
          _bloodType = selected ? bloodType : null;
        });
      },
    );
  }

  Widget _buildReasonChip(String reason) {
    return ChoiceChip(
      label: Text(reason),
      selected: _reason == reason,
      onSelected: (selected) {
        setState(() {
          _reason = selected ? reason : null;
        });
      },
    );
  }
}
