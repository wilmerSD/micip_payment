import 'package:cip_payment_web/domain/datasources/invoice_datasource.dart';
import 'package:cip_payment_web/domain/entities/company.dart';
import 'package:cip_payment_web/infrastructure/mappers/company_mapper.dart';
import 'package:cip_payment_web/infrastructure/models/company_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InvoicedbDatasource extends InvoiceDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  @override
  @override
  Future<Company?> createRuc(CompanyModel newCompany) async {
    try {
      // 1. Generamos una referencia con id automático
      final docRef = firestoredb.collection('Company').doc();

      // 2. Guardamos la data + el id generado
      await docRef.set({
        ...newCompany.toJson(),
        "id": docRef.id, // Guardamos el id como campo
        "createdAt": FieldValue.serverTimestamp(),
      });

      // 3. Obtenemos el documento recién guardado
      final snapshot = await docRef.get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        // 4. Mapear a Response
        final companyResponse = CompanyModel.fromJson(data);

        // 5. Mapear a Entidad
        final createdCompany =
            CompanyMapper.companyResponseToEntity(companyResponse);

        return createdCompany;
      }
      return null;
    } catch (e) {
      print("❌ Error al crear RUC: $e");
      return null;
    }
  }

  @override
  Future<List<Company>> getRucs(String personId) async {
    try {
      final snapshot = await firestoredb
          .collection('Company')
          .where('personId', isEqualTo: personId)
          .where('status', isEqualTo: true)
          .get();

      final companiesResponse = snapshot.docs.map((doc) {
        final data = doc.data();
        return CompanyModel.fromJson(data);
      }).toList();
      // Mapear lista de Response a lista de Entity
      final companies = companiesResponse
          .map((resp) => CompanyMapper.companyResponseToEntity(resp))
          .toList();

      return companies;
    } catch (e) {
      // print('❌ Error al obtener cursos: $e');
      return [];
    }
  }

  @override
  Future<Company?> updateRuc(CompanyModel companyUpdate) async {
    try {
      // 1. Actualizar documento en Firestore
      await firestoredb.collection('Company').doc(companyUpdate.id).update({
        ...companyUpdate.toJson(), // asumiendo que tienes un método toJson()
        // "status": "completed", // forzamos cambio de estado
        "updatedAt":
            FieldValue.serverTimestamp(), // opcional, timestamp del servidor
      });

      // 2. Obtener documento actualizado
      final snapshot =
          await firestoredb.collection('Company').doc(companyUpdate.id).get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final companyResponse = CompanyModel.fromJson(data);
        final company = CompanyMapper.companyResponseToEntity(companyResponse);
        return company;
      } else {
        return null; // Documento no existe
      }
    } catch (e) {
      print("Error al actualizar RUC: $e");
      return null;
    }
  }

  @override
  Future<Company?> deleteRuc(String companyId) async {
    try {
      // 1. Actualizar documento en Firestore (soft delete)
      await firestoredb.collection('Company').doc(companyId).update({
        "status": false, // marcamos como eliminado
        "updatedAt": FieldValue.serverTimestamp(),
      });

      // 2. Obtener documento actualizado
      final snapshot =
          await firestoredb.collection('Company').doc(companyId).get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final companyResponse = CompanyModel.fromJson(data);
        final company = CompanyMapper.companyResponseToEntity(companyResponse);
        return company;
      } else {
        return null; // Documento no existe
      }
    } catch (e) {
      print("❌ Error al eliminar RUC: $e");
      return null;
    }
  }
}
