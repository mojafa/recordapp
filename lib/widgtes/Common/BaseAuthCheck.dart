import 'package:flutter/material.dart';
import 'package:record_app/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class BaseAuthCheck extends StatelessWidget {
  final Widget child;
  final Widget redirect;
  const BaseAuthCheck({this.child, this.redirect, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider provider =
        Provider.of<AuthenticationProvider>(context);
    return Container(
      child: provider.isLoggedIn ? redirect : child,
    );
  }
}
