import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { CalendarEvent } from 'angular-calendar';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { EgretCalendarEvent } from '../event.model';


interface DialogData {
  event?: CalendarEvent;
  action?: string;
  date?: Date;
}

@Component({
  selector: 'app-calendar-form-dialog',
  templateUrl: './calendar-form-dialog.component.html',
  styleUrls: ['./calendar-form-dialog.component.scss']
})
export class CalendarFormDialogComponent implements OnInit {
  event: any;
  dialogTitle: string;
  eventForm: FormGroup;
  action: any;
  constructor(
    public dialogRef: MatDialogRef<CalendarFormDialogComponent>,
    @Inject(MAT_DIALOG_DATA) private data: DialogData,
    private formBuilder: FormBuilder
  ) {
    this.event = data.event;
    this.action = data.action;
    if (this.action === 'edit') {
      this.dialogTitle = this.event.title;
    } else {
      this.dialogTitle = 'Add Event';
      this.event = new EgretCalendarEvent({
        start: data.date,
        end: data.date
      });
    }
    // console.log(data);
    this.eventForm = this.buildEventForm(this.event);
  }

  ngOnInit(): void {
  }

  buildEventForm(event: any): any {
    return new FormGroup({
      _id: new FormControl(event._id),
      title: new FormControl(event.title),
      start: new FormControl(event.start),
      end: new FormControl(event.end),
      allDay: new FormControl(event.allDay),
      color: this.formBuilder.group({
        primary: new FormControl(event.color.primary),
        secondary: new FormControl(event.color.secondary)
      }),
      meta: this.formBuilder.group({
        location: new FormControl(event.meta.location),
        notes: new FormControl(event.meta.notes)
      }),
      draggable: new FormControl(true),

    });
  }

}
