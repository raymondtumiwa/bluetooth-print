import { Component } from '@angular/core';
import { DateAdapter } from '@angular/material/core';
import { FormControl } from '@angular/forms';
import { MatDatepickerInputEvent } from '@angular/material/datepicker';

import { MomentDateAdapter, MAT_MOMENT_DATE_ADAPTER_OPTIONS } from '@angular/material-moment-adapter';
import { MAT_DATE_FORMATS, MAT_DATE_LOCALE } from '@angular/material/core';

import * as _moment from 'moment';

const moment = _moment;

export const MY_FORMATS = {
    parse: {
        dateInput: 'LL',
    },
    display: {
        dateInput: 'LL',
        monthYearLabel: 'MMM YYYY',
        dateA11yLabel: 'LL',
        monthYearA11yLabel: 'MMMM YYYY',
    }
};

@Component({
    selector: 'app-datepicker',
    templateUrl: './datepicker.component.html',
    styleUrls: ['./datepicker.component.scss'],
    // providers: [
    //     {
    //         provide: DateAdapter,
    //         useClass: MomentDateAdapter,
    //         deps: [MAT_DATE_LOCALE, MAT_MOMENT_DATE_ADAPTER_OPTIONS]
    //     },
    //     { provide: MAT_DATE_FORMATS, useValue: MY_FORMATS }
    // ]
})
export class DatepickerComponent {

    constructor(private adapter: DateAdapter<any>) { }
    // this is for the start date
    startDate = new Date(1990, 0, 1);

    minDate = new Date(2000, 0, 1);
    maxDate = new Date(2020, 0, 1);

    // Datepicker selected value
    date = new FormControl(new Date());
    serializedDate = new FormControl(new Date().toISOString());

    // Datepicker input and change event

    events: string[] = [];

    // custom date
    customdate = new FormControl(moment());

    addEvent(type: string, event: MatDatepickerInputEvent<Date>): void {
        this.events.push(`${type}: ${event.value}`);
    }

    myFilter = (d: Date): boolean => {
        const day = d.getDay();
        // Prevent Saturday and Sunday from being selected.
        return day !== 0 && day !== 6;
        // tslint:disable-next-line:semicolon
    };

    french(): void {
        this.adapter.setLocale('fr');
    }
}
