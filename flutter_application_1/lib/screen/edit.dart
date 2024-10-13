import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/cubit/user_state.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditInfoScreen extends StatefulWidget {
  const EditInfoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _passwordController = TextEditingController();
  final List<String> _genders = ['Male', 'Female'];

  late AnimationController _controller;
  late Animation<Color?> _backgroundColor;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundColor = ColorTween(
      begin: Colors.greenAccent, // Start with green
      end: Colors.yellowAccent, // End with yellow
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is GetUserLoading) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("success Edit")));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AnimatedBackgroundPage(),
          ),
          (route) => false,
        );
      } else if (state is GetUserFailure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errMessage)));
      }
    }, builder: (context, state) {
      return AnimatedBuilder(
        animation: _backgroundColor,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Information',
                  style: TextStyle(color: Colors.black)), // Change title color
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            extendBodyBehindAppBar: true,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _backgroundColor.value ?? Colors.greenAccent,
                    Colors.yellowAccent.shade100, // Use a light yellow
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 100),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            // Name Field with Icon
                            _buildTextField(
                              controller:
                                  context.read<UserCubit>().editnameController,
                              label: 'Name',
                              icon: Icons.person,
                            ),
                            const SizedBox(height: 20),
                            // Email Field with Icon
                            _buildTextField(
                              controller:
                                  context.read<UserCubit>().editemailController,
                              label: 'Email',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),
                            // Password Field with Icon
                            _buildTextField(
                              controller: _passwordController,
                              label: 'Password',
                              icon: Icons.lock,
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            // Gender Dropdown
                            _buildDropdownField(),
                            const SizedBox(height: 20),
                            // Birth Date Field with Icon
                            _buildTextField(
                              controller: context
                                  .read<UserCubit>()
                                  .editbirthDateController,
                              label: 'Birth Date',
                              icon: Icons.calendar_today,
                              keyboardType: TextInputType.datetime,
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                    // Centered button at the bottom

                    ElevatedButton(
                      onPressed: () {
                        context.read<UserCubit>().updateUser(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.greenAccent, // Green button
                        elevation: 5,
                      ),
                      child: state is GetUserLoading
                          ? const CircularProgressIndicator()
                          : const Text('Save Changes',
                              style:
                                  TextStyle(color: Colors.white)), // White text
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black), // Icon color
        hintText: 'Enter your $label',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade400), // Border color
        ),
        filled: true,
        fillColor: Colors.white, // White background for text fields
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black), // Text color
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: prefs.getString("gender").toString(),
        prefixIcon:
            const Icon(Icons.person_outline, color: Colors.black), // Icon color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade400), // Border color
        ),
        filled: true,
        fillColor: Colors.white, // White background for dropdown
      ),
      value: context.read<UserCubit>().editselectedGender,
      items: _genders.map((gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender,
              style: const TextStyle(color: Colors.black)), // Text color
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          context.read<UserCubit>().editselectedGender = newValue;
        });
      },
    );
  }
}
