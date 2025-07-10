import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  // Data Dummy untuk Kategori
  final List<Map<String, String>> categories = [
    {
      'name': 'Makanan',
      'image':
          'https://images.icon-icons.com/1368/PNG/512/-meal_89750.png',
    },
    {
      'name': 'Minuman',
      'image':
          'https://cdn-icons-png.flaticon.com/512/3915/3915485.png',
    },
    {
      'name': 'Dessert',
      'image':
          'https://cdn-icons-png.flaticon.com/512/1205/1205153.png',
    },
    {
      'name': 'Snack',
      'image':
          'https://cdn-icons-png.flaticon.com/256/859/859415.png',
    },
    {
      'name': 'Kopi',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Coffee_cup_icon.svg/501px-Coffee_cup_icon.svg.png',
    },
  ];

  // Data Dummy untuk List Menu
  final List<Map<String, String>> menuItems = [
    {'name': 'Nasi Goreng Jokowi', 'price': 'Rp 20.000'},
    {'name': 'Mie Ayam Bakso Prabowo', 'price': 'Rp 18.000'},
    {'name': 'Sate Ayam Koh Ahok', 'price': 'Rp 30.000'},
    {'name': 'Gado-gado KDM', 'price': 'Rp 15.000'},
    {'name': 'Es Teh Pahit', 'price': 'Free'},
    {'name': 'Jus Alpukat', 'price': 'Rp 12.000'},
    {'name': 'Es Cendol', 'price': 'Rp 10.000'},
  ];

  // Palet Warna Lembut
  final Color softOrange = const Color(0xFFF8A44C);
  final Color softCream = const Color(0xFFFFF6E5);
  final Color darkText = const Color(0xFF4C3D3D);
  final Color priceColor = const Color(0xFFC08261);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softCream, // Latar belakang aplikasi
      appBar: AppBar(
        title: const Text(
          'Menu Subsidi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        backgroundColor: softOrange,
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Kategori Menu (Horizontal Scroll)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
          ),
          SizedBox(
            height: 125, // Memberi tinggi tetap untuk list horizontal
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryCard(context, categories[index]);
              },
            ),
          ),
          const Divider(
            height: 24,
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.black,
          ),

          // Bagian List Menu (Vertical Scroll)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              'Popular Menu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
          ),
          Expanded(
            child: _listMenuBuilder(),
          ),
        ],
      ),
    );
  }

  ListView _listMenuBuilder() {
    return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                color: Colors.white,
                shadowColor: softOrange.withAlpha(77),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: softOrange.withAlpha(38),
                    child: Icon(Icons.fastfood, color: softOrange),
                  ),
                  title: Text(
                    menuItems[index]['name']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: darkText,
                    ),
                  ),
                  subtitle: Text(
                    menuItems[index]['price']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: priceColor,
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: darkText,
                        content: Text(
                          'Anda memilih ${menuItems[index]['name']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }

  // Widget terpisah untuk membuat card kategori
  Widget _buildCategoryCard(
    BuildContext context,
    Map<String, String> category,
  ) {
    return Container(
      width: 110,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        // Menambah efek ripple saat disentuh
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: darkText,
              content: Text(
                'Kategori: ${category['name']}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Card(
          elevation: 2,
          color: Colors.white,
          shadowColor: softOrange.withAlpha(77),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Image.network(
                category['image']!,
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 80,
                  child: Icon(Icons.error, color: Colors.grey),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      category['name']!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: darkText,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}