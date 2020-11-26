import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { ServerErrorDialogComponent } from 'src/app/shared/server-error-dialog/server-error-dialog.component';
import { ControllerError, ValidationError } from 'src/app/shared/types';
import { Recipe, RecipeImportPayload } from '../recipes/types';

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

  importRecipe(payload: RecipeImportPayload): Promise<Recipe> {
    return this.http.post<Recipe>('/api/recipes/import', payload).toPromise();
  }

  deleteRecipe(recipe: Recipe): Promise<null> {
    return this.http.delete<null>(`/api/recipes/${recipe.id}`).toPromise();
  }
}
