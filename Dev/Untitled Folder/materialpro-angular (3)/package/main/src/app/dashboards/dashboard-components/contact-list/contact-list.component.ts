import { Component, OnInit, ViewChild, AfterViewInit } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { BreakpointObserver } from '@angular/cdk/layout';


export interface Element {
  name: string;
  pic: string;
  email: string;
  designation: string;
}


const ELEMENT_DATA: Element[] = [
  {
    pic: 'assets/images/users/1.jpg',
    name: 'Nirav joshi',
    email: 'nirav@gmail.com',
    designation: 'Hacker'
  },
  {
    pic: 'assets/images/users/2.jpg',
    name: 'Sunil joshi',
    email: 'sunil@gmail.com',
    designation: 'Designer'
  },
  {
    pic: 'assets/images/users/3.jpg',
    name: 'John Deo',
    email: 'deo@gmail.com',
    designation: 'Developer'
  },
  {
    pic: 'assets/images/users/4.jpg',
    name: 'Beryllium Lon',
    email: 'lon@gmail.com',
    designation: 'Front end Developer'
  },
  {
    pic: 'assets/images/users/5.jpg',
    name: 'Boron son',
    email: 'son@gmail.com',
    designation: 'Hacker'
  },
  {
    pic: 'assets/images/users/6.jpg',
    name: 'Carbon hryt',
    email: 'carbon@gmail.com',
    designation: 'Senior Developer'
  },
  {
    pic: 'assets/images/users/7.jpg',
    name: 'Nitro oxur',
    email: 'nitro@gmail.com',
    designation: 'Junior Developer'
  },
  {
    pic: 'assets/images/users/1.jpg',
    name: 'Nirav joshi',
    email: 'nirav@gmail.com',
    designation: 'Hacker'
  },
  {
    pic: 'assets/images/users/2.jpg',
    name: 'Sunil joshi',
    email: 'sunil@gmail.com',
    designation: 'Designer'
  },
  {
    pic: 'assets/images/users/3.jpg',
    name: 'John Deo',
    email: 'deo@gmail.com',
    designation: 'Developer'
  },
  {
    pic: 'assets/images/users/4.jpg',
    name: 'Beryllium Lon',
    email: 'lon@gmail.com',
    designation: 'Front end Developer'
  },
  {
    pic: 'assets/images/users/5.jpg',
    name: 'Boron son',
    email: 'son@gmail.com',
    designation: 'Hacker'
  }
];

@Component({
  selector: 'app-contact-list',
  templateUrl: './contact-list.component.html',
  styleUrls: ['./contact-list.component.scss']
})
export class ContactListComponent implements AfterViewInit {

  displayedColumns = ['name', 'email', 'designation'];
  // tslint:disable-next-line:member-ordering
  dataSource = new MatTableDataSource<Element>(ELEMENT_DATA);
  // tslint:disable-next-line:member-ordering
  @ViewChild(MatPaginator, { static: true }) paginator: MatPaginator = Object.create(null);

  constructor(breakpointObserver: BreakpointObserver) {
    breakpointObserver.observe(['(max-width: 600px)']).subscribe(result => {
      this.displayedColumns = result.matches ?
        ['name', 'email', 'designation'] :
        ['name', 'email', 'designation'];
    });
  }

  ngAfterViewInit(): void {
    this.dataSource.paginator = this.paginator;

  }

}
