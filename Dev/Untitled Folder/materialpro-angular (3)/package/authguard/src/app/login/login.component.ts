import { Component, OnInit } from '@angular/core';
import { RouterModule, Router } from '@angular/router';
import { MyserviceService } from './../myservice.service';

import {
  FormBuilder,
  FormGroup,
  Validators,
  FormControl
} from '@angular/forms';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
  providers: [MyserviceService]
})
export class LoginComponent implements OnInit {
  msg = '';
  constructor(private service: MyserviceService, private routes: Router) { }

  check(uname: string, p: string) {
    const output = this.service.checkusernameandpassword(uname, p);
    if (output == true) {
      this.routes.navigate(['/starter']);
    } else {  
      this.msg = 'Invalid Username or Password';
    }
  }

  ngOnInit() {}
}
