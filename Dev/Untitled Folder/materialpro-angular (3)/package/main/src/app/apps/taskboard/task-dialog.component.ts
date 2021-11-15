import { Component, OnInit, Inject, Optional } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-task-dialog',
  templateUrl: './task-dialog.component.html',
  styleUrls: ['./task-dialog.component.scss']
})
export class TaskDialogComponent implements OnInit {


  action: string;
  local_data: any;

  constructor(public dialogRef: MatDialogRef<TaskDialogComponent>,
    @Optional() @Inject(MAT_DIALOG_DATA) public data: any) {

    this.local_data = { ...data };
    this.action = this.local_data.action;

  }

  ngOnInit(): void {
  }

  doAction(): void {
    this.dialogRef.close({ event: this.action, data: this.local_data });
  }

  closeDialog(): void {
    this.dialogRef.close({ event: 'Cancel' });
  }

}
