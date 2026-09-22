import 'package:flutter/material.dart';

class ShippingAddressWidget extends StatefulWidget {
  const ShippingAddressWidget({super.key});

  @override
  State<ShippingAddressWidget> createState() =>
      _ShippingAddressWidgetState();
}

class _ShippingAddressWidgetState extends State<ShippingAddressWidget> {
  String selectedName = 'Wilbert';
  String selectedAddress = 'Jl. Contoh No. 123, Jakarta Barat';

  void changeAddress() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pilih Alamat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Rumah'),
                subtitle: const Text(
                  'Jl. Contoh No. 123, Jakarta Barat',
                ),
                onTap: () {
                  setState(() {
                    selectedName = 'Wilbert';
                    selectedAddress =
                        'Jl. Contoh No. 123, Jakarta Barat';
                  });

                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Text('Kos'),
                subtitle: const Text(
                  'Jl. Mawar No. 10, Jakarta Barat',
                ),
                onTap: () {
                  setState(() {
                    selectedName = 'Wilbert';
                    selectedAddress =
                        'Jl. Mawar No. 10, Jakarta Barat';
                  });

                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Text('Kantor'),
                subtitle: const Text(
                  'Jl. Sudirman No. 20, Jakarta Pusat',
                ),
                onTap: () {
                  setState(() {
                    selectedName = 'Wilbert';
                    selectedAddress =
                        'Jl. Sudirman No. 20, Jakarta Pusat';
                  });

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alamat Pengiriman',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            selectedName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            selectedAddress,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 10),

          TextButton(
            onPressed: changeAddress,
            child: const Text(
              'Ubah Alamat',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}