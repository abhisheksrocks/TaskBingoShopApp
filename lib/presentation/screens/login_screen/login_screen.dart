import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bingo_shop/presentation/bloc/login_bloc.dart';

class FormData extends Equatable {
  String username;
  String password;
  FormData({
    this.username = '',
    this.password = '',
  });

  @override
  List<Object?> get props => [username, password];
}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  FormData _formData = FormData();

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Processing Data')),
      // );
      context.read<LoginBloc>().add(
            LoginUser(
              username: _formData.username,
              password: _formData.password,
            ),
          );
    }
  }

  @override
  void initState() {
    context.read<LoginBloc>().stream.listen((state) {
      if (state is LoginError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          _formData.username = value;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          _formData.password = value;
                        }
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      onFieldSubmitted: (_) {
                        _submit(context);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submit(context);
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder(
            bloc: context.read<LoginBloc>(),
            builder: (context, state) {
              if (state is Loading) {
                return const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
