

import 'package:flutter/material.dart';


class SubCatagoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
          padding: EdgeInsets.all(16),
          child: _buildTasks(context)

    );
  }

  Widget _buildTasks(BuildContext context) {
    return (
      Text(
        'sub catagory'
      ));
    
    
  }

}