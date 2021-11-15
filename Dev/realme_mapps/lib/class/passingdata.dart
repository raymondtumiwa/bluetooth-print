

class Sender {
  final String nama, hp, alamat, detailalamat, namapenerima, hppenerima, alamatpenerima, detailalamatpenerima;

  const Sender({
    this.nama,
    this.hp,
    this.alamat,
    this.detailalamat,
    this.namapenerima,
    this.hppenerima,
    this.alamatpenerima,
    this.detailalamatpenerima,
    
  });
}

class User{
 String penerima;
 String hape;

  User({
    this.penerima = '', this.hape = ''
  });
}

class Track {
  final String noresi;

  const Track ({
    this.noresi
  });
}



