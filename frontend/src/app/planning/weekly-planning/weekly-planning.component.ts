import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { ActivatedRoute, Params } from '@angular/router';
import { BehaviorSubject, Observable, ReplaySubject } from 'rxjs';
import { map, shareReplay } from 'rxjs/operators';
import { RecipeSchedule } from 'src/app/recipes/types';
import { ApiService } from 'src/app/shared/api.service';
import { RecipeDialogComponent } from '../recipe-dialog/recipe-dialog.component';
import { Planning, PlanningDay } from '../types';
import * as moment from 'moment';

@Component({
  selector: 'app-weekly-planning',
  templateUrl: './weekly-planning.component.html',
  styleUrls: ['./weekly-planning.component.scss'],
})
export class WeeklyPlanningComponent implements OnInit {
  private planningSubject$ = new BehaviorSubject<Planning | null>(null);
  private previousDateSubject$ = new ReplaySubject<string>();
  private nextDateSubject$ = new ReplaySubject<string>();

  isHandset$: Observable<boolean> = this.breakpointObserver
    .observe(Breakpoints.Handset)
    .pipe(
      map((result) => result.matches),
      shareReplay()
    );

  planning: Observable<Planning | null> = this.planningSubject$.asObservable();
  previousDate: Observable<string> = this.previousDateSubject$.asObservable();
  nextDate: Observable<string> = this.nextDateSubject$.asObservable();

  constructor(
    private api: ApiService,
    private route: ActivatedRoute,
    private dialog: MatDialog,
    private breakpointObserver: BreakpointObserver
  ) {}

  ngOnInit(): void {
    this.route.params.subscribe((params: Params) => {
      const date: moment.Moment = params.date ? moment(params.date) : moment();
      const startDate: moment.Moment = date.clone().local().startOf('isoWeek');
      const endDate: moment.Moment = date.clone().local().endOf('isoWeek');
      this.load(startDate, endDate);
    });
  }

  load(startDate: moment.Moment, endDate: moment.Moment): void {
    this.api
      .getPlanning(startDate, endDate)
      .then((planning: Planning) => {
        this.planningSubject$.next(planning);
        this.previousDateSubject$.next(
          planning.start_date.clone().local().subtract(1, 'd').format('Y-MM-DD')
        );
        this.nextDateSubject$.next(
          planning.end_date.clone().local().add(1, 'd').format('Y-MM-DD')
        );
      })
      .catch(this.api.handleServerError('Error while loading planning'));
  }

  show(schedule: RecipeSchedule): void {
    this.dialog
      .open(RecipeDialogComponent, {
        data: {
          schedule,
        },
      })
      .afterClosed()
      .subscribe((result: string | null) => {
        if (result === 'remove') {
          this.planningSubject$.getValue()?.days.forEach((day: PlanningDay) => {
            if (day.date.valueOf() == schedule.date.valueOf()) {
              day.schedules = day.schedules.filter((item: RecipeSchedule) => item.id != schedule.id);
            };
          });
        }
      });
  }
}
