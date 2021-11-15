import { Component } from '@angular/core';
import { Transaction } from '../footerrow-table/footerrow-table.component';

@Component({
    selector: 'app-multiple-headerfooter',
    templateUrl: './multiple-header-footer.component.html',
    styleUrls: ['./multiple-header-footer.component.scss']
})

export class MultipleheaderfooterTableComponent {
    displayedColumns: string[] = ['item', 'cost'];
    transactions: Transaction[] = [
        { item: 'Beach ball', cost: 4 },
        { item: 'Towel', cost: 5 },
        { item: 'Frisbee', cost: 2 },
        { item: 'Sunscreen', cost: 4 },
        { item: 'Cooler', cost: 25 },
        { item: 'Swim suit', cost: 15 },
    ];

    /** Gets the total cost of all transactions. */
    getTotalCost(): any {
        return this.transactions.map(t => t.cost).reduce((acc, value) => acc + value, 0);
    }
}

