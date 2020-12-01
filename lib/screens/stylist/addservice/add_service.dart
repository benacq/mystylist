import 'package:flutter/material.dart';
import 'package:my_stylist/screens/reusablecomponents/header.dart';
import 'package:my_stylist/screens/stylist/addservice/components/form.dart';
import '../../../utils/colors.dart';

class AddService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.color2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader(
                  header: 'Add Service',
                ),
                SizedBox(
                  height: 20,
                ),
                AddServiceform(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
