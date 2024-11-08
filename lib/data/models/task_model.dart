class TaskModel {
  // These are the properties of the TaskModel class
  // "String?" means that these properties can either have a String value or be null (optional fields).
  String? sId; // The unique identifier for the task (could be null).
  String? title; // The title or name of the task.
  String? description; // A description that provides details about the task.
  String? status; // The status of the task (e.g., 'pending', 'completed').
  String? email; // The email of the person associated with the task.
  String? createdDate; // The date when the task was created.

  // Constructor to initialize the TaskModel object.
  // All fields are optional due to the use of "this.field" with nullable types (String?).
  TaskModel(
      {this.sId,
        this.title,
        this.description,
        this.status,
        this.email,
        this.createdDate});

  // Named constructor to create a TaskModel object from a JSON object.
  // This is helpful when we want to convert JSON data (usually from an API) into a TaskModel object.
  TaskModel.fromJson(Map<String, dynamic> json) {
    // Here, we extract the data from the JSON object and assign it to our class fields.
    sId = json['_id']; // The '_id' key from JSON is assigned to the sId field.
    title = json['title']; // The 'title' key from JSON is assigned to the title field.
    description = json['description']; // Same process for other fields.
    status = json['status'];
    email = json['email'];
    createdDate = json['createdDate'];
  }

  // Method to convert a TaskModel object into a JSON object (Map<String, dynamic>).
  // This is useful when we need to send the TaskModel data back to an API in JSON format.
  Map<String, dynamic> toJson() {
    // We create an empty Map to hold our data in key-value pairs.
    final Map<String, dynamic> data = <String, dynamic>{};

    // We add our class fields to the Map using the correct JSON keys.
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['email'] = email;
    data['createdDate'] = createdDate;

    // Finally, we return the Map (which is now in JSON format).
    return data;
  }
}
