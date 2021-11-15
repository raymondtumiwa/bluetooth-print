import { Component, OnInit } from '@angular/core';
import { ServiceinvoiceService } from '../serviceinvoice.service';
import { InvoiceList } from '../invoice';
import { ActivatedRoute } from '@angular/router';
import { MatTableDataSource } from '@angular/material/table';


@Component({
  selector: 'app-invoice-view',
  templateUrl: './invoice-view.component.html',
  styleUrls: ['./invoice-view.component.scss']
})
export class InvoiceViewComponent implements OnInit {

  id: any;
  invoiceDetail: InvoiceList;
  displayedColumns: string[] = ['itemName', 'unitPrice', 'unit', 'total'];


  constructor(activatedRouter: ActivatedRoute, private invoiceService: ServiceinvoiceService) {
    this.id = activatedRouter.snapshot.paramMap.get('id');
    this.invoiceDetail = this.invoiceService.getInvoiceList().filter(x => x?.id === +this.id)[0];
  }

  ngOnInit(): void {
  }

}
