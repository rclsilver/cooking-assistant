import { User } from '../auth/types';
import { Moment } from 'moment';

export type Recipe = {
  id: string | null;
  created_at: string | null;
  updated_at: string | null;
  title: string | null;
  url: string;
  image_url: string | null;
  author: User | null;
}

export type RecipeImportPayload = {
  url: string;
};

export type RecipeSchedule = {
  id: string | null;
  created_at: string | null;
  updated_at: string | null;
  date: Moment;
  recipe: Recipe;
  author: User;
};

export type RecipeSchedulePayload = {
  recipe: Recipe;
  date: Moment;
}
