import { Component } from '@angular/core';

@Component({
  selector: 'app-expansion',
  templateUrl: './expansion.component.html',
  styleUrls: ['./expansion.component.scss']
})
export class ExpansionComponent {
  panelOpenState = false;
  step = 0;

  setStep(index: number): void {
    this.step = index;
  }

  nextStep(): void {
    this.step++;
  }

  prevStep(): void {
    this.step--;
  }
}
