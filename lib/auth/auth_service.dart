import 'package:flutter/material.dart';
import 'package:live_order_apps/pages/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';

class AuthService {
  Future<AuthResponse> signInWithEmailAndPassword({required String email, required String password}) async {
    return await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> checkUser(
    String email,
    String password,
    GlobalKey<FormState> formKey,
  ) async {
    if (formKey.currentState!.validate()) {
      try {
        final response = await signInWithEmailAndPassword(email: email, password: password);
        final user = response.user;
        if (user != null) {
          final data = await supabase.from('persons').select('role').eq('id', user.id).single();
          if (data['role'] == 'restaurant_owner') {
            Navigator.of(formKey.currentContext!).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            ScaffoldMessenger.of(formKey.currentContext!).showSnackBar(SnackBar(content: Text('User is not a restaurant owner')));
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(formKey.currentContext!).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}
