class DynamicForm {
  final List<DynamicFormSection> sections;
  final String name;
  final String title;
  final String description;
  final String positiveButtonText;

  DynamicForm({
    required this.sections,
    required this.name,
    required this.title,
    required this.description,
    required this.positiveButtonText,
  });

  factory DynamicForm.fromJson(Map<String, dynamic> json) => DynamicForm(
        sections: List<DynamicFormSection>.from(
          json["sections"].map((x) => DynamicFormSection.fromJson(x)),
        ),
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        positiveButtonText: json["positiveButtonText"] ?? '',
        name: json["name"] ?? '',
      );
}

class DynamicFormSection {
  final String title;
  final List<DynamicFormField> fields;

  DynamicFormSection({
    required this.title,
    required this.fields,
  });

  factory DynamicFormSection.fromJson(Map<String, dynamic> json) => DynamicFormSection(
        title: json["title"] ?? '',
        fields: List<DynamicFormField>.from(
          json["fields"].map((x) => DynamicFormField.fromJson(x)),
        ),
      );
}

class DynamicFormField {
  final String name;
  final String type;
  final String title;
  final String? description;
  final bool required;
  final bool readOnly;
  dynamic value;
  final List<String> extensions;
  final List<String> data;
  final List<DynamicFormValidation>? validations;
  final int minChoice;
  final int maxChoice;
  final int minFile;
  final int maxFile;

  DynamicFormField({
    required this.name,
    required this.readOnly,
    required this.type,
    required this.title,
    required this.description,
    required this.data,
    required this.value,
    required this.validations,
    required this.required,
    required this.extensions,
    required this.minChoice,
    required this.maxChoice,
    required this.minFile,
    required this.maxFile,
  });

  factory DynamicFormField.fromJson(Map<String, dynamic> json) {
    String type = json["type"];

    List<DynamicFormValidation> validations = [];

    if (json["validations"] != null) {
      validations = List<DynamicFormValidation>.from(
        json["validations"].map((x) => DynamicFormValidation.fromJson(x)),
      );
    }

    List<String> extensions = [];

    if (json["extensions"] != null) {
      json['extensions'].forEach((e) {
        extensions.add(e);
      });
    }

    List<String> data = [];

    if (json["data"] != null) {
      json['data'].forEach((e) {
        data.add(e);
      });
    }

    return DynamicFormField(
      name: json["name"],
      type: type,
      title: json["title"],
      description: json["description"],
      required: json["required"] ?? false,
      readOnly: json["readOnly"],
      validations: validations,
      value: json["value"],
      extensions: extensions,
      data: data,
      minChoice: json["minChoice"] ?? 0,
      maxChoice: json["maxChoice"] ?? 0,
      maxFile: json["maxFile"] ?? 0,
      minFile: json["minFile"] ?? 0,
    );
  }
}

class DynamicFormValidation {
  final String type;
  final dynamic value;
  final String? errorMessage;

  DynamicFormValidation({
    required this.type,
    required this.value,
    this.errorMessage,
  });

  factory DynamicFormValidation.fromJson(Map<String, dynamic> json) => DynamicFormValidation(
        type: json["type"],
        value: json["value"],
        errorMessage: json["errorMessage"],
      );
}

enum DynamicFormFieldType { SHORT_TEXT, LONG_TEXT, EMAIL, URL, NUMBER, PHONE_NUMBER, DATE, TIME, DATE_TIME, RADIO, CHECK, DROPDOWN, FILE }

enum DynamicFormValidationType { CONTAINS, NOT_CONTAINS, MIN_LENGTH, MAX_LENGTH, GREATER_THAN, GREATER_THAN_OR_EQUAL_TO, LESS_THAN, LESS_THAN_OR_EQUAL_TO, BEFORE, AFTER }
