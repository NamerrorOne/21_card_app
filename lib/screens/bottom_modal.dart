import 'package:flutter/material.dart';

void showBottomSheet(BuildContext context, String titleText) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(titleText),
              // Добавьте любые другие виджеты или элементы интерфейса
            ],
          ),
        ),
      );
    },
  );
}
