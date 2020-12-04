import { NgModule } from '@angular/core';
import { Routes, RouterModule, ExtraOptions } from '@angular/router';
import { RequireAdminGuard } from './auth/require-admin.guard';
import { RequireUserGuard } from './auth/require-user.guard';
import { RecipeImportFormComponent } from './recipes/recipe-import-form/recipe-import-form.component';
import { WeeklyPlanningComponent } from './planning/weekly-planning/weekly-planning.component';
import { RecipeListComponent } from './recipes/recipe-list/recipe-list.component';
import { UnitListComponent } from './recipes/unit-list/unit-list.component';

const routes: Routes = [
  {
    path: 'recipes',
    component: RecipeListComponent,
  },
  {
    path: 'recipes/import',
    component: RecipeImportFormComponent,
    canActivate: [RequireUserGuard]
  },
  {
    path: 'units',
    component: UnitListComponent,
    canActivate: [RequireAdminGuard]
  },
  {
    path: 'planning',
    component: WeeklyPlanningComponent,
    canActivate: [RequireUserGuard]
  },
  {
    path: 'planning/:date',
    component: WeeklyPlanningComponent,
    canActivate: [RequireUserGuard]
  },
  {
    path: '',
    redirectTo: '/recipes',
    pathMatch: 'full',
  },
];

const config: ExtraOptions = {
  useHash: true,
  initialNavigation: 'disabled'
};

@NgModule({
  imports: [RouterModule.forRoot(routes, config)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
