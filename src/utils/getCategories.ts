// src/utils/getCategories.ts
interface Frontmatter {
  category?: string;
  draft?: boolean;
}

interface PostModule {
  frontmatter: Frontmatter;
}

export function getCategories(): string[] {
  const modules = import.meta.glob<PostModule>('../pages/blog/*.md', { eager: true });

  const categories = new Set<string>();
  Object.values(modules).forEach(({ frontmatter }) => {
    if (!frontmatter?.draft && frontmatter?.category) {
      categories.add(frontmatter.category);
    }
  });

  return Array.from(categories).sort();
}
