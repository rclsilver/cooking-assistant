import { User } from '../auth/types';

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
