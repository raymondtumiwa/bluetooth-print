import { Component } from '@angular/core';


@Component({
    selector: 'app-row-context',
    templateUrl: './row-context-table.component.html',
    styleUrls: ['./row-context-table.component.scss']
})

export class RowcontextTableComponent {
    displayedColumns: string[] = ['$implicit', 'index', 'count', 'first', 'last', 'even', 'odd'];
    data: string[] = ['one', 'two', 'three', 'four', 'five'];
}
