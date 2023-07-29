import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ep_organization/views/authentication/signup_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../models/ep_user_model.dart';
import '../../providers/profile_provider.dart';
import '../../utils/ep_validators.dart';
import '../../widgets/ep_logo.dart';
import '../../widgets/ep_primary_button.dart';
import '../../widgets/ep_text_button.dart';
import '../../widgets/ep_text_field.dart';
import '../home/homescreen.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 0.15.sh),
                const EPLogo(),
                SizedBox(height: 0.15.sh),
                EPTextField(
                  hintText: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                EPTextField(
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    const Spacer(),
                    EPTextButton(
                      title: 'Forgot Password?',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) async {
                    if (state is SignedIn) {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      FirebaseFirestore firebaseFirestore =
                          FirebaseFirestore.instance;
                      EPUser? user = EPUser(
                        uuid: auth.currentUser?.uid,
                        email: auth.currentUser?.email,
                      );
                      final result = await firebaseFirestore
                          .collection('users')
                          .doc(auth.currentUser?.uid)
                          .get();
                      if (result.exists) {
                        Map? data = result.data();
                        user.displayName = data?['name'];
                      }

                      profileProvider.setUser(user);
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const HomeScreen();
                          }),
                          (route) => false,
                        );
                      }
                    }
                    if (state is SigningInError && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SigningIn) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return EPPrimaryButton(
                      title: 'Login',
                      onTap: () {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          if (EPValidators.isValidEmail(emailController.text)) {
                            authenticationBloc.add(
                              Login(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all the fields'),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    EPTextButton(
                      title: 'Register',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
