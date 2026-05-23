import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Jika lebar layar di atas 800 (Web Target), tampilkan berdampingan kiri-kanan
          if (constraints.maxWidth > 800) {
            return _buildWebLayout(context);
          } 
          // Jika layar sempit (Mobile Target), tampilkan layout vertikal
          else {
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  // ==================== 1. UI DESIGN - WEB TARGET (CHROME) ====================
  Widget _buildWebLayout(BuildContext context) {
    return Row(
      children: [
        // Sisi Kiri: Konten Banner "Jelajahi hal-hal yang sukai" beserta Ilustrasi Gambar
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Ikon Bulat Facebook Khas Gambar Utama
                Image.asset(
                  'assets/images/fb_logo.png',
                  width: 70,
                  height: 70,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 70);
                  },
                ),
                const SizedBox(height: 40),
                // Teks Besar Utama Berwarna Gelap dengan Aksen Biru di Akhir Kata
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C1E21),
                      height: 1.2,
                    ),
                    children: [
                      TextSpan(text: 'Jelajahi\nhal-hal\nyang '),
                      TextSpan(
                        text: 'sukai.',
                        style: TextStyle(color: Color(0xFF1877F2)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Ruang Kosong / Tempat Menampilkan Elemen Gambar Ilustrasi Bertumpuk Seperti Gambar Anda
                Container(
                  height: 250,
                  width: 380,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      '[ Ilustrasi Gambar Kolase Feed/Story ]',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Sisi Kanan: Form Box "Masuk Facebook"
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Masuk Facebook',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1C1E21),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInputField('Email atau nomor ponsel'),
                    const SizedBox(height: 14),
                    _buildInputField('Kata Sandi', isPassword: true),
                    const SizedBox(height: 20),
                    _buildLoginButton(context),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Lupa kata sandi?',
                          style: TextStyle(
                            color: Color(0xFF1C1E21),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // PERBAIKAN DI SINI: Ditambahkan parameter 'context'
                    _buildCreateAccountButton(context),
                    const SizedBox(height: 40),
                    _buildMetaFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==================== 2. UI DESIGN - MOBILE TARGET (HP) ====================
  Widget _buildMobileLayout(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    // Logo Bulat Facebook Tengah Atas
                    Image.asset(
                      'assets/images/fb_logo.png',
                      width: 64,
                      height: 64,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 64);
                      },
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Mulai di Facebook',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1C1E21),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInputField('Email atau nomor ponsel'),
                    const SizedBox(height: 12),
                    _buildInputField('Kata Sandi', isPassword: true),
                    const SizedBox(height: 20),
                    _buildLoginButton(context),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Lupa kata sandi?',
                        style: TextStyle(
                          color: Color(0xFF1C1E21),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Elemen Bawah Pada Target HP: Tombol Pembuatan Akun Baru & Branding Meta
            // PERBAIKAN DI SINI: Ditambahkan parameter 'context'
            _buildCreateAccountButton(context),
            const SizedBox(height: 24),
            _buildMetaFooter(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ==================== WIDGET KOMPONEN REUSABLE ====================

  // Kolom Isian/Input dengan desain border melengkung halus dan latar belakang netral
  Widget _buildInputField(String hintText, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      cursorColor: const Color(0xFF1877F2),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
        filled: true,
        fillColor: const Color(0xFFF5F6F7),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1877F2), width: 1.5),
        ),
      ),
    );
  }

  // Tombol Biru Utama Untuk Eksekusi Proses Login
  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/home');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1877F2),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Tombol Transparan Bergaris Tepi Biru "Buat akun baru"
  Widget _buildCreateAccountButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/register'); 
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF1877F2), width: 1),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: const Text(
        'Buat akun baru',
        style: TextStyle(
          color: Color(0xFF1877F2),
          fontWeight: FontWeight.bold,
          fontSize: 15,
          ),
        ),
      );
    }

  // Footer Hak Cipta / Logo Meta bagian terbawah aplikasi
  Widget _buildMetaFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.all_inclusive, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          'Meta',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}