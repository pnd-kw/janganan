final validCharacters = RegExp(r"^[a-zA-Z0-9]+$");
final validEmail = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
final validPhone = RegExp(r'^\+?62\d{9,15}$');
final validPassword = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

const msgEmptyField = 'Bidang ini tidak boleh kosong!';
const msgMinInput = 'Minimal 3 karakter!';
const msgInvalidCharacters = 'Tanpa spasi dan karakter khusus!';
const msgInvalidEmail = 'Format email tidak sesuai!';
const msgInvalidPhone = 'Format telepon tidak sesuai!';
const msgInvalidPassword = '8 karakter dan berikan angka!';
