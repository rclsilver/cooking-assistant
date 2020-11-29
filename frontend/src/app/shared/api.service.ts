import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { ServerErrorDialogComponent } from 'src/app/shared/server-error-dialog/server-error-dialog.component';
import { ControllerError, ValidationError } from 'src/app/shared/types';
import { Recipe, RecipeImportPayload, RecipeSchedule, RecipeSchedulePayload } from 'src/app/recipes/types';
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

  importRecipe(payload: RecipeImportPayload): Promise<Recipe> {
    return this.http.post<Recipe>('/api/recipes/import', payload).toPromise();
  }

  deleteRecipe(recipe: Recipe): Promise<null> {
    return this.http.delete<null>(`/api/recipes/${recipe.id}`).toPromise();
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
}
