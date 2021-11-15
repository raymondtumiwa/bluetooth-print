import { Component, OnInit, Inject, Optional, ViewChild } from '@angular/core';
import { MatTableDataSource, MatTable } from '@angular/material/table';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

export interface TicketElement {
    id: number;
    creator: string;
    title: string;
    assignee: string;
    status: string;
    labelbg: string;
    product: string;
    date: string;
}

const tickets: TicketElement[] = [
    {
        id: 77,
        creator: 'Eric Pratt',
        title: 'Elegant Theme Side Menu show OnClick',
        assignee: 'Alice Bohr',
        status: 'In Progress',
        labelbg: 'warning',
        product: 'Elegant Admin',
        date: '2018-05-01'
    },
    {
        id: 78,
        creator: 'Steve',
        title: 'Xtreme theme dropdown issue',
        assignee: 'Jonathan',
        status: 'Open',
        labelbg: 'success',
        product: 'Xtreme Admin',
        date: '2018-05-03'
    },
    {
        id: 79,
        creator: 'Mark',
        title: 'Header issue in material admin',
        assignee: 'Smith J',
        status: 'Closed',
        labelbg: 'danger',
        product: 'Material Admin',
        date: '2018-05-02'
    },
    {
        id: 80,
        creator: 'John Doe',
        title: 'Sidebar issue in Nice admin',
        assignee: 'Vincent',
        status: 'In Progress',
        labelbg: 'warning',
        product: 'Nice Admin',
        date: '2018-05-06'
    },
    {
        id: 81,
        creator: 'Jennifer',
        title: 'Elegant Theme Side Menu show OnClick',
        assignee: 'Chris Martin',
        status: 'Open',
        labelbg: 'success',
        product: 'Elagant Admin',
        date: '2018-05-04'
    },
    {
        id: 82,
        creator: 'Harper',
        title: 'Header issue in admin pro admin',
        assignee: 'James F',
        status: 'Closed',
        labelbg: 'danger',
        product: 'Adminpro Admin',
        date: '2018-05-03'
    },
    {
        id: 83,
        creator: 'Billy John',
        title: 'Elegant Theme Side Menu OnClick',
        assignee: 'Jonathan',
        status: 'In Progress',
        labelbg: 'warning',
        product: 'Elegant Admin',
        date: '2018-05-05'
    },
    {
        id: 84,
        creator: 'Allen Brook',
        title: 'adminpress Theme Side Menu not opening',
        assignee: 'Smith J',
        status: 'Open',
        labelbg: 'success',
        product: 'Adminpress Admin',
        date: '2018-05-04'
    },
    {
        id: 85,
        creator: 'Olivia Hart',
        title: 'Charts not proper in xtreme admin',
        assignee: 'Markus',
        status: 'Closed',
        labelbg: 'danger',
        product: 'Xtreme Admin',
        date: '2018-05-02'
    },
    {
        id: 86,
        creator: 'Luis Orys',
        title: 'Psd not availabel with package',
        assignee: 'Jane',
        status: 'Closed',
        labelbg: 'danger',
        product: 'Material Admin',
        date: '2018-05-03'
    }
];

@Component({
    templateUrl: './ticketlist.component.html'
})
export class TicketlistComponent implements OnInit {

    @ViewChild(MatTable, { static: true }) table: MatTable<any> = Object.create(null);
    searchText: any;
    totalCount = -1;
    Closed = -1;
    Inprogress = -1;
    Open = -1;

    displayedColumns: string[] = ['creator', 'title', 'assignee', 'status', 'product', 'date', 'action'];
    dataSource = new MatTableDataSource(tickets);


    constructor(public dialog: MatDialog) { }

    ngOnInit(): void {
        this.totalCount = this.dataSource.data.length;
        this.Open = this.btnCategoryClick('Open');
        this.Closed = this.btnCategoryClick('Closed');
        this.Inprogress = this.btnCategoryClick('In Progress');
        this.dataSource = new MatTableDataSource(tickets);
    }


    applyFilter(filterValue: string): void {
        this.dataSource.filter = filterValue.trim().toLowerCase();
    }

    btnCategoryClick(val: string): number {
        this.dataSource.filter = val.trim().toLowerCase();
        return this.dataSource.filteredData.length;

    }

    openDialog(action: string, obj: any): void {
        obj.action = action;
        const dialogRef = this.dialog.open(TicketDialogContent, {
            data: obj
        });

        dialogRef.afterClosed().subscribe(result => {
            if (result.event === 'Add') {
                this.addRowData(result.data);
            } else if (result.event === 'Update') {
                this.updateRowData(result.data);
            } else if (result.event === 'Delete') {
                this.deleteRowData(result.data);
            }
        });
    }
    // tslint:disable-next-line - Disables all
    addRowData(row_obj: TicketElement): void {
        const d = new Date();
        this.dataSource.data.push({
            id: d.getTime(),
            creator: row_obj.creator,
            title: row_obj.title,
            assignee: row_obj.assignee,
            status: row_obj.status,
            labelbg: row_obj.labelbg,
            product: row_obj.product,
            date: row_obj.date,
        });
        this.table.renderRows();

    }

    // tslint:disable-next-line - Disables all
    updateRowData(row_obj: TicketElement): boolean | any {
        this.dataSource.data = this.dataSource.data.filter((value, key) => {
            if (value.id === row_obj.id) {
                value.creator = row_obj.creator;
                value.title = row_obj.title;
                value.assignee = row_obj.assignee;
                value.status = row_obj.status;
                value.labelbg = row_obj.labelbg;
                value.product = row_obj.product;
                value.date = row_obj.date;
            }
            return true;
        });
    }

    // tslint:disable-next-line - Disables all
    deleteRowData(row_obj: TicketElement): boolean | any {
        this.dataSource.data = this.dataSource.data.filter((value, key) => {
            return value.id !== row_obj.id;
        });
    }


}

@Component({
    // tslint:disable-next-line - Disables all
    selector: 'dialog-content',
    templateUrl: 'dialog-content.html',
})
// tslint:disable-next-line - Disables all
export class TicketDialogContent {
    action: string;
    // tslint:disable-next-line - Disables all
    local_data: any;

    constructor(public dialogRef: MatDialogRef<TicketDialogContent>,
        @Optional() @Inject(MAT_DIALOG_DATA) public data: TicketElement) {
        debugger;

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
