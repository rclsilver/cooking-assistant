import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { ActivatedRoute, Params, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { map, shareReplay } from 'rxjs/operators';
import { AuthService } from 'src/app/auth/auth.service';
import { RecipePlanningDialogComponent } from 'src/app/recipes/recipe-planning-dialog/recipe-planning-dialog.component';
import { Recipe } from 'src/app/recipes/types';
import { ApiService } from 'src/app/shared/api.service';
import { ConfirmDialogComponent } from 'src/app/shared/confirm-dialog/confirm-dialog.component';
import { SuccessDialogComponent } from 'src/app/shared/success-dialog/success-dialog.component';

@Component({
  selector: 'app-recipe-view',
  templateUrl: './recipe-view.component.html',
  styleUrls: ['./recipe-view.component.scss'],
})
export class RecipeViewComponent implements OnInit {
  recipe: Recipe | null = null;
  isAuthenticated$: Observable<boolean> = this.auth.isAuthenticated$;
  isAdministrator$: Observable<boolean> = this.auth.isAdministrator$;
  isHandset$: Observable<boolean> = this.breakpointObserver
    .observe(Breakpoints.Handset)
    .pipe(
      map((result) => result.matches),
      shareReplay()
    );

  constructor(
    private route: ActivatedRoute,
    private dialog: MatDialog,
    private router: Router,
    private breakpointObserver: BreakpointObserver,
    private api: ApiService,
    private auth: AuthService
  ) {}

  ngOnInit(): void {
    this.route.params.subscribe((params: Params) => {
      this.refresh(params.id);
    });
  }

  refresh(recipeId: string | null): void {
    if (!recipeId && this.recipe) {
      recipeId = this.recipe.id;
    }

    this.api
      .getRecipe(<string>recipeId)
      .then((recipe: Recipe) => this.recipe = recipe)
      .catch(this.api.handleServerError('Error while loading recipe'));
  }

  scheduleRecipe(): void {
    this.dialog.open(RecipePlanningDialogComponent, {
      data: {
        recipe: this.recipe,
      },
    });
  }

  deleteRecipe(): void {
    this.dialog
      .open(ConfirmDialogComponent, {
        data: {
          title: 'Recipe deletion',
          message: 'Are you sure to delete this recipe?',
          confirmText: 'Yes, drop it!',
        },
      })
      .afterClosed()
      .subscribe((confirm: boolean) => {
        if (confirm) {
          this.api
            .deleteRecipe(<Recipe>this.recipe)
            .then(() => {
              this.dialog
                .open(SuccessDialogComponent, {
                  data: {
                    title: 'Recipe deletion',
                    message: 'Recipe has been removed',
                  },
                })
                .afterClosed()
                .subscribe(() => this.router.navigate(['/recipes']));
            })
            .catch(this.api.handleServerError('Error while deleting recipe'));
        }
      });
  }
}
