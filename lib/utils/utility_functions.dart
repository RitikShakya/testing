// functions which are to be universally used can be kept here




//something like this
class Utils{

  static int? calculateAge(String dobText) {
    if (dobText.isEmpty) return null;
    try {
      final dob = DateTime.parse(dobText); // expects yyyy-MM-dd
      final now = DateTime.now();
      int age = now.year - dob.year;
      if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
        age--; // subtract if birthday hasn’t occurred this year
      }
      return age;
    } catch (e) {
      return null; // invalid dob format
    }
  }

}