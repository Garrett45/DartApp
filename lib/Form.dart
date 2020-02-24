import 'package:flutter/material.dart';
import 'CRUDOps.dart';

class Input {
  bool haveAuto;
  bool moveInAuto;
  bool shootInAuto;
  int autoRating;
  String autoComment;

  Input({
    this.haveAuto = false,
    this.moveInAuto = false,
    this.shootInAuto = false,
    this.autoRating = 3,
    this.autoComment
  });

  Map<String, dynamic> toMap() {
    return {
      'haveAuto': haveAuto,
      'moveInAuto': moveInAuto,
      'shootInAuto': shootInAuto,
      'autoRating': autoRating,
      'autoComment': autoComment
    };
  }

  save() {
    print('saving user using a web service');
  }
}


class CustomForm extends StatefulWidget {
  const CustomForm({
    Key key,
    this.teamNumber,
  }) : super(key: key);

  final int teamNumber;

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  final _input = Input();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text('Autonomous'),
                          ),
                          SwitchListTile(
                              title: const Text('Does the team have auto?'),
                              value: _input.haveAuto,
                              onChanged: (bool val) =>
                                  setState(() => _input.haveAuto = val)),
                          SwitchListTile(
                              title: const Text('Does the robot move during auto?'),
                              value: _input.moveInAuto,
                              onChanged: (bool val) =>
                                  setState(() => _input.moveInAuto = val)),
                          SwitchListTile(
                              title: const Text('Does the team shoot in auto?'),
                              value: _input.shootInAuto,
                              onChanged: (bool val) =>
                                  setState(() => _input.shootInAuto = val)),
                          TextFormField(
                            decoration:
                            InputDecoration(
                                labelText: 'Rate the team\'s auto from 1 to 5 ',
                                hintText: '(1 = terrible, 2 = bad, 3 = average, 4 = good, 5 = terrific)'
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please give an autonomous rating';
                              }
                              else {
                                return null;
                              }
                            },
                            onSaved: (val) =>
                                setState(() => _input.autoRating = int.parse(val)),
                          ),
                          TextFormField(
                            decoration:
                            InputDecoration(labelText: 'Any additional comments about the team\'s auto?', ),
                            onSaved: (val) =>
                                setState(() => _input.autoComment = val),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                            child: Text('Teleop'),
                          ),

                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: RaisedButton(
                                  onPressed: () {
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      _input.save();
                                      _showDialog(context);

                                      createRecord(widget.teamNumber, _input.toMap());
                                    }
                                  },
                                  child: Text('Save'))),
                        ])))));
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}