import { Component, OnInit, Inject } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { DatePipe } from '@angular/common';
import { Employee } from '../dashboard-emp.component';

@Component({
    selector: 'app-emp-dialog',
    templateUrl: './emp-dialog.component.html',
    styleUrls: ['./emp-dialog.component.scss']
})
export class EmpDialogComponent {
    action: string;
    // tslint:disable-next-line - Disables all
    local_data: any;
    selectedImage: any = '';
    joiningDate: any = '';

    constructor(public datePipe: DatePipe, public dialogRef: MatDialogRef<any>, @Inject(MAT_DIALOG_DATA) public data: Employee) {
        this.local_data = { ...data };
        this.action = this.local_data.action;

        if (this.local_data.DateOfJoining !== undefined) {
            this.joiningDate = this.datePipe.transform(new Date(this.local_data.DateOfJoining), 'yyyy-MM-dd');
        }

        if (this.local_data.imagePath === undefined) {
            this.local_data.imagePath = 'assets/images/users/default.png';
        }
    }

    doAction(): void {
        this.dialogRef.close({ event: this.action, data: this.local_data });
    }

    closeDialog(): void {
        this.dialogRef.close({ event: 'Cancel' });
    }

    selectFile(event: any): void {
        if (!event.target.files[0] || event.target.files[0].length === 0) {
            return;
        }
        const mimeType = event.target.files[0].type;
        if (mimeType.match(/image\/*/) === null) {
            return;
        }
        const reader = new FileReader();
        reader.readAsDataURL(event.target.files[0]);
        // tslint:disable-next-line - Disables all
        reader.onload = (_event) => {
            this.local_data.imagePath = reader.result;
        };
    }

}
