import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { ServerErrorDialogComponent } from 'src/app/shared/server-error-dialog/server-error-dialog.component';
import { ControllerError, ValidationError } from 'src/app/shared/types';
import { Recipe, RecipeCreatePayload, RecipeImportPayload, RecipeStepCreatePayload, RecipeStep, RecipeStepUpdatePayload, RecipeIngredientCreatePayload, RecipeIngredient, RecipeIngredientUpdatePayload, RecipeSchedule, RecipeSchedulePayload, Unit, UnitPayload, Ingredient, IngredientPayload } from 'src/app/recipes/types';
import { Planning, PlanningDay } from '../planning/types';
import * as moment from 'moment';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class ApiService {
  constructor(
    private http: HttpClient,
    private dialog: MatDialog
  ) {}

  handleFormError(form: FormGroup) {
    const that = this;

    return (error: HttpErrorResponse) => {
      if (error.status === 422) {
        const validationError: ValidationError = error.error;
        validationError.detail.forEach((detail) => form.controls[detail.loc[1]].setErrors({ server: detail.msg }));
      } else if (error.status === 409) {
        const controllerError: ControllerError = error.error;
        controllerError.context.fields.forEach(field => form.controls[field].setErrors({ server: controllerError.message }));
      } else {
        that.handleServerError()(error);
      }
    };
  }

  handleServerError(title?: string) {
    const that = this;

    return (error: HttpErrorResponse) => {
      if (error.status === 500) {
        that.dialog.open(ServerErrorDialogComponent, {
          data: {
            title: title ? title : 'Internal server error',
            message: 'Internal server error',
            error: error
          },
        });
      } else {
        that.dialog.open(ServerErrorDialogComponent, {
          data: {
            title: title ? title : 'Internal server error',
            message: error.error.message,
            error: error
          }
        });
      }
    }
  }

  getRecipes(): Promise<Recipe[]> {
    return this.http.get<Recipe[]>('/api/recipes/').toPromise();
  }

  getRecipe(recipeId: string): Promise<Recipe> {
    return this.http.get<Recipe>(`/api/recipes/${recipeId}`).toPromise();
  }

  createRecipe(payload: RecipeCreatePayload): Promise<Recipe> {
    return this.http.post<Recipe>('/api/recipes/', payload).toPromise();
  }

  importRecipe(payload: RecipeImportPayload): Promise<Recipe> {
    return this.http.post<Recipe>('/api/recipes/import', payload).toPromise();
  }

  deleteRecipe(recipe: Recipe): Promise<null> {
    return this.http.delete<null>(`/api/recipes/${recipe.id}`).toPromise();
  }

  addRecipeStep(recipe: Recipe, payload: RecipeStepCreatePayload): Promise<RecipeStep> {
    return this.http.post<RecipeStep>(`/api/recipes/${recipe.id}/steps/`, payload).toPromise();
  }

  updateRecipeStep(recipe: Recipe, step: RecipeStep, payload: RecipeStepUpdatePayload): Promise<RecipeStep> {
    return this.http.put<RecipeStep>(`/api/recipes/${recipe.id}/steps/${step.id}`, payload).toPromise();
  }

  removeRecipeStep(recipe: Recipe, step: RecipeStep): Promise<null> {
    return this.http.delete<null>(`/api/recipes/${recipe.id}/steps/${step.id}`).toPromise();
  }

  addRecipeIngredient(recipe: Recipe, payload: RecipeIngredientCreatePayload): Promise<RecipeIngredient> {
    return this.http.post<RecipeIngredient>(`/api/recipes/${recipe.id}/ingredients/`, payload).toPromise();
  }

  updateRecipeIngredient(recipe: Recipe, ingredient: RecipeIngredient, payload: RecipeIngredientUpdatePayload): Promise<RecipeIngredient> {
    return this.http.put<RecipeIngredient>(`/api/recipes/${recipe.id}/ingredients/${ingredient.id}`, payload).toPromise();
  }

  removeRecipeIngredient(recipe: Recipe, ingredient: RecipeIngredient): Promise<null> {
    return this.http.delete<null>(`/api/recipes/${recipe.id}/ingredients/${ingredient.id}`).toPromise();
  }

  getPlanning(startDate: moment.Moment, endDate: moment.Moment): Promise<Planning> {
    return this.http
      .get<Planning>('/api/planning/', {
        params: {
          start_date: startDate.local().format('Y-M-D'),
          end_date: endDate.local().format('Y-M-D')
        }
      })
      .pipe(
        map(response => {
          response.start_date = moment(response.start_date);
          response.end_date = moment(response.end_date);

          response.days.forEach((day: PlanningDay) => {
            day.date = moment(day.date);

            day.schedules.forEach((schedule: RecipeSchedule) => {
              schedule.date = moment(schedule.date);
            });
          });

          return response;
        })
      )
      .toPromise();
  }

  addPlanningRecipe(payload: RecipeSchedulePayload): Promise<RecipeSchedule> {
    return this.http.post<RecipeSchedule>(`/api/recipes/${payload.recipe.id}/schedules`, {
      date: payload.date.local().format('Y-M-D')
    }).toPromise();
  }

  removePlanningRecipe(schedule: RecipeSchedule): Promise<null> {
    return this.http.delete<null>(`/api/recipes/${schedule.recipe.id}/schedules/${schedule.id}`)
      .toPromise();
  }

  getUnits(): Promise<Unit[]> {
    return this.http.get<Unit[]>('/api/units/').toPromise();
  }

  createUnit(payload: UnitPayload): Promise<Unit> {
    return this.http.post<Unit>('/api/units/', {
      label: payload.label,
      label_plural: payload.label_plural ? payload.label_plural : null
    }).toPromise();
  }

  updateUnit(unit: Unit, payload: UnitPayload): Promise<Unit> {
    return this.http.put<Unit>(`/api/units/${unit.id}`, {
      label: payload.label,
      label_plural: payload.label_plural ? payload.label_plural : null
    }).toPromise();
  }

  deleteUnit(unit: Unit): Promise<null> {
    return this.http.delete<null>(`/api/units/${unit.id}`).toPromise();
  }

  getIngredients(): Promise<Ingredient[]> {
    return this.http.get<Ingredient[]>('/api/ingredients/').toPromise();
  }

  createIngredient(payload: IngredientPayload): Promise<Ingredient> {
    return this.http.post<Ingredient>('/api/ingredients/', {
      label: payload.label,
      label_plural: payload.label_plural ? payload.label_plural : null,
      image_url: payload.image_url ? payload.image_url : null
    }).toPromise();
  }

  updateIngredient(ingredient: Ingredient, payload: IngredientPayload): Promise<Ingredient> {
    return this.http.put<Ingredient>(`/api/ingredients/${ingredient.id}`, {
      label: payload.label,
      label_plural: payload.label_plural ? payload.label_plural : null,
      image_url: payload.image_url ? payload.image_url : null
    }).toPromise();
  }

  deleteIngredient(ingredient: Ingredient): Promise<null> {
    return this.http.delete<null>(`/api/ingredients/${ingredient.id}`).toPromise();
  }
}
