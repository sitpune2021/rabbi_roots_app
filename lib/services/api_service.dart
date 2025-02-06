import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rabbi_roots/models/category2.dart';

class ApiService {
  final String baseUrl = "http://192.168.1.55:8080/RabbiRoot-15-01-2025/APP";
  final String signUpUrl = 'https://rabbiroots.com/APP/signup.php';
  final String verifyOtpUrl =
      'https://rabbiroots.com/APP/signup_verification.php';

  // Helper function to handle the API request and error
  Future<Map<String, dynamic>> _apiRequest(
      String url, Map<String, String> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      print('Response: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          "status": "error",
          "message": "Failed to connect to the server"
        };
      }
    } catch (e) {
      print("Error: $e");
      return {"status": "error", "message": e.toString()};
    }
  }

  // Sign-up API call
  Future<Map<String, dynamic>> signUp(
      String name, String email, String mobile, String password) async {
    Map<String, String> requestBody = {
      "name": name,
      "email": email,
      "mobile_no": mobile,
      "password": password,
    };

    return await _apiRequest(signUpUrl, requestBody);
  }

  // OTP verification API call
  Future<Map<String, dynamic>> verifyOtp(String regNo, String flag) async {
    Map<String, String> requestBody = {
      "reg_no": regNo,
      "flag": flag,
    };

    return await _apiRequest(verifyOtpUrl, requestBody);
  }

  // Sign-in API call
  Future<Map<String, dynamic>> signin(String username, String password) async {
    Map<String, String> requestBody = {
      "username": username,
      "password": password,
    };

    return await _apiRequest('$baseUrl/signin.php', requestBody);
  }

  // Fetch categories dynamically
  Future<List<Category>> fetchCategoriesFromBackend() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/category.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"key": "Active"}),
      );
      print('Categories response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> responseList = data['responce'] ?? [];

        return responseList.map((item) {
          final String id = item['id'] ?? '';
          final String name = item['category_title'] ?? '';
          final String filepath = item['filepath'] ?? '';
          final String static_image =
              'https://rabbiroots.com/assets/images/blank_image.png';
          final String imageUrl = filepath.isEmpty || filepath == "0"
              ? static_image
              : filepath; // API image URL

          return Category(
            name: name,
            imageUrl: imageUrl,
            subcategories: [], id: id, // Populate subcategories if needed
          );
        }).toList();
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }

  // Fetch subcategories dynamically
  Future<List<String>> fetchSubcategories(String categoryId) async {
    try {
      final body = {
        'key': 'Active', // 'Active' or 'All'
        'cat_id': categoryId,
      };
      print(body);

      final response = await http.post(
        Uri.parse('$baseUrl/subCategory.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('subcategories')) {
          return List<String>.from(data['subcategories']);
        } else {
          throw Exception('Subcategories not found in the response');
        }
      } else {
        throw Exception('Failed to load subcategories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching subcategories: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchProducts(
      String categoryId, String subcategoryId) async {
    try {
      final body = {
        'key': 'Active',
        'cat_id': categoryId,
        'subcat_id': subcategoryId,
      };
      print(body);

      final response = await http.post(
        Uri.parse('$baseUrl/products.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('responce')) {
          return List<Map<String, dynamic>>.from(data['responce'].map((item) {
            return {
              'id': item['id'] ?? '',
              'name': item['name'] ?? 'Unknown',
              'weight': item['weight'] ?? '',
              'price': item['price'] ?? '',
              'mrp': item['mrp'] ?? '',
              'discount': item['discount'] ?? '',
              'deliveryTime': item['deliveryTime'] ?? '',
              'imageUrl': item['imageUrl'] ?? '',
            };
          }));
        } else {
          throw Exception('Products not found in the response');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchUserData(String regNo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/profileData.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'reg_no': regNo}),
      );
      print('User data response: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          "status": "error",
          "message": "Failed to connect to the server"
        };
      }
    } catch (e) {
      print("Error: $e");
      return {"status": "error", "message": e.toString()};
    }
  }

  // Future<Map<String, dynamic>> fetchRegisteredUsers() async {
  //   final response = await http.post(Uri.parse('$baseUrl/registered_users'));
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to load registered users');
  //   }
  // }

  Future<Map<String, dynamic>> fetchRegisteredUsers() async {
    final body = {
      'key': 'All', // 'Active' or 'All'
    };
    print(body);

    final response = await http.post(
      Uri.parse('$baseUrl/getAllUsersInfo.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load registered users');
    }
  }
}
