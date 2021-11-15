// import { Component, OnInit } from '@angular/core';

// @Component({
//   selector: 'app-employee-list',
//   templateUrl: './employee-list.component.html',
//   styleUrls: ['./employee-list.component.scss']
// })
// export class EmployeeListComponent implements OnInit {

//   constructor() { }

//   ngOnInit(): void {
//   }

// }


import { Component, OnInit, Inject } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA, MatDialogModule } from '@angular/material/dialog';
import { EmployeeRegistrationComponent } from '../../employee-registration/employee-registration.component';



@Component({
  selector: 'app-employee-list',
  templateUrl: './employee-list.component.html',
  styleUrls: ['./employee-list.component.scss']
})
export class EmployeeListComponent  {
  constructor(public dialog: MatDialog) { }

    openDialog(): void {
        const dialogRef = this.dialog.open(EmployeeRegistrationComponent, {
            width: '1000px',
        });
    }

 

}


export class DialogComponent {
  
  constructor(
    public dialogRef: MatDialogRef<EmployeeListComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any
) { }

onNoClick(): void {
    this.dialogRef.close();
}
}