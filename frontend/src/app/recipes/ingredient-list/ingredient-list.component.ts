import { Component, OnDestroy, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { Ingredient } from 'src/app/recipes/types';
import { ApiService } from 'src/app/shared/api.service';
import { IngredientFormComponent } from 'src/app/recipes/ingredient-form/ingredient-form.component';
import { SuccessDialogComponent } from 'src/app/shared/success-dialog/success-dialog.component';
import { ConfirmDialogComponent } from 'src/app/shared/confirm-dialog/confirm-dialog.component';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { Observable, Subscription } from 'rxjs';
import { map, shareReplay } from 'rxjs/operators';

@Component({
  selector: 'app-ingredient-list',
  templateUrl: './ingredient-list.component.html',
  styleUrls: ['./ingredient-list.component.scss']
})
export class IngredientListComponent implements OnInit, OnDestroy {
  private isHandsetSubscription$: Subscription | null = null;

  columns: string[] = [];
  ingredients: Ingredient[] = [];
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
          ? ['label', 'label_plural', 'image_url', 'actions']
          : ['id', 'created_at', 'updated_at', 'label', 'label_plural', 'image_url', 'actions'];
      });
    this.refresh();
  }

  ngOnDestroy(): void {
    if (this.isHandsetSubscription$) {
      this.isHandsetSubscription$.unsubscribe();
    }
  }

  refresh(): void {
    this.api.getIngredients()
      .then((ingredients: Ingredient[]) => this.ingredients = ingredients)
      .catch(this.api.handleServerError('Error while loading ingredients'));
  }

  createIngredient(): void {
    this.dialog.open(IngredientFormComponent, {
      data: {
        ingredient: null
      }
    }).afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.refresh();
      }
    });
  }

  editIngredient(ingredient: Ingredient): void {
    this.dialog.open(IngredientFormComponent, {
      data: {
        ingredient
      }
    }).afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.refresh();
      }
    });
  }

  deleteIngredient(ingredient: Ingredient): void {
    console.log('delete', ingredient);
    this.dialog.open(ConfirmDialogComponent, {
      data: {
        title: 'Ingredient deletion',
        message: 'Are you sure to delete this ingredient?',
        confirmText: 'Yes, drop it!'
      }
    }).afterClosed().subscribe((confirm: boolean) => {
      if (confirm) {
        this.api.deleteIngredient(ingredient)
          .then(() => {
            this.ingredients = this.ingredients.filter((item) => item.id != ingredient.id);
            this.dialog.open(SuccessDialogComponent, {
              data: {
                title: 'Ingredient deletion',
                message: 'Ingredient has been removed'
              }
            });
          })
          .catch(this.api.handleServerError('Error while deleting ingredient'));
      }
    });
  }
}
