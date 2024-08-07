import 'package:flutter/material.dart';

class BloodDonationFormPage extends StatefulWidget {
  @override
  _BloodDonationFormPageState createState() => _BloodDonationFormPageState();
}

class _BloodDonationFormPageState extends State<BloodDonationFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedGender;
  String? _bloodType;

  //int _unitsNeeded = 1;
  String? _reason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donation Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Numero'),
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
                decoration: InputDecoration(labelText: 'email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: ' Localisation '),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter additional location details';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: ' centre de santé '),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter additional location details';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: InputDecoration(labelText: 'Sexe'),
                  items: ['Homme', 'Femme', 'Autre']
                      .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'selectionner le sexe';
                    }
                    return null;
                  },
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
              TextFormField(
                decoration: InputDecoration(labelText: "plus d'information"),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter details of your request';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
                        //Text('Units needed'),
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("")));
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

