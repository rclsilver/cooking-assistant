import { Component, Inject } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Router } from '@angular/router';
import { RecipeSchedule } from 'src/app/recipes/types';
import { ApiService } from 'src/app/shared/api.service';
import { ConfirmDialogComponent } from 'src/app/shared/confirm-dialog/confirm-dialog.component';

@Component({
  templateUrl: './recipe-dialog.component.html',
  styleUrls: ['./recipe-dialog.component.scss'],
})
export class RecipeDialogComponent {
  constructor(
    @Inject(MAT_DIALOG_DATA)
    public data: {
      schedule: RecipeSchedule
    },
    private dialogRef: MatDialogRef<RecipeDialogComponent>,
    private api: ApiService,
    private dialog: MatDialog,
    private router: Router
  ) {}

  viewRecipe(): void {
    this.router.navigate(['/recipes', this.data.schedule.recipe.id])
      .then(() => this.dialogRef.close(null));
  }

  close(): void {
    this.dialogRef.close(null);
  }

  remove(): void {
    this.dialog.open(ConfirmDialogComponent, {
      data: {
        title: 'Unschedule recipe',
        message: 'Are you sure to delete this recipe from the planning?',
        confirmText: 'Yes, remove it!'
      }
    })
      .afterClosed()
      .subscribe((confirm: boolean) => {
        if (confirm) {
          this.api
            .removePlanningRecipe(this.data.schedule)
            .then(() => {
              this.dialogRef.close('remove');
            })
            .catch(this.api.handleServerError('Error while removing schedule'));
        }
      });
  }
}
