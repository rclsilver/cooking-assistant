import { Breakpoints, BreakpointObserver } from '@angular/cdk/layout';
import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef, MatDialog } from '@angular/material/dialog';
import { Observable } from 'rxjs';
import { map, shareReplay } from 'rxjs/operators';
import { Recipe, RecipeSchedulePayload } from 'src/app/recipes/types';
import { ApiService } from 'src/app/shared/api.service';
import { SuccessDialogComponent } from 'src/app/shared/success-dialog/success-dialog.component';

@Component({
  templateUrl: './recipe-planning-dialog.component.html',
  styleUrls: ['./recipe-planning-dialog.component.scss'],
})
export class RecipePlanningDialogComponent {
  form: FormGroup;
  minDate: Date = new Date();
  isHandset$: Observable<boolean> = this.breakpointObserver
    .observe(Breakpoints.Handset)
    .pipe(
      map((result) => result.matches),
      shareReplay()
    );

  constructor(
    @Inject(MAT_DIALOG_DATA)
    public data: {
      recipe: Recipe;
    },
    private dialogRef: MatDialogRef<RecipePlanningDialogComponent>,
    private api: ApiService,
    private formBuilder: FormBuilder,
    private breakpointObserver: BreakpointObserver,
    private dialog: MatDialog
  ) {
    this.form = this.formBuilder.group({
      date: [null, [Validators.required]],
    });
  }

  cancel(): void {
    this.dialogRef.close(false);
  }

  submit(): void {
    let payload: RecipeSchedulePayload = {
      recipe: this.data.recipe,
      date: this.form.value.date.utc()
    };
    this.api
      .addPlanningRecipe(payload)
      .then(() => {
        this.dialog.open(SuccessDialogComponent, {
          data: {
            title: 'Recipe schedule',
            message: 'Recipe has been scheduled',
          },
        }).afterClosed().subscribe((result: boolean) => {
          this.dialogRef.close(true)
        });
      })
      .catch(this.api.handleFormError(this.form));
  }
}
