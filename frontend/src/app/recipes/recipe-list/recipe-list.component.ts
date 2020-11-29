import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { Observable } from 'rxjs';
import { map, shareReplay } from 'rxjs/operators';
import { AuthService } from 'src/app/auth/auth.service';
import { ApiService } from 'src/app/shared/api.service';
import { ConfirmDialogComponent } from 'src/app/shared/confirm-dialog/confirm-dialog.component';
import { SuccessDialogComponent } from 'src/app/shared/success-dialog/success-dialog.component';
import { Recipe } from '../types';

@Component({
  selector: 'app-recipe-list',
  templateUrl: './recipe-list.component.html',
  styleUrls: ['./recipe-list.component.scss']
})
export class RecipeListComponent implements OnInit {
  recipes: Recipe[] = [];
  isHandset$: Observable<boolean> = this.breakpointObserver
    .observe(Breakpoints.Handset)
    .pipe(
      map((result) => result.matches),
      shareReplay()
    );
  isAuthenticated$: Observable<boolean> = this.auth.isAuthenticated$;
  isAdministrator$: Observable<boolean> = this.auth.isAdministrator$;

  constructor(
    private auth: AuthService,
    private api: ApiService,
    private breakpointObserver: BreakpointObserver,
    private dialog: MatDialog
  ) {}

  ngOnInit(): void {
    this.refresh();
  }

  refresh(): void {
    this.api.getRecipes()
      .then((recipes: Recipe[]) => this.recipes = recipes)
      .catch(this.api.handleServerError('Error while fetching recipes list'));
  }

  deleteRecipe(recipe: Recipe): void {
    this.dialog.open(ConfirmDialogComponent, {
      data: {
        title: 'Recipe deletion',
        message: 'Are you sure to delete this recipe?',
        confirmText: 'Yes, drop it!'
      }
    }).afterClosed().subscribe((confirm: boolean) => {
      if (confirm) {
        this.api.deleteRecipe(recipe)
          .then(() => {
            this.recipes = this.recipes.filter((item) => item.id != recipe.id);
            this.dialog.open(SuccessDialogComponent, {
              data: {
                title: 'Recipe deletion',
                message: 'Recipe has been removed'
              }
            });
          })
          .catch(this.api.handleServerError('Error while deleting recipe'));
      }
    });
  }
}
