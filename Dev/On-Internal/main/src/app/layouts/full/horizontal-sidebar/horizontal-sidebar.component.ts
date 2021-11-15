import {
  ChangeDetectorRef,
  Component,
  NgZone,
  OnDestroy,
  ViewChild,
  HostListener,
  Directive,
  AfterViewInit
} from '@angular/core';
import { PerfectScrollbarConfigInterface } from 'ngx-perfect-scrollbar';
import { MediaMatcher } from '@angular/cdk/layout';
import { HorizontalMenuItems } from '../../../shared/menu-items/horizontal-menu-items';

@Component({
  selector: 'app-horizontal-sidebar',
  templateUrl: './horizontal-sidebar.component.html',
  styleUrls: []
})

export class HorizontalAppSidebarComponent implements OnDestroy {
  public config: PerfectScrollbarConfigInterface = {};
  mobileQuery: MediaQueryList;
  // tslint:disable-next-line - Disables all
  private _mobileQueryListener: () => void;

  constructor(
    changeDetectorRef: ChangeDetectorRef,
    media: MediaMatcher,
    public menuItems: HorizontalMenuItems
  ) {
    this.mobileQuery = media.matchMedia('(min-width: 1024px)');
    this._mobileQueryListener = () => changeDetectorRef.detectChanges();
    // tslint:disable-next-line - Disables all
    this.mobileQuery.addListener(this._mobileQueryListener);
  }

  ngOnDestroy(): void {
    // tslint:disable-next-line - Disables all
    this.mobileQuery.removeListener(this._mobileQueryListener);
  }
}
