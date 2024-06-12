import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:homework4/view/page_three.dart';

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  Future<List<Project>>? _projectsFuture;
  List<Project> _projects = [];
  List<Project> _filteredProjects = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _projectsFuture = fetchProjects();
    _searchController.addListener(_filterProjects);
  }

  Future<List<Project>> fetchProjects() async {
    Dio dio = Dio();
    final response = await dio.get('https://dummyjson.com/comments');
    List<Project> projects = (response.data['comments'] as List)
        .map((data) => Project.fromMap(data))
        .toList();
    setState(() {
      _projects = projects;
      _filteredProjects = projects;
    });
    return projects;
  }

  void _filterProjects() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProjects = _projects.where((project) {
        return project.body.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 46, 78),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 70),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Projects',
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color.fromARGB(255, 43, 206, 189),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Project>>(
                future: _projectsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No projects available'));
                  } else {
                    return ListView.builder(
                      itemCount: _filteredProjects.length,
                      itemBuilder: (context, index) {
                        final project = _filteredProjects[index];
                        return ProjectCard(
                          name: project.body,
                          date: 'N/A',
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelloPage()),
                );
              },
              child: Text('Go to New Page'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String name;
  final String date;

  ProjectCard({required this.name, required this.date});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Stack(
          children: [
            Positioned(
              left: -44,
              top: -38,
              child: Transform.rotate(
                angle: -0.7,
                origin: Offset(0, 0),
                child: Container(
                  width: 140,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color.fromARGB(255, 43, 206, 189),
                    border: Border.all(
                      color: Color.fromARGB(255, 2, 6, 41),
                      width: 2.0,
                    ),
                  ),
                  child: Transform.rotate(
                    angle: 0.7,
                    origin: Offset(0, 0),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 40),
                          SizedBox(
                            width: 45,
                            child: Text(
                              date,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                children: [
                  SizedBox(width: 100),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project name: $name',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 9,
                          color: Color.fromARGB(255, 6, 15, 94),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Created by: HadiSoradi',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color.fromARGB(255, 6, 15, 94),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Project {
  final String body;

  Project({required this.body});

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      body: map['body'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
    };
  }
}
