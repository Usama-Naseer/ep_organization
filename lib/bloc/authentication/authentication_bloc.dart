import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<Register>((event, emit) async {
      emit(SigningUp());
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        await auth
            .createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        )
            .then((value) {
          firestore.collection('users').doc(value.user!.uid).set({
            'name': event.name,
            'email': event.email,
          });
          emit(SignedUp());
        });
      } catch (e) {
        emit(SigningUpError(message: e.toString()));
      }
    });
    on<Login>((event, emit) async {
      emit(SigningIn());
      try {
        await auth
            .signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        )
            .then((value) {
          emit(SignedIn());
        });
      } catch (e) {
        if (e is FirebaseAuthException) {
          emit(SigningInError(message: e.message!));
        } else {
          emit(SigningInError(message: e.toString()));
        }
      }
    });
    on<ForgotPassword>((event, emit) async {
      emit(ForgettingPassword());
      try {
        await auth.sendPasswordResetEmail(email: event.email).then((value) {
          emit(ForgotPasswordSuccess());
        });
      } catch (e) {
        emit(ForgotPasswordError(message: e.toString()));
      }
    });
    on<GuestLogin>((event, emit) async {
      emit(GuestSigningIn());
      try {
        await auth.signInAnonymously().then((value) {
          emit(GuestSignInSuccess());
        });
      } catch (e) {
        emit(
          GuestSignInFailed(
            message: e.toString(),
          ),
        );
      }
    });
  }
}
