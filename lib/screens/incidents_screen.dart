// import 'package:flutter/material.dart';
// import '../services/firestore_service.dart';
//
// class IncidentsScreen extends StatefulWidget {
//   @override
//   _IncidentsScreenState createState() => _IncidentsScreenState();
// }
//
// class _IncidentsScreenState extends State<IncidentsScreen> {
//   final FirestoreService _firestoreService = FirestoreService();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descController = TextEditingController();
//
//   void _addIncident() {
//     String title = _titleController.text.trim();
//     String description = _descController.text.trim();
//     if (title.isNotEmpty && description.isNotEmpty) {
//       _firestoreService.addIncident(title, description, "test_user_id");
//       _titleController.clear();
//       _descController.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Incidents")),
//       body: Column(
//         children: [
//           TextField(controller: _titleController, decoration: InputDecoration(labelText: "Title")),
//           TextField(controller: _descController, decoration: InputDecoration(labelText: "Description")),
//           ElevatedButton(onPressed: _addIncident, child: Text("Report Incident")),
//           Expanded(
//             child: StreamBuilder(
//               stream: _firestoreService.getIncidents(),
//               builder: (context, AsyncSnapshot snapshot) {
//                 if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//                 var docs = snapshot.data.docs;
//                 return ListView.builder(
//                   itemCount: docs.length,
//                   itemBuilder: (context, index) {
//                     var incident = docs[index];
//                     return ListTile(
//                       title: Text(incident["title"]),
//                       subtitle: Text(incident["description"]),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => _firestoreService.deleteIncident(incident.id),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class IncidentsScreen extends StatefulWidget {
  @override
  _IncidentsScreenState createState() => _IncidentsScreenState();
}

class _IncidentsScreenState extends State<IncidentsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void _addIncident() {
    String title = _titleController.text.trim();
    String description = _descController.text.trim();
    if (title.isNotEmpty && description.isNotEmpty) {
      _firestoreService.addIncident(title, description, "test_user_id");
      _titleController.clear();
      _descController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Incidents")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: _titleController, decoration: const InputDecoration(labelText: "Title", border: OutlineInputBorder())),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: _descController, decoration: const InputDecoration(labelText: "Description", border: OutlineInputBorder())),
          ),
          ElevatedButton(onPressed: _addIncident, child: const Text("Report Incident")),
          Expanded(
            child: StreamBuilder(
              stream: _firestoreService.getIncidents(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData || snapshot.data == null) return const Center(child: CircularProgressIndicator());
                var docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var incident = docs[index];
                    return ListTile(
                      title: Text(incident["title"]),
                      subtitle: Text(incident["description"]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _firestoreService.deleteIncident(docs[index].id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

