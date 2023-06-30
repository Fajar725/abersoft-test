class BaseErrorResponse {
    final String? message;

    BaseErrorResponse({
        this.message,
    });

    factory BaseErrorResponse.fromJson(Map<String, dynamic> json) => BaseErrorResponse(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}