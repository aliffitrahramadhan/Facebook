import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // Abu-abu khas Facebook
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Jika lebar layar lebih besar dari 900 piksel, tampilkan versi Web/Desktop
          if (constraints.maxWidth > 900) {
            return _buildWebLayout(context);
          } else {
            // Jika layar kecil (HP), tampilkan versi Mobile
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  // ===========================================================================
  // 1. TAMPILAN MOBILE
  // ===========================================================================
  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'facebook',
          style: TextStyle(
            color: Color(0xFF1877F2),
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
        ),
        actions: [
          _buildActionCircle(Icons.add),
          const SizedBox(width: 8),
          _buildActionCircle(Icons.search),
          const SizedBox(width: 8),
          _buildActionCircle(Icons.chat_bubble),
          const SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabIcon(Icons.home, isActive: true),
                _buildTabIcon(Icons.people_outline),
                _buildTabIcon(Icons.ondemand_video),
                _buildTabIcon(Icons.storefront),
                _buildTabIcon(Icons.notifications_none),
                _buildTabIcon(Icons.menu),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _buildCreatePostBox('Alif Fitrah Ramadhan'),
          const SizedBox(height: 8),
          _buildStoriesSection(),
          const SizedBox(height: 8),
          _buildFeedPost(
            author: 'Oggo Oggo',
            time: 'Mei 11 pukul 20:49',
            content: '2 tahun kemudian 🗓️⏳🦧',
            hasImage: true,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. TAMPILAN WEBSITE / DESKTOP (BAGIAN SPONSORED BERBENTUK TEKS & UNDO DI KANAN)
  // ===========================================================================
  Widget _buildWebLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 42),
            const SizedBox(width: 8),
            // Kolom Pencarian Web
            Container(
              width: 240,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.grey, size: 20),
                  SizedBox(width: 8),
                  Text('Cari di Facebook', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        titleSpacing: 0,
        actions: [
          _buildActionCircle(Icons.apps),
          const SizedBox(width: 8),
          _buildActionCircle(Icons.messenger),
          const SizedBox(width: 8),
          _buildActionCircle(Icons.notifications),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue.shade800,
            child: const Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          // KOLOM KIRI: SIDEBAR MENU
          Expanded(
            flex: 2,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              children: [
                _buildWebSidebarRow(Icons.account_circle, 'Alif Fitrah Ramadhan', isAvatar: true),
                _buildWebSidebarRow(Icons.auto_awesome, 'Meta AI', iconColor: Colors.deepPurple),
                _buildWebSidebarRow(Icons.people, 'Friends', iconColor: Colors.blue),
                _buildWebSidebarRow(Icons.storefront, 'Marketplace', iconColor: Colors.blue),
                _buildWebSidebarRow(Icons.history, 'Memories', iconColor: Colors.blue, isActive: true),
                _buildWebSidebarRow(Icons.bookmark, 'Saved', iconColor: Colors.purple),
                _buildWebSidebarRow(Icons.groups, 'Groups', iconColor: Colors.blue),
                _buildWebSidebarRow(Icons.slideshow, 'Reels', iconColor: Colors.pink),
                _buildWebSidebarRow(Icons.dynamic_feed, 'Feeds', iconColor: Colors.blue.shade700),
                _buildWebSidebarRow(Icons.keyboard_arrow_down, 'See more', isButton: true),
                
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Divider(thickness: 1, color: Color(0xFFE4E6EB)),
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    'Your shortcuts',
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                
                _buildWebSidebarRow(Icons.blur_on, 'JUAL BELI ALAT RACING MIO ', isShortcut: true),
                
              ],
            ),
          ),
          
          // KOLOM TENGAH: KONTEN UTAMA
          Expanded(
            flex: 4,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              children: [
                _buildCreatePostBox('Alif Fitrah Ramadhan'),
                const SizedBox(height: 16),
                _buildStoriesSection(),
                const SizedBox(height: 16),
                _buildFeedPost(
                  author: 'Oggo Oggo',
                  time: 'Mei 11 pukul 20:49',
                  content: '2 tahun kemudian 🗓️⏳🦧',
                  hasImage: true,
                ),
              ],
            ),
          ),
          
          // -------------------------------------------------------------------
          // KOLOM KANAN: SPONSOR (HANYA KATA & UNDO DI KANAN WARNA BIRU) & BIRTHDAYS
          // -------------------------------------------------------------------
          Expanded(
            flex: 2,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12, top: 4),
                  child: Text(
                    'Sponsored',
                    style: TextStyle(
                      color: Colors.grey, 
                      fontWeight: FontWeight.bold, 
                      fontSize: 16,
                    ),
                  ),
                ),
                
                // Baris Sponsor Teks dengan Tombol Undo di Sebelah Kanan Berwarna Biru
                _buildTextSponsoredRow(
                  text: 'add hidden.',
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(thickness: 1, color: Color(0xFFE4E6EB)),
                ),
                _buildTextSponsoredRow(
                  text: 'add hidden.', 
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(thickness: 1, color: Color(0xFFE4E6EB)),
                ),
                
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Birthdays',
                    style: TextStyle(
                      color: Colors.grey, 
                      fontWeight: FontWeight.bold, 
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.card_giftcard, color: Colors.blue, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Muhammad Arsy\'s birthday is today.',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // WIDGET & KOMPONEN PEMBANTU (REUSABLE)
  // ===========================================================================
  
  Widget _buildActionCircle(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFFE4E6EB),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black, size: 22),
    );
  }

  Widget _buildTabIcon(IconData icon, {bool isActive = false}) {
    return Expanded(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? const Color(0xFF1877F2) : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Icon(
          icon,
          color: isActive ? const Color(0xFF1877F2) : Colors.grey.shade600,
          size: 26,
        ),
      ),
    );
  }

  Widget _buildWebSidebarRow(
    IconData icon, 
    String title, {
    bool isAvatar = false, 
    bool isButton = false, 
    bool isShortcut = false,
    bool isActive = false,
    Color iconColor = Colors.black87,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFE4E6EB) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              if (isAvatar)
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.blue.shade800,
                  child: const Text('A', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                )
              else if (isButton)
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFFE4E6EB),
                  child: Icon(icon, size: 20, color: Colors.black),
                )
              else if (isShortcut)
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: Colors.blue.shade900),
                )
              else
                Icon(icon, size: 28, color: iconColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title, 
                  style: TextStyle(
                    fontSize: 15, 
                    fontWeight: isAvatar || isActive ? FontWeight.bold : FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET SIDEBAR SPONSOR TEKS DAN TOMBOL UNDO WARNA BIRU DI KANAN
  Widget _buildTextSponsoredRow({required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Teks Penjelasan (Kiri)
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Bagian Tombol Undo Berwarna Biru (Kanan)
          GestureDetector(
            onTap: () {
              // Aksi saat Undo diklik
            },
            child: const Text(
              'Undo',
              style: TextStyle(
                color: Color(0xFF1877F2), // Biru khas Facebook
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreatePostBox(String name) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1))
        ]
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade800,
                child: const Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'What\'s on your mind, $name?',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(children: const [Icon(Icons.video_call, color: Colors.red), SizedBox(width: 4), Text('Live video')]),
              Row(children: const [Icon(Icons.photo_library, color: Colors.green), SizedBox(width: 4), Text('Photo/video')]),
              Row(children: const [Icon(Icons.insert_emoticon, color: Colors.orange), SizedBox(width: 4), Text('Feeling/activity')]),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStoriesSection() {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildOwnStoryCard(),
          _buildFriendStoryCard(name: 'Andi Mame', initial: 'A', color: Colors.deepOrange),
          _buildFriendStoryCard(name: 'Grce Viola Inggrd', initial: 'G', color: Colors.pink),
          _buildFriendStoryCard(name: 'Serambi Muslim', initial: 'S', color: Colors.purple),
        ],
      ),
    );
  }

  Widget _buildOwnStoryCard() {
    return Container(
      width: 105,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
              ),
              child: const Center(child: Icon(Icons.person, size: 40, color: Colors.grey)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Center(
                  child: Text('Create story', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                ),
                Positioned(
                  top: -14,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFF1877F2),
                        child: Icon(Icons.add, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFriendStoryCard({required String name, required String initial, required Color color}) {
    return Container(
      width: 105,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Center(
            child: Text(initial, style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFeedPost({required String author, required String time, required String content, required bool hasImage}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundColor: Colors.grey.shade400, child: Text(author[0])),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(author, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('$time · 👥', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                      ],
                    )
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.more_horiz),
                    SizedBox(width: 12),
                    Icon(Icons.close),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(content, style: const TextStyle(fontSize: 15)),
          ),
          if (hasImage)
            Container(
              height: 300,
              color: Colors.blue.shade50,
              child: const Center(child: Icon(Icons.image, size: 48, color: Colors.blue)),
            ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(onPressed: () {}, icon: const Icon(Icons.thumb_up_outlined), label: const Text('Like')),
              TextButton.icon(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline), label: const Text('Comment')),
              TextButton.icon(onPressed: () {}, icon: const Icon(Icons.share_outlined), label: const Text('Share')),
            ],
          )
        ],
      ),
    );
  }
}