import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ApiService } from 'src/app/shared/api.service';
import { SuccessDialogComponent } from 'src/app/shared/success-dialog/success-dialog.component';
import { Ingredient } from '../types';

@Component({
  selector: 'app-ingredient-form',
  templateUrl: './ingredient-form.component.html',
  styleUrls: ['./ingredient-form.component.scss'],
})
export class IngredientFormComponent {
  form: FormGroup;

  constructor(
    @Inject(MAT_DIALOG_DATA)
    public data: {
      ingredient: Ingredient | null;
    },
    private dialogRef: MatDialogRef<IngredientFormComponent>,
    private formBuilder: FormBuilder,
    private api: ApiService,
    private dialog: MatDialog
  ) {
    this.form = this.formBuilder.group({
      label: [
        this.data.ingredient ? this.data.ingredient.label : null,
        [Validators.required],
      ],
      label_plural: [
        this.data.ingredient ? this.data.ingredient.label_plural : null,
      ],
      image_url: [
        this.data.ingredient ? this.data.ingredient.image_url : null,
      ],
    });
  }

  cancel(): void {
    this.dialogRef.close(false);
  }

  submit(): void {
    let promise: Promise<Ingredient> = this.data.ingredient ?
      this.api.updateIngredient(this.data.ingredient, this.form.value) :
      this.api.createIngredient(this.form.value);

    promise
      .then((ingredient: Ingredient) => {
        this.dialog
          .open(SuccessDialogComponent, {
            data: {
              title: this.data.ingredient ? 'Ingredient update' : 'Ingredient creation',
              message: this.data.ingredient
                ? 'Ingredient has been updated successfully'
                : 'Ingredient has been created successfully',
            },
          })
          .afterClosed()
          .subscribe(() => this.dialogRef.close(true));
      })
      .catch(this.api.handleFormError(this.form));
  }
}
