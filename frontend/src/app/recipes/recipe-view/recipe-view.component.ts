import { CdkDragDrop } from '@angular/cdk/drag-drop';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { ActivatedRoute, Params, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { map, shareReplay } from 'rxjs/operators';
import { AuthService } from 'src/app/auth/auth.service';
import { RecipeIngredientFormDialogComponent } from 'src/app/recipes/recipe-ingredient-form-dialog/recipe-ingredient-form-dialog.component';
import { RecipePlanningDialogComponent } from 'src/app/recipes/recipe-planning-dialog/recipe-planning-dialog.component';
import { RecipeStepFormDialogComponent } from 'src/app/recipes/recipe-step-form-dialog/recipe-step-form-dialog.component';
import { Recipe, RecipeIngredient, RecipeStep, RecipeStepUpdatePayload, RecipeUpdatePayload } from 'src/app/recipes/types';
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
  editMode: boolean = false;
  form: FormGroup;

  constructor(
    private route: ActivatedRoute,
    private dialog: MatDialog,
    private router: Router,
    private breakpointObserver: BreakpointObserver,
    private api: ApiService,
    private auth: AuthService,
    private formBuilder: FormBuilder
  ) {
    this.form = this.formBuilder.group({});
  }

  ngOnInit(): void {
    this.route.params.subscribe((params: Params) => {
      this.refresh(params.id);
    });
  }

  refresh(recipeId: string | null = null): void {
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

  toggleEdit(): void {
    this.editMode = !this.editMode;

    if (this.editMode) {
      this.form = this.formBuilder.group({
        title: [this.recipe!.title, [Validators.required]],
        image_url: [this.recipe!.image_url, []]
      });
    }
  }

  updateRecipe(): void {
    this.api
      .updateRecipe(this.recipe!, this.form.value)
      .then(() => this.refresh())
      .catch(this.api.handleFormError(this.form));
  }

  addIngredient(): void {
    this.dialog
      .open(RecipeIngredientFormDialogComponent, {
        data: {
          recipe: this.recipe,
          ingredient: null,
        },
      })
      .afterClosed()
      .subscribe((ingredient: RecipeIngredient | null) => {
        if (ingredient) {
          this.refresh();
        }
      });
  }

  editIngredient(ingredient: RecipeIngredient): void {
    this.dialog
      .open(RecipeIngredientFormDialogComponent, {
        data: {
          recipe: this.recipe,
          ingredient: ingredient,
        },
      })
      .afterClosed()
      .subscribe((ingredient: RecipeIngredient | null) => {
        if (ingredient) {
          this.refresh();
        }
      });
  }

  removeIngredient(ingredient: RecipeIngredient): void {
    this.dialog
      .open(ConfirmDialogComponent, {
        data: {
          title: 'Ingredient deletion',
          message: 'Are you sure to delete this ingredient?',
          confirmText: 'Yes, drop it!',
        },
      })
      .afterClosed()
      .subscribe((confirm: boolean) => {
        if (confirm) {
          this.api
            .removeRecipeIngredient(<Recipe>this.recipe, ingredient)
            .then(() => {
              (<Recipe>this.recipe).ingredients = (<Recipe>(
                this.recipe
              )).ingredients.filter(
                (item: RecipeIngredient) => item.id !== ingredient.id
              );
              this.dialog.open(SuccessDialogComponent, {
                data: {
                  title: 'Ingredient deletion',
                  message: 'Ingredient has been removed',
                },
              });
            })
            .catch(this.api.handleServerError('Error while removing ingredient'));
        }
      });
  }

  addStep(): void {
    this.dialog
      .open(RecipeStepFormDialogComponent, {
        data: {
          recipe: this.recipe,
          step: null,
        },
      })
      .afterClosed()
      .subscribe((step: RecipeStep | null) => {
        if (step) {
          this.refresh();
        }
      });
  }

  editStep(step: RecipeStep): void {
    this.dialog
      .open(RecipeStepFormDialogComponent, {
        data: {
          recipe: this.recipe,
          step: step,
        },
      })
      .afterClosed()
      .subscribe((step: RecipeStep | null) => {
        if (step) {
          this.refresh();
        }
      });
  }

  editStepOrder($event: CdkDragDrop<RecipeStep[]>): void {
    const step: RecipeStep = $event.container.data[$event.previousIndex];

    if ($event.previousIndex !== $event.currentIndex) {
      const payload: RecipeStepUpdatePayload = Object.assign(step, {
        order: $event.currentIndex + 1,
      });
      this.api
        .updateRecipeStep(<Recipe>this.recipe, step, payload)
        .then(() => this.refresh())
        .catch(this.api.handleServerError('Error while updating step order'));
    }
  }

  removeStep(step: RecipeStep): void {
    this.dialog
      .open(ConfirmDialogComponent, {
        data: {
          title: 'Step deletion',
          message: 'Are you sure to delete this step?',
          confirmText: 'Yes, drop it!',
        },
      })
      .afterClosed()
      .subscribe((confirm: boolean) => {
        if (confirm) {
          this.api
            .removeRecipeStep(<Recipe>this.recipe, step)
            .then(() => {
              (<Recipe>this.recipe).steps = (<Recipe>this.recipe).steps.filter(
                (item: RecipeStep) => item.id !== step.id
              );
              this.dialog.open(SuccessDialogComponent, {
                data: {
                  title: 'Step deletion',
                  message: 'Step has been removed',
                },
              });
            })
            .catch(this.api.handleServerError('Error while removing step'));
        }
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
