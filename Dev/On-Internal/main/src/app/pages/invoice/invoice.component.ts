import { Component } from '@angular/core';

@Component({
  selector: 'app-invoice',
  templateUrl: './invoice.component.html',
  styleUrls: ['./invoice.component.scss']
})
export class InvoiceComponent {
  invoiceItems = [
    {
      title: 'Ample Admin',
      subtitle: 'The ultimate admin template',
      price: 499.0,
      quantity: 1
    },
    {
      title: 'Material Pro Admin',
      subtitle: 'Material Based admin template',
      price: 399.0,
      quantity: 1
    },
    {
      title: 'Wrapkit',
      subtitle: 'Bootstrap 4 UI kit',
      price: 599.0,
      quantity: 1
    },
    {
      title: 'Admin Wrap',
      subtitle: 'Free admin template with UI kit',
      price: 0.0,
      quantity: 1
    }
  ];

  invoiceTotals = [
    {
      subtotal: this.getSubTotal(),
      tax: this.getCalculatedTax(),
      discount: 0.0,
      total: 0
    }
  ];

  getSubTotal(): number {
    let total = 0.0;
    for (let i = 1; i < this.invoiceItems.length; i++) {
      total += this.invoiceItems[i].price * this.invoiceItems[i].quantity;
    }
    return total;
  }

  getCalculatedTax(): number {
    return (2 * this.getSubTotal()) / 100;
  }

  getTotal(): number {
    return this.getSubTotal() + this.getCalculatedTax();
  }

  constructor() { }
}
