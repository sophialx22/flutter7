import 'package:flutter/material.dart';
import '../widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
      _nameController.text = args['name'] ?? '';
      _emailController.text = args['email'] ?? '';
    }
  }

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Профиль сохранён')));
      Navigator.pop(context, {
        'name': _nameController.text,
        'email': _emailController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
        title: const Text('Профиль'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Center(child: CircleAvatar(radius: 60, backgroundImage: NetworkImage('https://img.icons8.com/color/256/dog.png'))),
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
                  child: const Text('Сохранить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}