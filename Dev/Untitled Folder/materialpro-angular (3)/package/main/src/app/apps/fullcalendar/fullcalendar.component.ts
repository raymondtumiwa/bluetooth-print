import {
    Component,
    ChangeDetectionStrategy,
    Inject
} from '@angular/core';
import { DOCUMENT } from '@angular/common';
import {
    MatDialog,
    MatDialogRef,
    MatDialogConfig,
    MAT_DIALOG_DATA
} from '@angular/material/dialog';
import { FormBuilder, FormGroup } from '@angular/forms';
import { FormControl, Validators } from '@angular/forms';
import { CalendarFormDialogComponent } from './calendar-form-dialog/calendar-form-dialog.component';
import {
    startOfDay,
    endOfDay,
    subDays,
    addDays,
    endOfMonth,
    isSameDay,
    isSameMonth,
    addHours
} from 'date-fns';
import { Subject } from 'rxjs/Subject';
import {
    CalendarEvent,
    CalendarEventAction,
    CalendarEventTimesChangedEvent,
    CalendarView
} from 'angular-calendar';
import { NullTemplateVisitor } from '@angular/compiler';



const colors: any = {
    red: {
        primary: '#fc4b6c',
        secondary: '#f9e7eb'
    },
    blue: {
        primary: '#1e88e5',
        secondary: '#D1E8FF'
    },
    yellow: {
        primary: '#ffb22b',
        secondary: '#FDF1BA'
    }
};

@Component({
    selector: 'app-calendar-dialog',
    templateUrl: './dialog.component.html',
})
export class CalendarDialogComponent {
    options!: FormGroup;

    constructor(
        public dialogRef: MatDialogRef<CalendarDialogComponent>,
        @Inject(MAT_DIALOG_DATA) public data: any
    ) { }
}




@Component({
    selector: 'app-fullcalendar',
    changeDetection: ChangeDetectionStrategy.OnPush,
    templateUrl: './fullcalendar.component.html',
    styleUrls: ['./fullcalendar.component.scss']
})
export class FullcalendarComponent {
    dialogRef: MatDialogRef<CalendarDialogComponent> = Object.create(NullTemplateVisitor);
    dialogRef2: MatDialogRef<CalendarFormDialogComponent> = Object.create(NullTemplateVisitor);

    lastCloseResult = '';
    actionsAlignment = '';

    config: MatDialogConfig = {
        disableClose: false,
        width: '',
        height: '',
        position: {
            top: '',
            bottom: '',
            left: '',
            right: ''
        },
        data: {
            action: '',
            event: []
        }
    };
    numTemplateOpens = 0;

    view = 'month';
    viewDate: Date = new Date();



    actions: CalendarEventAction[] = [
        {
            label: '<i class="ti-pencil act"></i>',
            onClick: ({ event }: { event: CalendarEvent }): void => {
                this.handleEvent('Edit', event);
            }
        },
        {
            label: '<i class="ti-close act"></i>',
            onClick: ({ event }: { event: CalendarEvent }): void => {
                this.events = this.events.filter(iEvent => iEvent !== event);
                this.handleEvent('Deleted', event);
            }
        }
    ];

    refresh: Subject<any> = new Subject();

    events: CalendarEvent[] = [
        {
            start: subDays(startOfDay(new Date()), 1),
            end: addDays(new Date(), 1),
            title: 'A 3 day event',
            color: colors.red,
            actions: this.actions
        },
        {
            start: startOfDay(new Date()),
            title: 'An event with no end date',
            color: colors.yellow,
            actions: this.actions
        },
        {
            start: subDays(endOfMonth(new Date()), 3),
            end: addDays(endOfMonth(new Date()), 3),
            title: 'A long event that spans 2 months',
            color: colors.blue
        },
        {
            start: addHours(startOfDay(new Date()), 2),
            end: new Date(),
            title: 'A draggable and resizable event',
            color: colors.yellow,
            actions: this.actions,
            resizable: {
                beforeStart: true,
                afterEnd: true
            },
            draggable: true
        }
    ];

    activeDayIsOpen = true;

    constructor(public dialog: MatDialog, @Inject(DOCUMENT) doc: any) { }

    dayClicked({ date, events }: { date: Date; events: CalendarEvent[] }): void {
        if (isSameMonth(date, this.viewDate)) {
            if (
                (isSameDay(this.viewDate, date) && this.activeDayIsOpen === true) ||
                events.length === 0
            ) {
                this.activeDayIsOpen = false;
            } else {
                this.activeDayIsOpen = true;
                this.viewDate = date;
            }
        }
    }

    eventTimesChanged({
        event,
        newStart,
        newEnd
    }: CalendarEventTimesChangedEvent): void {
        this.events = this.events.map((iEvent) => {
            if (iEvent === event) {
                return {
                    ...event,
                    start: newStart,
                    end: newEnd,
                };
            }
            return iEvent;
        });

        this.handleEvent('Dropped or resized', event);

    }

    handleEvent(action: string, event: CalendarEvent): void {
        debugger;
        this.config.data = { event, action };
        this.dialogRef = this.dialog.open(CalendarDialogComponent, this.config);

        this.dialogRef.afterClosed().subscribe((result: string) => {
            this.lastCloseResult = result;
            this.dialogRef = Object.create(null);
            this.refresh.next();
        });
    }

    addEvent(): void {
        this.dialogRef2 = this.dialog.open(CalendarFormDialogComponent, {
            panelClass: 'calendar-form-dialog',
            data: {
                action: 'add',
                date: new Date(),
            },
        });
        this.dialogRef2.afterClosed().subscribe((res) => {
            if (!res) {
                return;
            }
            const dialogAction = res.action;
            const responseEvent = res.event;
            responseEvent.actions = this.actions;
            this.events.push(responseEvent);
            this.dialogRef2 = Object.create(null);
            this.refresh.next();

        });
    }

    deleteEvent(eventToDelete: CalendarEvent): void {
        this.events = this.events.filter((event) => event !== eventToDelete);
    }

    setView(view: CalendarView): void {
        this.view = view;
    }
}
