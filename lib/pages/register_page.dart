import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      Navigator.pushReplacementNamed(
        context,
        Routes.home,
        arguments: {
          'name': _nameController.text,
          'email': _emailController.text,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              const Center(child: Text('Регистрация', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
              const SizedBox(height: 30),
              CustomTextFormField(inputType: InputFieldType.name, labelText: 'ФИО', hintText: 'Иванов Иван Иванович', prefixIcon: const Icon(Icons.person), controller: _nameController),
              const SizedBox(height: 16),
              CustomTextFormField(inputType: InputFieldType.email, labelText: 'Email', hintText: 'example@mail.com', prefixIcon: const Icon(Icons.email), controller: _emailController),
              const SizedBox(height: 16),
              CustomTextFormField(inputType: InputFieldType.password, labelText: 'Пароль', hintText: 'Введите пароль', prefixIcon: const Icon(Icons.shield), controller: _passwordController),
              const SizedBox(height: 16),
              CustomTextFormField(inputType: InputFieldType.password, labelText: 'Повторите пароль', hintText: 'Повторите пароль', prefixIcon: const Icon(Icons.shield), controller: _confirmController, textInputAction: TextInputAction.done, onFieldSubmitted: _submit),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  child: const Text('Зарегистрироваться'),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Уже есть аккаунт? '),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, Routes.login),
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    child: const Text('Войдите'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}