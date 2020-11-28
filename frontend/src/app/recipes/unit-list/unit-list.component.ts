import { Component, OnDestroy, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { Unit } from 'src/app/recipes/types';
import { ApiService } from 'src/app/shared/api.service';
import { UnitFormComponent } from 'src/app/recipes/unit-form/unit-form.component';
import { SuccessDialogComponent } from 'src/app/shared/success-dialog/success-dialog.component';
import { ConfirmDialogComponent } from 'src/app/shared/confirm-dialog/confirm-dialog.component';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { Observable, Subscription } from 'rxjs';
import { map, shareReplay } from 'rxjs/operators';

@Component({
  selector: 'app-unit-list',
  templateUrl: './unit-list.component.html',
  styleUrls: ['./unit-list.component.scss']
})
export class UnitListComponent implements OnInit, OnDestroy {
  private isHandsetSubscription$: Subscription | null = null;

  columns: string[] = [];
  units: Unit[] = [];
  isHandset$: Observable<boolean> = this.breakpointObserver
    .observe(Breakpoints.Handset)
    .pipe(
      map((result) => result.matches),
      shareReplay()
    );

  constructor(
    private api: ApiService,
    private dialog: MatDialog,
    private breakpointObserver: BreakpointObserver,
  ) { }

  ngOnInit(): void {
    this.isHandsetSubscription$ = this.breakpointObserver
      .observe(Breakpoints.Handset)
      .pipe(
        map((result) => result.matches),
        shareReplay()
      )
      .subscribe((value: boolean) => {
        this.columns = value
          ? ['label', 'label_plural', 'actions']
          : ['id', 'created_at', 'updated_at', 'label', 'label_plural', 'actions'];
      });
    this.refresh();
  }

  ngOnDestroy(): void {
    if (this.isHandsetSubscription$) {
      this.isHandsetSubscription$.unsubscribe();
    }
  }

  refresh(): void {
    this.api.getUnits()
      .then((units: Unit[]) => this.units = units)
      .catch(this.api.handleServerError('Error while loading units list'));
  }

  createUnit(): void {
    this.dialog.open(UnitFormComponent, {
      data: {
        unit: null
      }
    }).afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.refresh();
      }
    });
  }

  editUnit(unit: Unit): void {
    this.dialog.open(UnitFormComponent, {
      data: {
        unit
      }
    }).afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.refresh();
      }
    });
  }

  deleteUnit(unit: Unit): void {
    console.log('delete', unit);
    this.dialog.open(ConfirmDialogComponent, {
      data: {
        title: 'Unit deletion',
        message: 'Are you sure to delete this unit?',
        confirmText: 'Yes, drop it!'
      }
    }).afterClosed().subscribe((confirm: boolean) => {
      if (confirm) {
        this.api.deleteUnit(unit)
          .then(() => {
            this.units = this.units.filter((item) => item.id != unit.id);
            this.dialog.open(SuccessDialogComponent, {
              data: {
                title: 'Unit deletion',
                message: 'Unit has been removed'
              }
            });
          })
          .catch(this.api.handleServerError('Error while deleting unit'));
      }
    });
  }
}
