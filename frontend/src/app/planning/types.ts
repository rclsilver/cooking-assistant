import { RecipeSchedule } from 'src/app/recipes/types'

export type PlanningDay = {
  date: moment.Moment;
  schedules: RecipeSchedule[];
}

export type Planning = {
  start_date: moment.Moment;
  end_date: moment.Moment;
  days: PlanningDay[];
}
