import { Component } from '@angular/core';

@Component({
  selector: 'app-employee-management',
  templateUrl: './employee-management.component.html',
  styleUrls: ['./employee-management.component.scss']
})

export class EmployeeManagementComponent {
  constructor() { }
  activationCode!: number;
  ngOnInit() {
    this.activationCode = 0;
  }
  changeTab(selectedTab: { index: number; }){
    this.activationCode = selectedTab.index;
  }

}



// import { Component, OnInit, Inject } from '@angular/core';
// import { MatDialog, MatDialogRef, MAT_DIALOG_DATA, MatDialogModule } from '@angular/material/dialog';
// import { EmployeeRegistrationComponent } from '../employee-registration/employee-registration.component';

// @Component({
//   selector: 'app-employee-management',
//   templateUrl: './employee-management.component.html',
//   styleUrls: ['./employee-management.component.scss']
// })
// export class EmployeeManagementComponent  {
//   constructor(public dialog: MatDialog) { }

//     openDialog(): void {
//         const dialogRef = this.dialog.open(EmployeeRegistrationComponent, {
//             width: '1000px',
//         });
//     }

 

// }


// export class DialogComponent {
  
//   constructor(
//     public dialogRef: MatDialogRef<EmployeeManagementComponent>,
//     @Inject(MAT_DIALOG_DATA) public data: any
// ) { }

// onNoClick(): void {
//     this.dialogRef.close();
// }
// }