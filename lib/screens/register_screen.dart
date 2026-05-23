import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Variabel pilihan dropdown tanggal lahir
  String? selectedDay = '1';
  String? selectedMonth = 'Jan';
  String? selectedYear = '2000';
  
  // Variabel pilihan jenis kelamin
  String? selectedGender;

  // Data sumber untuk Dropdown Tanggal Lahir
  final List<String> days = List.generate(31, (index) => (index + 1).toString());
  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
  final List<String> years = List.generate(100, (index) => (2026 - index).toString());

  // Data sumber untuk Dropdown Jenis Kelamin
  final List<String> genders = ['Perempuan', 'Laki-laki', 'Khusus'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // Latar belakang abu-abu khas Meta Facebook
      body: LayoutBuilder(
        builder: (context, constraints) {
          // ==================== RESPONSIF: TARGET WEB / DESKTOP ====================
          if (constraints.maxWidth > 900) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SISI KIRI: Logo & Kalimat Sambutan ala Facebook Desktop
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'facebook',
                              style: TextStyle(
                                color: Color(0xFF1877F2),
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(right: 40), // PERBAIKAN: Syntax error diperbaiki di sini
                              child: const Text(
                                'rhubung dan berbagi dengan orang-orang dalam kehidupan Anda.',
                                style: TextStyle(
                                  color: Color(0xFF1C1E21),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SISI KANAN: Kotak Formulir Pendaftaran (Form Box)
                      Container(
                        width: 450,
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: _buildFormContent(context, isWeb: true),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } 
          // ==================== RESPONSIF: TARGET MOBILE / HP ====================
          else {
            return Container(
              color: Colors.white, // Mobile berlatar belakang putih bersih
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Teks Atas Tampilan Mobile
                      const Text(
                        'Mulai di Facebook',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C1E21),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Mudah dan cepat untuk membuat akun baru.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 20), // PERBAIKAN: Divider (garis panjang) dihapus diganti dengan SizedBox
                      _buildFormContent(context, isWeb: false),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // ==================== KONTEN FORMULIR DENGAN URUTAN BENAR ====================
  Widget _buildFormContent(BuildContext context, {required bool isWeb}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isWeb) ...[
          // Header di dalam Box jika dibuka di Web
          const Text(
            'Buat Akun Baru',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1C1E21)),
          ),
          Text(
            'Buat akun untuk terhubung dengan teman, keluarga, dan orang-orang yang memiliki minat yang sama dengan anda.',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16), // PERBAIKAN: Divider (garis panjang) tampilan web dihapus
        ],

        // 1. INPUT NAMA (Dengan Label Judul di atasnya)
        _buildSectionTitle('Nama'), // PERBAIKAN: Penambahan label Nama
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildInputField('Nama depan')),
            const SizedBox(width: 12),
            Expanded(child: _buildInputField('Nama belakang')),
          ],
        ),
        const SizedBox(height: 16),
        
        // 2. INPUT TANGGAL LAHIR (Dropdown Tiga Kolom)
        _buildSectionTitle('Tanggal lahir'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildDropdownField(days, selectedDay, 'Hari', (v) => setState(() => selectedDay = v))),
            const SizedBox(width: 10),
            Expanded(child: _buildDropdownField(months, selectedMonth, 'Bulan', (v) => setState(() => selectedMonth = v))),
            const SizedBox(width: 10),
            Expanded(child: _buildDropdownField(years, selectedYear, 'Tahun', (v) => setState(() => selectedYear = v))),
          ],
        ),
        const SizedBox(height: 16),
        
        // 3. INPUT JENIS KELAMIN (Dropdown Tunggal)
        _buildSectionTitle('Jenis Kelamin'),
        const SizedBox(height: 8),
        _buildDropdownField(
          genders, 
          selectedGender, 
          'Pilih Jenis Kelamin', // PERBAIKAN: Menggunakan Dropdown pengganti Radio button lama
          (v) => setState(() => selectedGender = v),
        ),
        const SizedBox(height: 16),
        
        // 4. INPUT NOMOR PONSEL ATAU EMAIL
        _buildInputField('Nomor seluler atau email'),
        const SizedBox(height: 16),
        
        // 5. INPUT KATA SANDI
        _buildInputField('Kata sandi baru', isPassword: true),
        const SizedBox(height: 20),
        
        // Kalimat Hukum / Kebijakan Facebook
        Text(
          'Orang yang menggunakan layanan kami mungkin telah mengunggah informasi kontak Anda ke Facebook. Pelajari selengkapnya.',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 8),
        Text(
          'Dengan mengklik Kirim, Anda menyetujui Ketentuan, Kebijakan Privasi, dan Kebijakan Cookie kami.', // PERBAIKAN: Kata "Daftar" disesuaikan menjadi "Kirim"
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 24),
        
        // Tombol Utama "Kirim" Biru
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1877F2), // PERBAIKAN: Warna Biru Facebook
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text(
            'Kirim', // PERBAIKAN: Teks diubah menjadi Kirim
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ),
        const SizedBox(height: 16),
        
        // Tombol Balik ke Login
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          child: const Text(
            'Sudah punya akun?',
            style: TextStyle(
              color: Color(0xFF1877F2),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 14),
        _buildMetaFooter(),
      ],
    );
  }

  // ==================== COMPONENT WIDGETS ====================
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade700,
      ),
    );
  }

  Widget _buildInputField(String hintText, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      cursorColor: const Color(0xFF1877F2),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF5F6F7),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFF1877F2), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildDropdownField(List<String> items, String? currentValue, String hint, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          hint: Text(hint, style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildMetaFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.all_inclusive, size: 14, color: Colors.grey.shade500),
        const SizedBox(width: 4),
        Text(
          'Meta',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}