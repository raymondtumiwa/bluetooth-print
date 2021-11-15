import { Component, OnInit, Inject, Optional, ViewChild, AfterViewInit } from '@angular/core';
import { MatTableDataSource, MatTable } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { DatePipe } from '@angular/common';
import { EmpDialogComponent } from './emp-dialog/emp-dialog.component';

export interface Employee {
    id: number;
    Name: string;
    Position: string;
    Email: string;
    Mobile: number;
    DateOfJoining: Date;
    Salary: number;
    Projects: number;
    imagePath: string;
}

const employees = [
    {
        id: 1,
        Name: 'Johnathan Deo',
        Position: 'Seo Expert',
        Email: 'r@gmail.com',
        Mobile: 9786838,
        DateOfJoining: new Date('01-2-2020'),
        Salary: 12000,
        Projects: 10,
        imagePath: 'assets/images/users/2.jpg'
    },
    {
        id: 2,
        Name: 'Mark Zukerburg',
        Position: 'Web Developer',
        Email: 'mark@gmail.com',
        Mobile: 8786838,
        DateOfJoining: new Date('04-2-2020'),
        Salary: 12000,
        Projects: 10,
        imagePath: 'assets/images/users/3.jpg'
    },
    {
        id: 3,
        Name: 'Sam smith',
        Position: 'Web Designer',
        Email: 'sam@gmail.com',
        Mobile: 7788838,
        DateOfJoining: new Date('02-2-2020'),
        Salary: 12000,
        Projects: 10,
        imagePath: 'assets/images/users/4.jpg'
    },
    {
        id: 4,
        Name: 'John Deo',
        Position: 'Tester',
        Email: 'john@gmail.com',
        Mobile: 8786838,
        DateOfJoining: new Date('03-2-2020'),
        Salary: 12000,
        Projects: 11,
        imagePath: 'assets/images/users/5.jpg'
    },
    {
        id: 5,
        Name: 'Genilia',
        Position: 'Actor',
        Email: 'genilia@gmail.com',
        Mobile: 8786838,
        DateOfJoining: new Date('05-2-2020'),
        Salary: 12000,
        Projects: 19,
        imagePath: 'assets/images/users/6.jpg'
    },
    {
        id: 6,
        Name: 'Jack Sparrow',
        Position: 'Content Writer',
        Email: 'jac@gmail.com',
        Mobile: 8786838,
        DateOfJoining: new Date('05-21-2020'),
        Salary: 12000,
        Projects: 5,
        imagePath: 'assets/images/users/7.jpg'
    },
    {
        id: 7,
        Name: 'Tom Cruise',
        Position: 'Actor',
        Email: 'tom@gmail.com',
        Mobile: 8786838,
        DateOfJoining: new Date('02-15-2019'),
        Salary: 12000,
        Projects: 9,
        imagePath: 'assets/images/users/3.jpg'
    },
    {
        id: 8,
        Name: 'Hary Porter',
        Position: 'Actor',
        Email: 'hary@gmail.com',
        Mobile: 8786838,
        DateOfJoining: new Date('07-3-2019'),
        Salary: 12000,
        Projects: 7,
        imagePath: 'assets/images/users/6.jpg'
    },
    {
        id: 9,
        Name: 'Kristen Ronaldo',
        Position: 'Player',
        Email: 'kristen@gmail.com',
        Mobile: 8786838,
        DateOfJoining: new Date('01-15-2019'),
        Salary: 12000,
        Projects: 1,
        imagePath: 'assets/images/users/5.jpg'
    }
];

@Component({
    selector: 'app-dashboard-emp',
    templateUrl: './dashboard-emp.component.html',
    styleUrls: ['./dashboard-emp.component.scss']
})
export class DashboardEmpComponent implements OnInit, AfterViewInit {

    @ViewChild(MatTable, { static: true }) table: MatTable<any> = Object.create(null);
    searchText: any;
    displayedColumns: string[] = ['name', 'email', 'mobile', 'action'];


    dataSource = new MatTableDataSource(employees);

    @ViewChild(MatPaginator, { static: true }) paginator: MatPaginator = Object.create(null);


    constructor(public dialog: MatDialog, public datePipe: DatePipe) { }

    ngOnInit(): void {

    }

    ngAfterViewInit(): void {
        this.dataSource.paginator = this.paginator;
    }

    applyFilter(filterValue: string): void {
        this.dataSource.filter = filterValue.trim().toLowerCase();
    }

    // tslint:disable-next-line - Disables all
    openDialog(action: string, obj: any): void {
        obj.action = action;
        const dialogRef = this.dialog.open(EmpDialogComponent, {
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
    addRowData(row_obj: Employee): void {
        this.dataSource.data.splice(0, 0, {
            id: employees.length + 1,
            Name: row_obj.Name,
            Position: row_obj.Position,
            Email: row_obj.Email,
            Mobile: row_obj.Mobile,
            DateOfJoining: new Date(),
            Salary: row_obj.Salary,
            Projects: row_obj.Projects,
            imagePath: row_obj.imagePath
        });
        this.table.renderRows();
    }

    // tslint:disable-next-line - Disables all
    updateRowData(row_obj: Employee): boolean | void {
        this.dataSource.data = this.dataSource.data.filter((value) => {
            if (value.id === row_obj.id) {
                value.Name = row_obj.Name;
                value.Position = row_obj.Position;
                value.Email = row_obj.Email;
                value.Mobile = row_obj.Mobile;
                value.DateOfJoining = row_obj.DateOfJoining;
                value.Salary = row_obj.Salary;
                value.Projects = row_obj.Projects;
                value.imagePath = row_obj.imagePath;
            }
            return true;
        });
    }

    // tslint:disable-next-line - Disables all
    deleteRowData(row_obj: Employee): boolean | void {
        this.dataSource.data = this.dataSource.data.filter((value) => {
            return value.id !== row_obj.id;
        });
    }
}
