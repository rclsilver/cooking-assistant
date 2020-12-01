import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Recipe, RecipeStep } from 'src/app/recipes/types';
import { ApiService } from 'src/app/shared/api.service';
import { SuccessDialogComponent } from 'src/app/shared/success-dialog/success-dialog.component';

@Component({
  templateUrl: './recipe-step-form-dialog.component.html',
  styleUrls: ['./recipe-step-form-dialog.component.scss'],
})
export class RecipeStepFormDialogComponent {
  form: FormGroup;

  constructor(
    @Inject(MAT_DIALOG_DATA)
    public data: {
      recipe: Recipe;
      step: RecipeStep | null;
    },
    private dialogRef: MatDialogRef<RecipeStepFormDialogComponent>,
    private api: ApiService,
    private formBuilder: FormBuilder,
    private dialog: MatDialog
  ) {
    this.form = this.formBuilder.group({
      content: [this.data.step ? this.data.step.content : null, [Validators.required]],
    });
  }

  cancel(): void {
    this.dialogRef.close();
  }

  submit(): void {
    const payload = Object.assign(
      {
        order: this.data.step ? this.data.step.order : null,
        content: this.data.step ? this.data.step.content : null,
      },
      this.form.value
    );
    const promise: Promise<RecipeStep> = this.data.step
      ? this.api.updateRecipeStep(this.data.recipe, this.data.step, payload)
      : this.api.addRecipeStep(this.data.recipe, payload);

    promise
      .then((step: RecipeStep) => {
        this.dialog
          .open(SuccessDialogComponent, {
            data: {
              title: this.data.step
                ? 'Step update'
                : 'Step creation',
              message: this.data.step
                ? 'Step has been updated successfully'
                : 'Step has been created successfully',
            },
          })
          .afterClosed()
          .subscribe(() => this.dialogRef.close(step));
      })
      .catch(this.api.handleFormError(this.form));
  }
}
