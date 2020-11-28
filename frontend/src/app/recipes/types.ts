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

export type Unit = {
  id: string;
  created_at: string;
  updated_at: string;
  label: string;
  label_plural: string | null;
}

export type UnitPayload = {
  label: string;
  label_plural: string | null;
}

export type Ingredient = {
  id: string;
  created_at: string;
  updated_at: string;
  label: string;
  label_plural: string | null;
  image_url: string | null;
};

export type IngredientPayload = {
  label: string;
  label_plural: string | null;
  image_url: string | null;
};
