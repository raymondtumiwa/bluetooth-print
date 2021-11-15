import { Component } from '@angular/core';
import { Observable, Observer } from 'rxjs';
import { FormControl } from '@angular/forms';

export interface ExampleTab {
    label: string;
    content: string;
}

@Component({
    selector: 'app-tabs',
    templateUrl: './tabs.component.html',
    styleUrls: ['./tabs.component.scss']
})
export class TabsComponent {
    tabs = ['First', 'Second', 'Third'];
    selected = new FormControl(0);

    tabLoadTimes: Date[] = [];

    asyncTabs: Observable<ExampleTab[]>;

    links = ['First', 'Second', 'Third'];
    activeLink = this.links[0];
    background = '';

    addTab(selectAfterAdding: boolean): void {
        this.tabs.push('New');

        if (selectAfterAdding) {
            this.selected.setValue(this.tabs.length - 1);
        }
    }

    removeTab(index: number): void {
        this.tabs.splice(index, 1);
    }

    getTimeLoaded(index: number): any {
        if (!this.tabLoadTimes[index]) {
            this.tabLoadTimes[index] = new Date();
        }

        return this.tabLoadTimes[index];
    }

    constructor() {
        // tslint:disable-next-line: deprecation
        this.asyncTabs = Observable.create((observer: Observer<ExampleTab[]>) => {
            setTimeout(() => {
                observer.next([
                    { label: 'First', content: 'Content 1' },
                    { label: 'Second', content: 'Content 2' },
                    { label: 'Third', content: 'Content 3' }
                ]);
            }, 1000);
        });
    }

    toggleBackground(): void {
        this.background = this.background ? '' : 'primary';
    }

    addLink(): void {
        this.links.push(`Link ${this.links.length + 1}`);
    }
}
