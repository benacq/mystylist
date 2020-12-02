import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/responsive.dart';
import '../../../reusablecomponents/button.dart';
import '../../../reusablecomponents/label.dart';
import '../../../reusablecomponents/label_seperator.dart';
import '../../../reusablecomponents/textbox_seperator.dart';
import '../../../reusablecomponents/txt_decoration.dart';

class AddServiceform extends StatelessWidget {
  const AddServiceform({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(
            labeltext: 'Service name',
          ),
          LabelSeperator(),
          TextFormField(
            style: TextStyle(color: UiColors.color3),
            decoration: textInputDecoration(hint: 'Hair cut'),
          ),
          TextboxSeperator(),
          Label(
            labeltext: 'Price',
          ),
          LabelSeperator(),
          TextFormField(
            style: TextStyle(color: UiColors.color3),
            decoration: textInputDecoration(hint: 'Ghc 10'),
          ),
          TextboxSeperator(),
          Label(
            labeltext: 'Estimated duratuin',
          ),
          LabelSeperator(),
          TextFormField(
            style: TextStyle(color: UiColors.color3),
            decoration: textInputDecoration(hint: '30 minutes'),
          ),
          TextboxSeperator(),
          Label(
            labeltext: 'Number of booking expected per day',
          ),
          LabelSeperator(),
          TextFormField(
            style: TextStyle(color: UiColors.color3),
            decoration: textInputDecoration(hint: '20'),
          ),
          SizedBox(
            height: screenHeight(context, 0.07),
          ),
          ReusableButton(
            onpress: () {},
            label: Text('Add'),
          ),
        ],
      ),
    );
  }
}