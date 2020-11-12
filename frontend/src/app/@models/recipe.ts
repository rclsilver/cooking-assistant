import { User } from './user';

export class Recipe {
  id: string | null;
  created_at: string | null;
  updated_at: string | null;
  title: string | null;
  url: string;
  image_url: string | null;
  author: User | null;
};
