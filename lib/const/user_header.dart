import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/const/app_constant_imports.dart';
import 'package:summarize_app/view_model/firebase/firebase_auth.dart';

class UserHeader extends StatelessWidget {
  final String message;
  const UserHeader({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<FirebaseAuthProvider>(context);
    return Container(
      padding: const EdgeInsets.all(AppDimension.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Text(
              message,
              style: AppTextStyle.heading2,
              overflow: TextOverflow.clip,
            ),
          ),
          CircleAvatar(
            radius: 35,
            backgroundColor: AppColor.kSecondaryColor,
            child: Text(
              authProvider.username.substring(0, 2),
              style: AppTextStyle.heading3,
            ),
            //child: Image.asset(''),
          ),
        ],
      ),
    );
  }
}
