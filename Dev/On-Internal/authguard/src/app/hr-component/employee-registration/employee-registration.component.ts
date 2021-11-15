import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-employee-registration',
  templateUrl: './employee-registration.component.html',
  styleUrls: ['./employee-registration.component.scss']
})
export class EmployeeRegistrationComponent implements OnInit {

  isLinear = false;
  formUser: FormGroup = Object.create(null);
  secondFormGroup: FormGroup = Object.create(null);
  isOptional = false;
  isEditable = false;

  constructor(
    public form: FormBuilder) { }

  ngOnInit() {
    this.formUser = this.form.group({
      namaLengkap: ["", Validators.required],
      jenisKelamin: ["", Validators.required],
      tempatLahir: ["", Validators.required],
      tglLahir: ["", Validators.required],
      alamatKTP: ["", Validators.required],
      alamatDomisili: ["", Validators.required],
      nomorKTP: ["", Validators.required],
      nomorNPWP: ["", Validators.required],
      jenisSIM: ["", Validators.required],
      statusKawin: ["", Validators.required],
      jumlahAnak: ["", Validators.required],
      nomorWA: ["", Validators.required],
      nomorHP: ["", Validators.required],
      namaBank: ["", Validators.required],
      nomorRek: ["", Validators.required],
      namaRek: ["", Validators.required],
      jabatan: ["", Validators.required],
    });
  }

}
