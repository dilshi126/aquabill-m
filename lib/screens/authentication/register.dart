 import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/description.dart';
import '../../constants/styles.dart';
import '../../services/auth.dart';
import 'package:flutter_auth/screens/home/home.dart';

class Register extends StatefulWidget {
  final Function toggle;
  const Register({Key? key, required this.toggle}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  // User details states
  String username = "";
  String email = "";
  String nic = "";
  String accountNumber = "";
  String province = "";
  String district = "";
  String password = "";
  String confirmPassword = "";
  String error = "";

  // List of provinces in Sri Lanka
  List<String> provinces = [
    "Western",
    "Central",
    "Southern",
    "Northern",
    "Eastern",
    "North Western",
    "North Central",
    "Uva",
    "Sabaragamuwa"
  ];

  Map<String, List<String>> districts = {
    "Western": ["Colombo", "Gampaha", "Kalutara"],
    "Central": ["Kandy", "Matale", "Nuwara Eliya"],
    "Southern": ["Galle", "Matara", "Hambantota"],
    "Northern": ["Jaffna", "Kilinochchi", "Mannar", "Vavuniya", "Mullaitivu"],
    "Eastern": ["Batticaloa", "Ampara", "Trincomalee"],
    "North Western": ["Kurunegala", "Puttalam"],
    "North Central": ["Anuradhapura", "Polonnaruwa"],
    "Uva": ["Badulla", "Moneragala"],
    "Sabaragamuwa": ["Ratnapura", "Kegalle"]
  };

  String selectedProvince = "Western";
  String selectedDistrict = "Colombo";

  // Function to measure password strength (basic implementation)
  String measurePasswordStrength(String password) {
    if (password.length >= 8 && password.contains(RegExp(r'[A-Z]')) && password.contains(RegExp(r'[0-9]'))) {
      return "Strong";
    } else if (password.length >= 6) {
      return "Medium";
    } else {
      return "Weak";
    }
  }

// Function to get corresponding color for the password strength
  Color getPasswordStrengthColor(String strength) {
    switch (strength) {
      case "Strong":
        return Colors.green; // Green for strong passwords
      case "Medium":
        return Colors.yellow; // Yellow for medium passwords
      case "Weak":
        return Colors.red; // Red for weak passwords
      default:
        return Colors.grey; // Default color
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgBlack,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Column(
            children: [
              const SizedBox(height: 30),
              // App name
              const Center(
                child: Text(
                  "AquaBill",
                  style: TextStyle(
                    color: Colors.blue, // App name color
                    fontWeight: FontWeight.bold, // Bold font
                    fontSize: 32, // Large font size
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Description text
              const Text(
                description,
                style: descriptionStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Register screen title
              const Text(
                "REGISTER",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: Image.asset(
                  'assets/images/man.png',
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Username field
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: textInputDecoration.copyWith(hintText: "Username"),
                        validator: (val) => val!.isEmpty ? "Enter a valid username" : null,
                        onChanged: (val) {
                          setState(() {
                            username = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Email field
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: textInputDecoration.copyWith(hintText: "Email"),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter an email address";
                          }
                          // Use RegExp to validate the email format
                          String pattern = r'\w+@\w+\.\w+';
                          RegExp regExp = RegExp(pattern);
                          if (!regExp.hasMatch(val)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),


                      // NIC field
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: textInputDecoration.copyWith(hintText: "NIC"),
                        validator: (val) => val!.isEmpty ? "Enter your NIC" : null,
                        onChanged: (val) {
                          setState(() {
                            nic = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Account number field
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: textInputDecoration.copyWith(hintText: "Account Number"),
                        validator: (val) => val!.isEmpty ? "Enter your account number" : null,
                        onChanged: (val) {
                          setState(() {
                            accountNumber = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Province dropdown
                      DropdownButtonFormField<String>(
                        value: selectedProvince,
                        dropdownColor: bgBlack,
                        decoration: textInputDecoration.copyWith(hintText: "Select Province"),
                        items: provinces.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedProvince = val!;
                            selectedDistrict = districts[selectedProvince]!.first; // Reset district
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // District dropdown
                      DropdownButtonFormField<String>(
                        value: selectedDistrict,
                        dropdownColor: bgBlack,
                        decoration: textInputDecoration.copyWith(hintText: "Select District"),
                        items: districts[selectedProvince]!.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedDistrict = val!;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password field
                      TextFormField(
                        obscureText: true,
                        style: const TextStyle(color: Colors.black),
                        decoration: textInputDecoration.copyWith(hintText: "Password"),
                        validator: (val) => val!.length < 6 ? "Password must be at least 6 characters" : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      const SizedBox(height: 10),

                      // Password strength indicator
                      Text(
                        "Password Strength: ${measurePasswordStrength(password)}",
                        style: TextStyle(color: Colors.yellowAccent),
                      ),
                      const SizedBox(height: 20),

                      // Confirm Password field
                      TextFormField(
                        obscureText: true,
                        style: const TextStyle(color: Colors.black),
                        decoration: textInputDecoration.copyWith(hintText: "Confirm Password"),
                        validator: (val) => val != password ? "Passwords do not match" : null,
                        onChanged: (val) {
                          setState(() {
                            confirmPassword = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Error text
                      Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                      ),

                      // Register button
                      GestureDetector(
                        // Register button onTap function
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            if (result != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Home()), // Redirect to Home
                              );
                            } else {
                              setState(() {
                                error = "Please enter a valid email!";
                              });
                            }
                          }
                        },

                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            color: bgBlack,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: mainYellow),
                          ),
                          child: const Center(
                            child: Text(
                              "REGISTER",
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                // login prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Do you have an account?",
                      style: descriptionStyle,
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: const Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: mainBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )

                    ],
                  ),
                ]

                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
