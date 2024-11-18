String errorReturn(int num) {
  switch (num) {
    case 1:
      return 'Invalid Credentials';
    case 2:
      return 'Fill all fields';
    case 3:
      return 'An error occurred';
    default:
      return 'Unknown error';
  }
}

String successReturn(int num) {
  switch (num) {
    case 1:
      return 'Logged in successfully';
    case 2:
      return 'Category added successfully';
    case 3:
      return 'Product added successfully';
    default:
      return 'Product deleted successfully';
  }
}
