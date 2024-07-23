import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/models/publicacion_model.dart';
import '../../core/models/bovino_model.dart';
import '../controllers/edit_publicacion_controller.dart';

class EditPublicacionPage extends StatelessWidget {
  final Publicacion publicacion;
  final Bovino bovino;

  EditPublicacionPage({required this.publicacion, required this.bovino});

  final EditPublicacionController controller = Get.put(EditPublicacionController());

  @override
  Widget build(BuildContext context) {
    controller.setInitialValues(publicacion);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Editar Publicación'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: controller.descriptionController,
                          decoration: InputDecoration(labelText: 'Descripción'),
                        ),
                        TextField(
                          controller: controller.precioController,
                          decoration: InputDecoration(labelText: 'Precio'),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          controller.updatePublicacion(publicacion.idCattle);
                          Get.back();
                        },
                        child: Text('Guardar'),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    bovino.imageUrl ?? '',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    Text(
                      bovino.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      bovino.breed,
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                    Text(
                      '${bovino.weight}kg',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Descripción',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              Text(publicacion.description),
              SizedBox(height: 16.0),
              Text(
                'Salud',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              LinearProgressIndicator(
                value: 0.8,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
                minHeight: 10,
              ),
              SizedBox(height: 16.0),
              Text(
                'Ubicación',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              Container(
                height: 200,
                child: Obx(() => GoogleMap(
                  onMapCreated: (GoogleMapController mapController) {
                    controller.setMapController(mapController);
                  },
                  initialCameraPosition: CameraPosition(
                    target: controller.selectedLocation.value,
                    zoom: 15,
                  ),
                  markers: controller.markers.value,
                )),
              ),
              SizedBox(height: 16.0),
              Text(
                'Fecha de Publicación',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              Text('${publicacion.fecha.substring(0, 10)}'), // Formato AAAA/MM/DD
              SizedBox(height: 16.0),
              Text(
                'Vendedor',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(publicacion.vendedorImageUrl.isNotEmpty ? publicacion.vendedorImageUrl : 'https://your-default-image-url.com/default_profile.jpg'),
                ),
                title: Text(publicacion.vendedorNombre),
                subtitle: Text(publicacion.vendedorEmail),
                trailing: IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    // Implementar llamada telefónica
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
