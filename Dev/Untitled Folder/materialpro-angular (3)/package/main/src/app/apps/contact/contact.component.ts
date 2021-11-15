import { Component, OnInit, Inject, Optional } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Contact } from './contact';

export interface ContactData {
    closeResult: string;
    contacts: Contact[];
    searchText: any;
    txtContactname: string;
    txtContactPost: string;
    txtContactadd: string;
    txtContactno: string;
    txtContactinstagram: string;
    txtContactlinkedin: string;
    txtContactfacebook: string;
}

@Component({
    templateUrl: './contact.component.html'
})
export class ContactComponent implements OnInit {

    closeResult = '';
    contacts: Contact[] = [];
    searchText: any;
    txtContactname = '';
    txtContactPost = '';
    txtContactadd = '';
    txtContactno = '';
    txtContactinstagram = '';
    txtContactlinkedin = '';
    txtContactfacebook = '';

    constructor(public dialog: MatDialog) { }

    openDialog(action: string, obj: any): void {
        obj.action = action;
        const dialogRef = this.dialog.open(DialogContent, {
            data: obj
        });

        dialogRef.afterClosed().subscribe(result => {
            if (result.event === 'Add') {
                this.addContact(result.data);
            }

        });
    }

    ngOnInit(): void {
        this.contacts = [
            {
                contactimg: 'assets/images/users/2.jpg',
                contactname: 'Johnathan Doe',
                contactpost: 'Web Designer',
                contactadd: '795 Folsom Ave, Suite 600 San Francisco, CADGE 94107',
                contactno: '(123) 456-7890',
                contactinstagram: '254',
                contactlinkedin: '54',
                contactfacebook: '154'
            },
            {
                contactimg: 'assets/images/users/8.jpg',
                contactname: 'Oliver Smith',
                contactpost: 'Theme Designer',
                contactadd: '55 E 11th St #1OTH, Suite 600 New York, NY, 10003 ',
                contactno: '(212) 228-8403',
                contactinstagram: '150',
                contactlinkedin: '14',
                contactfacebook: '165'
            },
            {
                contactimg: 'assets/images/users/4.jpg',
                contactname: 'George Johnson',
                contactpost: 'Front End Developer',
                contactadd: '36 W 138th St, San Francisco New York, NY, 10037',
                contactno: '(212) 234-0783',
                contactinstagram: '300',
                contactlinkedin: '65',
                contactfacebook: '130'
            },
            {
                contactimg: 'assets/images/users/5.jpg',
                contactname: 'Harry Potter',
                contactpost: 'Hacker',
                contactadd: '2289 5th Ave, Suite 600 San Francisco New York, NY, 10037',
                contactno: '(212) 456-8403',
                contactinstagram: '220',
                contactlinkedin: '38',
                contactfacebook: '178'
            },
            {
                contactimg: 'assets/images/users/6.jpg',
                contactname: 'Jack Williams',
                contactpost: 'Back End Developer',
                contactadd: '425 5th Ave, San Francisco New York, NY, 10016',
                contactno: '(154) 456-8745',
                contactinstagram: '650',
                contactlinkedin: '150',
                contactfacebook: '195'
            },
            {
                contactimg: 'assets/images/users/7.jpg',
                contactname: 'Jacob Jones',
                contactpost: 'Graphics Designer',
                contactadd: '17 Stuyvesant Walk, Suite 600 New York, NY, 10009',
                contactno: '(150) 784-7890',
                contactinstagram: '151',
                contactlinkedin: '29',
                contactfacebook: '160'
            }
        ];
    }

    // tslint:disable-next-line - Disables all
    addContact(row_obj: ContactData): void {
        this.contacts.push({
            contactimg: 'assets/images/users/6.jpg',
            contactname: row_obj.txtContactname,
            contactpost: row_obj.txtContactPost,
            contactadd: row_obj.txtContactadd,
            contactno: row_obj.txtContactno,
            contactinstagram: row_obj.txtContactinstagram,
            contactlinkedin: row_obj.txtContactlinkedin,
            contactfacebook: row_obj.txtContactfacebook
        });
    }


}

@Component({
    // tslint:disable-next-line: component-selector
    selector: 'dialog-content',
    templateUrl: 'dialog-content.html',
})
// tslint:disable-next-line: component-class-suffix
export class DialogContent {
    action: string;
    // tslint:disable-next-line - Disables all
    local_data: any;

    constructor(
        public dialogRef: MatDialogRef<DialogContent>,
        // @Optional() is used to prevent error if no data is passed
        @Optional() @Inject(MAT_DIALOG_DATA) public data: ContactData) {
        // console.log(data);
        this.local_data = { ...data };
        this.action = this.local_data.action;
    }

    doAction(): void {
        this.dialogRef.close({ event: this.action, data: this.local_data });
    }

    closeDialog(): void {
        this.dialogRef.close({ event: 'Cancel' });
    }

}
