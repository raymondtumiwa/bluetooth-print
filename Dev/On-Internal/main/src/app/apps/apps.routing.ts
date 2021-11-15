import { Routes } from '@angular/router';

import { FullcalendarComponent } from './fullcalendar/fullcalendar.component';
import { MailComponent } from './mail/mail.component';
import { ChatComponent } from './chat/chat.component';
import { TaskboardComponent } from './taskboard/taskboard.component';
import { TicketlistComponent } from './ticketlist/ticketlist.component';
import { TicketdetailsComponent } from './ticketdetails/ticketdetails.component';
import { ContactComponent } from './contact/contact.component';
import { EmployeeComponent } from './employee/employee.component';
import { NotesComponent } from './notes/notes.component';
import { CoursesComponent } from './courses/courses.component';
import { ListingComponent } from './mailbox/listing/listing.component';
import { DetailComponent } from './mailbox/detail/detail.component';
import { MailboxComponent } from './mailbox/mailbox.component';



import { InvoiceListComponent } from './invoice/invoice-list/invoice-list.component';
import { InvoiceViewComponent } from './invoice/invoice-view/invoice-view.component';
import { AddInvoiceComponent } from './invoice/add-invoice/add-invoice.component';
import { EditInvoiceComponent } from './invoice/edit-invoice/edit-invoice.component';
import { TodoComponent } from './todo/todo.component';
import { CourseDetailComponent } from './courses/course-detail/course-detail.component';


export const AppsRoutes: Routes = [
    {
        path: '',
        children: [
            {
                path: 'calendar',
                component: FullcalendarComponent,
                data: {
                    title: 'Calendar',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Calendar' }
                    ]
                }
            },
            { path: 'mailbox', redirectTo: 'mailbox/inbox', pathMatch: 'full' },

            {
                path: 'mailbox/:type',
                component: MailboxComponent,
                children: [
                    {
                        path: ':id', component: DetailComponent,
                        data: {
                            title: 'New Email',
                            urls: [
                                { title: 'Dashboard', url: '/dashboard' },
                                { title: 'Email' }
                            ]
                        }
                    },

                ],
                data: {
                    title: 'New Email',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Email' }
                    ]
                }
            },
            {
                path: 'messages',
                component: MailComponent,
                data: {
                    title: 'Email',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Email' }
                    ]
                }
            },
            {
                path: 'chat',
                component: ChatComponent,
                data: {
                    title: 'Chat',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Chat' }
                    ]
                }
            },
            {
                path: 'taskboard',
                component: TaskboardComponent,
                data: {
                    title: 'Taskboard',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Taskboard' }
                    ]
                }
            },
            {
                path: 'notes',
                component: NotesComponent,
                data: {
                    title: 'Notes',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Notes' }
                    ]
                }
            },
            {
                path: 'ticketlist',
                component: TicketlistComponent,
                data: {
                    title: 'Ticket List',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Ticket List' }
                    ]
                }
            },
            {
                path: 'ticketdetails',
                component: TicketdetailsComponent,
                data: {
                    title: 'Ticket Details',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Ticket Details' }
                    ]
                }
            },
            {
                path: 'employeelist',
                component: EmployeeComponent,
                data: {
                    title: 'Employee List',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Employee List' }
                    ]
                }
            },
            {
                path: 'contact',
                component: ContactComponent,
                data: {
                    title: 'Contact',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Contact' }
                    ]
                }
            },
            {
                path: 'courses',
                component: CoursesComponent,
                data: {
                    title: 'Courses',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Courses' }
                    ]
                }
            },
            {
                path: 'courses/coursesdetail/:id',
                component: CourseDetailComponent,
                data: {
                    title: 'Courses Detail',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Courses' }
                    ]
                }
            },
            {
                path: 'invoice',
                component: InvoiceListComponent,
                data: {
                    title: 'Invoice',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Invoice' }
                    ]
                }
            },
            {
                path: 'addInvoice',
                component: AddInvoiceComponent,
                data: {
                    title: '',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: '' }
                    ]
                }
            },
            {
                path: 'viewInvoice/:id',
                component: InvoiceViewComponent,
                data: {
                    title: 'View Invoice',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'View Invoice' }
                    ]
                }
            },
            {
                path: 'editinvoice/:id',
                component: EditInvoiceComponent,
                data: {
                    title: '',
                    urls: [

                    ]
                }
            },
            {
                path: 'todo',
                component: TodoComponent,
                data: {
                    title: 'Todo',
                    urls: [

                    ]
                }
            }
        ]
    }
];
