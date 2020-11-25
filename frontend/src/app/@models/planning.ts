import { Recipe } from './recipe';

export class Day {
  date: Date;
  recipes: Array<Recipe>;
};

export class Planning {
  startDate: Date;
  endDate: Date;
  days: Array<Day>;

  constructor(date: Date) {
    // Store the date in startDate and reset hours, minutes, seconds and ms
    this.startDate = new Date(date);
    this.startDate.setHours(0, 0, 0, 0);

    // Set date to monday
    this.startDate.setDate(
      this.startDate.getDate() - this.startDate.getDay() + (
        this.startDate.getDay() === 0 ? -6 : 1
      )
    );

    // Define the end date
    this.endDate = new Date(this.startDate);
    this.endDate.setDate(
      this.startDate.getDate() + 6
    );

    this.days = [];
  }

  get previousDate(): Date {
    let date = new Date(this.startDate);
    date.setDate(date.getDate() - 1);
    return date;
  }

  get nextDate(): Date {
    let date = new Date(this.endDate);
    date.setDate(date.getDate() + 1);
    return date;
  }
};
