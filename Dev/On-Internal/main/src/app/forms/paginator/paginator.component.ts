import { Component, OnInit } from '@angular/core';
import { PageEvent } from '@angular/material/paginator';

@Component({
    selector: 'app-paginator',
    templateUrl: './paginator.component.html',
    styleUrls: ['./paginator.component.scss']
})
export class PaginatiorComponent {
    // MatPaginator Inputs
    length = 100;
    pageSize = 10;
    pageSizeOptions: number[] = [5, 10, 25, 100];

    // MatPaginator Output
    pageEvent: PageEvent = Object.create(null);

    setPageSizeOptions(setPageSizeOptionsInput: string): void {
        this.pageSizeOptions = setPageSizeOptionsInput.split(',').map(str => +str);
    }
}
