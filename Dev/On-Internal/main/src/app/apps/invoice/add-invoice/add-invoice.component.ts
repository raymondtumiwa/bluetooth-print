import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormControl, FormArray, NgForm } from '@angular/forms';
import { order, InvoiceList } from '../invoice';
import { ServiceinvoiceService } from '../serviceinvoice.service';
import { Router } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { AddedDialogComponent } from './added-dialog/added-dialog.component';


@Component({
  selector: 'app-add-invoice',
  templateUrl: './add-invoice.component.html',
  styleUrls: ['./add-invoice.component.css']
})
export class AddInvoiceComponent implements OnInit {

  addForm: FormGroup;
  rows: FormArray;
  invoice: InvoiceList = new InvoiceList();

  ///////////////////////////////////////////////////////////
  subTotal = 0;
  vat = 0;
  grandTotal = 0;

  constructor(private fb: FormBuilder, private invoiceService: ServiceinvoiceService, private router: Router, public dialog: MatDialog) {
    // tslint:disable-next-line - Disables all
    this.invoice.id = Math.max.apply(Math, this.invoiceService.getInvoiceList().map(function (o: any) { return o.id; })) + 1;
    this.invoice.status = 'Pending';

    ///////////////////////////////////////////////////////////

    this.addForm = this.fb.group({
    });

    this.rows = this.fb.array([]);
    this.addForm.addControl('rows', this.rows);
    this.rows.push(this.createItemFormGroup());
  }

  ngOnInit(): void {
  }



  ////////////////////////////////////////////////////////////////////////////////////
  onAddRow(): void {
    this.rows.push(this.createItemFormGroup());
  }

  onRemoveRow(rowIndex: number): void {
    const totalCostOfItem = this.addForm.get('rows')?.value[rowIndex].unitPrice *
      this.addForm.get('rows')?.value[rowIndex].units;

    this.subTotal = this.subTotal - totalCostOfItem;
    this.vat = this.subTotal / 10;
    this.grandTotal = this.subTotal + this.vat;
    this.rows.removeAt(rowIndex);
  }

  createItemFormGroup(): FormGroup {
    return this.fb.group({
      itemName: ['', Validators.required],
      units: ['', Validators.required],
      unitPrice: ['', Validators.required],
      itemTotal: ['0']
    });
  }

  itemsChanged(): void {
    let total: number = 0;
    // tslint:disable-next-line - Disables all
    for (let t = 0; t < (<FormArray>this.addForm.get('rows')).length; t++) {
      if (this.addForm.get('rows')?.value[t].unitPrice !== '' && this.addForm.get('rows')?.value[t].units) {
        total = (this.addForm.get('rows')?.value[t].unitPrice * this.addForm.get('rows')?.value[t].units) + total;
      }
    }
    this.subTotal = total;
    this.vat = this.subTotal / 10;
    this.grandTotal = this.subTotal + this.vat;
  }
  ////////////////////////////////////////////////////////////////////

  saveDetail(): void {
    this.invoice.grandTotal = this.grandTotal;
    this.invoice.totalCost = this.subTotal;
    this.invoice.vat = this.vat;
    // tslint:disable-next-line - Disables all
    for (let t = 0; t < (<FormArray>this.addForm.get('rows')).length; t++) {
      const o: order = new order();
      o.itemName = this.addForm.get('rows')?.value[t].itemName;
      o.unitPrice = this.addForm.get('rows')?.value[t].unitPrice;
      o.units = this.addForm.get('rows')?.value[t].units;
      o.unitTotalPrice = o.units * o.unitPrice;
      this.invoice.orders.push(o);
    }
    this.dialog.open(AddedDialogComponent);
    this.invoiceService.addInvoice(this.invoice);
    this.router.navigate(['/apps/invoice']);
  }
}
