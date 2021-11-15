import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule, DatePipe } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DemoMaterialModule } from '../demo-material-module';
import { FlexLayoutModule } from '@angular/flex-layout';
import { QuillModule } from 'ngx-quill';
import { CalendarModule, DateAdapter, CalendarDateFormatter } from 'angular-calendar';
import { adapterFactory } from 'angular-calendar/date-adapters/date-fns';
import { PerfectScrollbarModule } from 'ngx-perfect-scrollbar';
import { Ng2SearchPipeModule } from 'ng2-search-filter';
import { AppsRoutes } from './apps.routing';
import { NgxPaginationModule } from 'ngx-pagination';
import { DragDropModule } from '@angular/cdk/drag-drop';
import { FullcalendarComponent } from './fullcalendar/fullcalendar.component';
import {
    MailComponent,
    DialogDataExampleDialogComponent
} from './mail/mail.component';
import { ChatComponent } from './chat/chat.component';
import { DialogContent } from './contact/contact.component';
import { TicketDialogContent } from './ticketlist/ticketlist.component';
import { EmployeeDialogContent } from './employee/employee.component';

import { CoursesComponent } from './courses/courses.component';
import { CourseService } from './courses/course.service';
import { TicketlistComponent } from './ticketlist/ticketlist.component';
import { EmployeeComponent } from './employee/employee.component';
import { NotesComponent } from './notes/notes.component';
import { TicketdetailsComponent } from './ticketdetails/ticketdetails.component';
import { ContactComponent } from './contact/contact.component';
import { CalendarDialogComponent } from './fullcalendar/fullcalendar.component';
import { TaskboardComponent } from './taskboard/taskboard.component';
import { NgApexchartsModule } from 'ng-apexcharts';
import { NoteService } from './notes/note.service';
import { ListingComponent, ListingDialogDataExampleDialogComponent } from './mailbox/listing/listing.component';
import { DetailComponent } from './mailbox/detail/detail.component';
import { MailboxComponent } from './mailbox/mailbox.component';

import { InvoiceListComponent } from './invoice/invoice-list/invoice-list.component';
import { InvoiceViewComponent } from './invoice/invoice-view/invoice-view.component';
import { AddInvoiceComponent } from './invoice/add-invoice/add-invoice.component';
import { EditInvoiceComponent } from './invoice/edit-invoice/edit-invoice.component';
import { TodoComponent } from './todo/todo.component';
import { TodoService } from './todo/todo.service';
import { OkDialogComponent } from './invoice/edit-invoice/ok-dialog/ok-dialog.component';
import { AddedDialogComponent } from './invoice/add-invoice/added-dialog/added-dialog.component';
import { AddComponent } from './employee/add/add.component';

import { CalendarFormDialogComponent } from './fullcalendar/calendar-form-dialog/calendar-form-dialog.component';

import { CourseDetailComponent } from './courses/course-detail/course-detail.component';
import { TaskDialogComponent } from './taskboard/task-dialog.component';
import { OkTaskComponent } from './taskboard/ok-task/ok-task.component';
import { DeleteTaskComponent } from './taskboard/delete-task/delete-task.component';

@NgModule({
    imports: [
        CommonModule,
        RouterModule.forChild(AppsRoutes),
        DemoMaterialModule,
        FormsModule,
        ReactiveFormsModule,
        CalendarModule.forRoot({
            provide: DateAdapter,
            useFactory: adapterFactory
        }),
        FlexLayoutModule,
        QuillModule.forRoot(),
        NgApexchartsModule,
        PerfectScrollbarModule,
        Ng2SearchPipeModule,
        DragDropModule,
        NgxPaginationModule
    ],
    declarations: [
        FullcalendarComponent,
        MailComponent,
        ListingDialogDataExampleDialogComponent,
        ListingComponent,
        DetailComponent,
        MailboxComponent,
        DialogDataExampleDialogComponent,
        ChatComponent,
        CalendarDialogComponent,
        TaskboardComponent,
        TicketlistComponent,
        CoursesComponent,
        TicketdetailsComponent,
        ContactComponent,
        DialogContent,
        TicketDialogContent,
        EmployeeComponent,
        EmployeeDialogContent,
        NotesComponent,
        InvoiceListComponent,
        InvoiceViewComponent,
        AddInvoiceComponent,
        EditInvoiceComponent,
        TodoComponent,
        OkDialogComponent,
        AddedDialogComponent,
        AddComponent,
        CalendarFormDialogComponent,
        CourseDetailComponent,
        TaskDialogComponent,
        OkTaskComponent,
        DeleteTaskComponent,
    ],
    providers: [
        NoteService,
        CourseService,
        TodoService,
        DatePipe
    ],
    entryComponents: [
        CalendarDialogComponent,
        DialogDataExampleDialogComponent,
        DialogContent,
        TicketDialogContent,
        EmployeeDialogContent,
        OkDialogComponent,
        AddedDialogComponent,
        AddComponent,
        CalendarFormDialogComponent,
        TaskDialogComponent,
        OkTaskComponent,
        DeleteTaskComponent
    ]
})
export class AppsModule { }
